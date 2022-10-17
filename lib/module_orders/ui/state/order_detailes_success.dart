import 'package:cater_me_v2/abstracts/states/state.dart';
import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_orders/response/order_detailes_response.dart';
import 'package:cater_me_v2/module_orders/ui/screens/orders_detailes_screen.dart';
import 'package:cater_me_v2/module_orders/ui/widget/custom_text.dart';
import 'package:cater_me_v2/module_orders/ui/widget/item_details_card.dart';
import 'package:flutter/material.dart';

class OrdersDetailsSuccess extends States {
  final OrderDetailsResponse model;
  OrdersDetailsScreenState screenState;

  OrdersDetailsSuccess({required this.model, required this.screenState});
  bool isArabic= false;
  @override
  Widget getUI(BuildContext context) {
    isArabic =  Localizations.localeOf(context).languageCode == 'ar'  ? true : false;

    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(children: [
                    // name date
                    Row(
                      children: [
                        CustomText(title: S.of(context).occasionTitle, body: model.event?.eventName ?? '',),

                      ],mainAxisAlignment: MainAxisAlignment.center,) ,
                    SizedBox(height: 10,),
                    CustomText(title: S.of(context).timeOfEvent,
                      body: model.event?.eventDate?.toString().split(' ').first ?? '',),
                    SizedBox(height: 10,),
                    // gist and address
                    Row(
                      children: [
                        CustomText(title: S.of(context).numberOfGuest, body:isArabic?
                        model.event?.numberOfGuestsAr ?? '' :  model.event?.numberOfGuests ?? ''),
                        CustomText(title: S.of(context).deliveringTo, body: model.address?.title ?? '',),
                      ],mainAxisAlignment: MainAxisAlignment.spaceBetween,) ,
                  ],),
                )
            ),
            SizedBox(height: 10,),
            ListView.builder(
              itemBuilder: (context, index) => ItemDetailsCard(
                model: model.orderItems![index],
              ),
              shrinkWrap: true,
              itemCount: model.orderItems!.length,
              physics: NeverScrollableScrollPhysics(),
            ),
            SizedBox(height: 10,),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(children: [
                  Center(child: CustomText(title: S.of(context).totalAmount, body: model.total.toString() + S.of(context).sar)),
                  SizedBox(height: 5,),
                  Divider(
                    height: 1,
                    thickness: 1,
                    endIndent: 10,
                    indent: 10,
                  ),
                  Center(child: Text('15% inclusive tax on food and beverage' , style: TextStyle(color: Colors.red),))
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
