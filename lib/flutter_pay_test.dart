import 'package:flutter/material.dart';
import 'package:mad_pay/mad_pay.dart';

void main() {
  runApp(MyApp());
}

/// Test app
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MadPay pay = MadPay();

  final List<PaymentItem> items = <PaymentItem>[
    PaymentItem(name: 'T-Shirt', price: 2.98),
    PaymentItem(name: 'Trousers', price: 15.24),
  ];

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

  String result = 'Result will be shown here';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(result),
              TextButton(
                onPressed: () async {
                  try {
                    final bool req = await pay.checkPayments();
                    setState(() {
                      result = 'Can make payments: $req';
                    });
                  } catch (e) {
                    setState(() {
                      result = 'Error:\n$e';
                    });
                  }
                },
                child: const Text('Can make payments?'),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    final bool req = await pay.checkActiveCard(
                      paymentNetworks: <PaymentNetwork>[
                        PaymentNetwork.visa,
                        PaymentNetwork.mastercard,
                      ],
                    );
                    setState(() {
                      result = 'Can make payments with verified card: $req';
                    });
                  } catch (e) {
                    setState(() {
                      result = 'Error:\n$e';
                    });
                  }
                },
                child: const Text('Can make payments with verified card?'),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    final PaymentResponse? req = await pay.processingPayment(
                      PaymentRequest(
                        google: googleParameters,
                        apple: appleParameters,
                        currencyCode: 'USD',
                        countryCode: 'US',
                        paymentItems: items,
                        paymentNetworks: <PaymentNetwork>[
                          PaymentNetwork.visa,
                          PaymentNetwork.mastercard,
                        ],
                      ),
                    );
                    setState(() {
                      result = 'Try to pay:\n${req?.token}';
                    });
                  } catch (e) {
                    setState(() {
                      result = 'Error:\n$e';
                    });
                  }
                },
                child: const Text('Try to pay?'),
              ),
              AdaptivePayButton(
                applePayButton: ApplePayButton(
                  style: ApplePayButtonStyle.automatic,
                  type: ApplePayButtonType.buy,
                  request: PaymentRequest.apple(
                    apple: appleParameters,
                    currencyCode: 'USD',
                    countryCode: 'US',
                    paymentItems: items,
                  ),
                  onPaymentResult: (PaymentResponse? req) {
                    setState(() {
                      result = 'ApplePayButton, Try to pay:\n${req?.token}';
                    });
                  },
                  onError: (Object? e) {
                    setState(() {
                      result = 'ApplePayButton, Error:\n$e';
                    });
                  },
                ),
                googlePayButton: GooglePayButton(
                  type: GooglePayButtonType.plain,
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
                    currencyCode: 'USD',
                    countryCode: 'US',
                    paymentItems: items,
                  ),
                  onPaymentResult: (PaymentResponse? req) {
                    setState(() {
                      result = 'GooglePayButton, Try to pay:\n${req?.token}';
                    });
                  },
                  onError: (Object? e) {
                    setState(() {
                      result = 'GooglePayButton, Error:\n$e';
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}










// /// Copyright 2021 Google LLC
// ///
// /// Licensed under the Apache License, Version 2.0 (the "License");
// /// you may not use this file except in compliance with the License.
// /// You may obtain a copy of the License at
// ///
// ///     https://www.apache.org/licenses/LICENSE-2.0
// ///
// /// Unless required by applicable law or agreed to in writing, software
// /// distributed under the License is distributed on an "AS IS" BASIS,
// /// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// /// See the License for the specific language governing permissions and
// /// limitations under the License.
//
// import 'package:cater_me_v2/utils/images/images.dart';
// import 'package:flutter/material.dart';
// import 'package:mad_pay/mad_pay.dart';
// import 'package:pay/pay.dart';
// import 'package:pay_android/pay_android.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
//
// void main() {
//   runApp(PayMaterialApp());
// }
//
//
// const _paymentItems = [
//   PaymentItem(
//     label: 'Total',
//     amount: '1',
//     status: PaymentItemStatus.final_price,
//   )
// ];
//
//
//
//
//
// class MAdPayApp extends StatefulWidget {
//   const MAdPayApp({Key? key}) : super(key: key);
//
//   @override
//   State<MAdPayApp> createState() => _MAdPayAppState();
// }
//
// class _MAdPayAppState extends State<MAdPayApp> {
//   final MadPay pay = MadPay();
//
//   final List<PaymentItem> items = <PaymentItem>[
//     PaymentItem(name: 'T-Shirt', price: 2.98),
//     PaymentItem(name: 'Trousers', price: 15.24),
//   ];
//
//   final AppleParameters appleParameters = AppleParameters(
//     merchantIdentifier: 'example_id',
//     billingContact: Contact(
//       emailAddress: 'test@test.com',
//       postalAddress: PostalAddress(
//         street: 's',
//         city: 'c',
//         state: 'st',
//         postalCode: '123321',
//         country: 'ct',
//       ),
//       name: PersonNameComponents(
//         familyName: 'qwe',
//         middleName: 'ewq',
//         namePrefix: 'a',
//         nameSuffix: 'h',
//         nickname: 'test',
//         phoneticRepresentation: PersonNameComponents(
//           middleName: 'ewq2',
//           givenName: 'rty2',
//           namePrefix: 'a2',
//           nameSuffix: 'h2',
//           nickname: 'test2',
//         ),
//       ),
//     ),
//     shippingContact: Contact(
//       emailAddress: 'test@test.com',
//     ),
//     merchantCapabilities: <MerchantCapabilities>[
//       MerchantCapabilities.threeds,
//       MerchantCapabilities.credit,
//     ],
//   );
//
//   final GoogleParameters googleParameters = GoogleParameters(
//     gatewayName: 'example',
//     gatewayMerchantId: 'example_id',
//     merchantId: 'TEST',
//     merchantName: 'Test',
//     cardParameters: CardParameters(
//       billingAddressRequired: true,
//       billingAddressParameters: BillingAddressParameters(
//         billingFormat: BillingFormat.full,
//         phoneNumberRequired: true,
//       ),
//     ),
//     transactionInfo: TransactionInfo(
//       totalPriceLabel: 'Test',
//       checkoutOption: CheckoutOption.completeImmediatePurchase,
//     ),
//     shippingAddressRequired: true,
//     shippingAddressParameters: ShippingAddressParameters(
//       phoneNumberRequired: true,
//     ),
//   );
//
//   String result = 'Result will be shown here';
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(result),
//               TextButton(
//                 onPressed: () async {
//                   try {
//                     final bool req = await pay.checkPayments();
//                     setState(() {
//                       result = 'Can make payments: $req';
//                     });
//                   } catch (e) {
//                     setState(() {
//                       result = 'Error:\n$e';
//                     });
//                   }
//                 },
//                 child: const Text('Can make payments?'),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   try {
//                     final bool req = await pay.checkActiveCard(
//                       paymentNetworks: <PaymentNetwork>[
//                         PaymentNetwork.visa,
//                         PaymentNetwork.mastercard,
//                       ],
//                     );
//                     setState(() {
//                       result = 'Can make payments with verified card: $req';
//                     });
//                   } catch (e) {
//                     setState(() {
//                       result = 'Error:\n$e';
//                     });
//                   }
//                 },
//                 child: const Text('Can make payments with verified card?'),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   try {
//                     final PaymentResponse? req = await pay.processingPayment(
//                       PaymentRequest(
//                         google: googleParameters,
//                         apple: appleParameters,
//                         currencyCode: 'USD',
//                         countryCode: 'US',
//                         paymentItems: _paymentItems,
//                         paymentNetworks: <PaymentNetwork>[
//                           PaymentNetwork.visa,
//                           PaymentNetwork.mastercard,
//                         ],
//                       ),
//                     );
//                     setState(() {
//                       result = 'Try to pay:\n${req?.token}';
//                     });
//                   } catch (e) {
//                     setState(() {
//                       result = 'Error:\n$e';
//                     });
//                   }
//                 },
//                 child: const Text('Try to pay?'),
//               ),
//               AdaptivePayButton(
//                 applePayButton: ApplePayButton(
//                   style: ApplePayButtonStyle.automatic,
//                   type: ApplePayButtonType.buy,
//                   request: PaymentRequest.apple(
//                     apple: appleParameters,
//                     currencyCode: 'USD',
//                     countryCode: 'US',
//                     paymentItems: items,
//                   ),
//                   onPaymentResult: (PaymentResponse? req) {
//                     setState(() {
//                       result = 'ApplePayButton, Try to pay:\n${req?.token}';
//                     });
//                   },
//                   onError: (Object? e) {
//                     setState(() {
//                       result = 'ApplePayButton, Error:\n$e';
//                     });
//                   },
//                 ),
//                 googlePayButton: GooglePayButton(
//                   type: GooglePayButtonType.plain,
//                   request: PaymentRequest.google(
//                     paymentNetworks: <PaymentNetwork>[
//                       PaymentNetwork.amex,
//                       PaymentNetwork.discover,
//                       PaymentNetwork.interac,
//                       PaymentNetwork.jcb,
//                       PaymentNetwork.mastercard,
//                       PaymentNetwork.visa,
//                       PaymentNetwork.mir,
//                     ],
//                     google: googleParameters,
//                     currencyCode: 'USD',
//                     countryCode: 'US',
//                     paymentItems: items,
//                   ),
//                   onPaymentResult: (PaymentResponse? req) {
//                     setState(() {
//                       result = 'GooglePayButton, Try to pay:\n${req?.token}';
//                     });
//                   },
//                   onError: (Object? e) {
//                     setState(() {
//                       result = 'GooglePayButton, Error:\n$e';
//                     });
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// // class PayMaterialApp extends StatelessWidget {
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Pay for Flutter Demo',
// //
// //       home: PaySampleApp(),
// //     );
// //   }
// // }
//
// class PaySampleApp extends StatefulWidget {
//   PaySampleApp({Key? key}) : super(key: key);
//
//   @override
//   _PaySampleAppState createState() => _PaySampleAppState();
// }
//
// class _PaySampleAppState extends State<PaySampleApp> {
//   void onGooglePayResult(paymentResult) {
//     print(paymentResult.toString());
//   }
//
//   void onApplePayResult(paymentResult) {
//     print(paymentResult.toString());
//   }
//
//
//   var _paymentItems = [
//     PaymentItem(
//       label: 'Total',
//       amount: '99.99',
//       status: PaymentItemStatus.final_price,
//     )
//   ];
//
//   Pay _payClient = Pay.withAssets([
//     'default_payment_profile_apple_pay.json',
//     'default_payment_profile_google_pay.json'
//   ]);
//
//
//   List<PaymentItem> items = [
//   PaymentItem(label: "Caterme", amount: '4',),
//   ];
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('T-shirt Shop'),
//       ),
//       // backgroundColor: Colors.white,
//       body: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         children: [
//
//       FutureBuilder<bool>(
//       future: _payClient.userCanPay(PayProvider.google_pay),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.data == true) {
//             return RawGooglePayButton(
//                 type: GooglePayButtonType.pay,
//                 onPressed: onGooglePayPressed,
//               // paymentConfigurationAsset: 'default_payment_profile_google_pay.json',
//               // onPaymentResult: (Map<String, dynamic> result) {
//               //     print(result);
//               // },
//               // paymentItems: _paymentItems,
//
//
//
//             );
//           } else {
//             return Container();
//           }
//         }
//         return Container();
//
//       },
//     ),
//
//           // GooglePayButton(
//           //   paymentConfigurationAsset:
//           //   'default_payment_profile_google_pay.json',
//           //   paymentItems: _paymentItems,
//           //   type: GooglePayButtonType.pay,
//           //
//           //   margin: const EdgeInsets.only(top: 15.0),
//           //   onPaymentResult: onGooglePayResult,
//           //   loadingIndicator: const Center(
//           //     child: CircularProgressIndicator(),
//           //   ),
//           //   onError: (ms){
//           //     print('errrrrrrrro: ${ms.toString()}');
//           //   },
//           //   // onPressed: (){
//           //   //   print('dddddddddddddd');
//           //   // },
//           // ),
//           ApplePayButton(
//             paymentConfigurationAsset: 'default_payment_profile_apple_pay.json',
//             paymentItems: _paymentItems,
//             style: ApplePayButtonStyle.black,
//             type: ApplePayButtonType.buy,
//             margin: const EdgeInsets.only(top: 15.0),
//             onPaymentResult: onApplePayResult,
//             loadingIndicator: const Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//           const SizedBox(height: 15)
//         ],
//       ),
//     );
//   }
//
//   void onGooglePayPressed() async {
//     final result = await _payClient.showPaymentSelector(
//       provider: PayProvider.google_pay,
//       paymentItems: _paymentItems,
//
//     );
//     // print(result);
//     // Send the resulting Google Pay token to your server / PSP
//   }
// }