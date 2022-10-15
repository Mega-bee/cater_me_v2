import 'package:carousel_slider/carousel_slider.dart';
import 'package:cater_me_v2/module_credits/response/credit_response.dart';
import 'package:cater_me_v2/module_payments/ui/widget/selected_credit_card.dart';
import 'package:flutter/material.dart';
import '../../../abstracts/states/state.dart';
import '../screens/payment_method_screen.dart';

class SelectedCreditsList extends States {
  final List<CreditsResponse> creditsList;
  PaymentMethodScreenState screenState;

  SelectedCreditsList({required this.creditsList, required this.screenState});

  @override
  Widget getUI(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemBuilder: (context, index ) =>
                  SelectedCreditCard(model: creditsList[index]),
              itemCount: creditsList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }
}
