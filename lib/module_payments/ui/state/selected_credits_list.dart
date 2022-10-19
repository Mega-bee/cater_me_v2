import 'package:cater_me_v2/consts/globale_cart.dart';
import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_credits/response/credit_response.dart';
import 'package:cater_me_v2/module_credits/ui/widget/credit_card.dart';
import 'package:cater_me_v2/module_payments/request/payment_request.dart';
import 'package:cater_me_v2/module_payments/ui/screens/payment_method_screen.dart';
import 'package:flutter/material.dart';
import 'package:mad_pay/mad_pay.dart';
import '../../../abstracts/states/state.dart';

class SelectedCreditsListSuccess extends States {
  final List<CreditsResponse> creditsList;

  PaymentMethodScreenState screenState;

  SelectedCreditsListSuccess(
      {required this.creditsList, required this.screenState});
  CreditsResponse? _selectedCard;

  final AppleParameters appleParameters = AppleParameters(
    merchantIdentifier: 'example_id',
    billingContact: Contact(
      emailAddress: 'test@test.com',
      postalAddress: PostalAddress(
        street: 's',
        city: 'c',
        state: 'st',
        postalCode: '123321',
        country: 'ct',
      ),
      name: PersonNameComponents(
        familyName: 'qwe',
        middleName: 'ewq',
        namePrefix: 'a',
        nameSuffix: 'h',
        nickname: 'test',
        phoneticRepresentation: PersonNameComponents(
          middleName: 'ewq2',
          givenName: 'rty2',
          namePrefix: 'a2',
          nameSuffix: 'h2',
          nickname: 'test2',
        ),
      ),
    ),
    shippingContact: Contact(
      emailAddress: 'test@test.com',
    ),
    merchantCapabilities: <MerchantCapabilities>[
      MerchantCapabilities.threeds,
      MerchantCapabilities.credit,
    ],
  );

  final GoogleParameters googleParameters = GoogleParameters(
    gatewayName: 'merchant',
    gatewayMerchantId: '01234567890123456789',
    merchantId: '01234567890123456789',
    merchantName: 'Example Merchant Name',
    cardParameters: CardParameters(
      billingAddressRequired: true,
      billingAddressParameters: BillingAddressParameters(
        billingFormat: BillingFormat.full,
        phoneNumberRequired: true,
      ),
    ),
    // transactionInfo: TransactionInfo(
    //   totalPriceLabel: 'Test',
    //   checkoutOption: CheckoutOption.completeImmediatePurchase,
    // ),
    shippingAddressRequired: true,
    shippingAddressParameters: ShippingAddressParameters(
      phoneNumberRequired: true,
    ),
  );

  @override
  Widget getUI(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                itemBuilder: (context, index) => CreditCard(
                  onSelect: () {
                    creditsList.forEach((element) {
                      element.selected = false;
                    });
                    creditsList[index].selected = true;
                    _selectedCard = creditsList[index];
                    screenState.refresh();
                  },
                  isSelectedPage: true,
                  model: creditsList[index],
                  onDelete: () {},
                ),
                itemCount: creditsList.length,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
              ),
              SizedBox(height: 160,),
            ],
          ),
        ),

        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            _selectedCard != null
                ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {
                    print('pressss');
                    screenState.requestPayment(PaymentTypeRequest(cardId: _selectedCard?.cardId ??''));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.payment),
                        SizedBox(width: 10,),
                        Text(S.of(context).payNow , style: TextStyle(fontSize: 18 , color: Colors.white , fontWeight: FontWeight.bold),),
                      ],
                    ),
                  )),
            ) : Container(),
            AdaptivePayButton(
              applePayButton: ApplePayButton(
                style: ApplePayButtonStyle.automatic,
                type: ApplePayButtonType.plain,
                width: double.maxFinite,
                request: PaymentRequest.apple(
                  apple: appleParameters,
                  currencyCode: 'SAR',
                  countryCode: 'SA',
                  paymentItems: [
                    PaymentItem(name: 'Caterme', price: calculateTotalPrice())
                  ],
                ),
                onPaymentResult: (PaymentResponse? req) {
                  if(req != null){
                    screenState.requestPayment(PaymentTypeRequest(type:'applepay'));
                  }
                },
                onError: (Object? e) {

                },
              ),
              googlePayButton: GooglePayButton(
                type: GooglePayButtonType.plain,
                width: double.maxFinite,
                request: PaymentRequest.google(
                  paymentNetworks: <PaymentNetwork>[
                    PaymentNetwork.amex,
                    PaymentNetwork.discover,
                    PaymentNetwork.interac,
                    PaymentNetwork.jcb,
                    PaymentNetwork.mastercard,
                    PaymentNetwork.visa,
                    PaymentNetwork.mir,
                  ],
                  google: googleParameters,
                  currencyCode: 'SAR',
                  countryCode: 'SA',
                  paymentItems: [
                    PaymentItem(name: 'Caterme', price: calculateTotalPrice())
                  ],
                ),
                onPaymentResult: (PaymentResponse? req) {
                  if(req != null){
                    screenState.requestPayment(PaymentTypeRequest(type:'googlepay'));
                  }
                },
                onError: (Object? e) {

                },
              ),
            ),

          ],),
        )
      ],
    );
  }

 double calculateTotalPrice(){
    double price = 0;
    itemsInCart.forEach((element) {
      price = price + element.price!;
    });
    return price;
  }
}
