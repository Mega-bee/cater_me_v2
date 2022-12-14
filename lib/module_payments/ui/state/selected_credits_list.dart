import 'package:cater_me_v2/consts/globale_cart.dart';
import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_credits/response/credit_response.dart';
import 'package:cater_me_v2/module_credits/ui/widget/credit_card.dart';
import 'package:cater_me_v2/module_payments/request/payment_request.dart';
import 'package:cater_me_v2/module_payments/ui/screens/payment_method_screen.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
// import 'package:mad_pay/mad_pay.dart';
import '../../../abstracts/states/state.dart';

class SelectedCreditsListSuccess extends States {
  final List<CreditsResponse> creditsList;

  PaymentMethodScreenState screenState;

  SelectedCreditsListSuccess(
      {required this.creditsList, required this.screenState});

  CreditsResponse? _selectedCard;
  Pay _payClient = Pay.withAssets([
    'default_payment_profile_apple_pay.json',
    'default_payment_profile_google_pay.json'
  ]);
   var _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '1',
      status: PaymentItemStatus.final_price,
    )
  ];
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
              SizedBox(
                height: 160,
              ),
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
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: () {
                            print('pressss');
                            screenState.requestPayment(PaymentTypeRequest(
                                cardId: _selectedCard?.cardId ?? ''));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.payment),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  S.of(context).payNow,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )),
                    )
                  : Container(),

              GooglePayButton(
                paymentConfigurationAsset:
                    'default_payment_profile_google_pay.json',
                paymentItems: _paymentItems,
                type: GooglePayButtonType.plain,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: onGooglePayResult,
                onPressed: onGooglePayPressed,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              ApplePayButton(
                  paymentConfigurationAsset:
                      'default_payment_profile_apple_pay.json',
                  paymentItems: _paymentItems,
                  style: ApplePayButtonStyle.black,
                  type: ApplePayButtonType.plain,
                  margin: const EdgeInsets.only(top: 15.0),
                  onPaymentResult: onApplePayResult,
                  onPressed: onApplePayPressed,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  )),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        )
      ],
    );
  }
  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }
  void onGooglePayPressed() async {
    final result = await _payClient.showPaymentSelector(
      provider: PayProvider.google_pay,
      paymentItems: _paymentItems,
    );
    // Send the resulting Google Pay token to your server / PSP
  }
  void onApplePayPressed() async {
    final result = await _payClient.showPaymentSelector(
      provider: PayProvider.apple_pay,
      paymentItems: _paymentItems,
    );
    // Send the resulting Google Pay token to your server / PSP
  }
  double calculateTotalPrice() {
    double price = 0;
    itemsInCart.forEach((element) {
      price = price + element.price!;
    });
    return price;
  }
}
