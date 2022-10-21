import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_orders/order_route.dart';
import 'package:cater_me_v2/module_orders/response/orders_response.dart';
import 'package:cater_me_v2/utils/helpers/role_status_helper.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final OrdersResponse model;
  OrderCard({
    required this.model,
  });

  bool isArabic = false;
  @override
  Widget build(BuildContext context) {
    isArabic =
        Localizations.localeOf(context).languageCode == 'ar' ? true : false;
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, OrderRoutes.ORDER_DETAILS , arguments: model.id.toString());
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              elevation: 5,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade50,
                    child: Image.asset(StatusOrderHelper.getOrderImage(
                        StatusOrderHelper.getStatusEnum(model.orderStatus)))),
                title: Text(model.eventName ?? ''),
                subtitle: Row(
                  children: [
                    Text(S.of(context).totalPrice + ': ' ),
                    Text( '${model.total.toString()}' +S.of(context).sar , style: TextStyle(color: Colors.green.shade600),),
                  ],
                ),
                trailing: Text(
                  model.orderStatus ?? '',
                  style: TextStyle(
                      color: StatusOrderHelper.getOrderColor(
                          StatusOrderHelper.getStatusEnum(model.orderStatus))),
                ),
              ))),
    );
  }
}
