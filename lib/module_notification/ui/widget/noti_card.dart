import 'package:cater_me_v2/module_notification/response/notifications_response.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final NotificationResponse model;
   NotificationCard({
    required this.model,
  });

  bool isArabic = false;
  @override
  Widget build(BuildContext context) {
    isArabic =
        Localizations.localeOf(context).languageCode == 'ar' ? true : false;
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(Icons.notifications , color: Colors.green.shade600,),
              title: Text(model.title ?? ''),
              subtitle:Text(isArabic ? model.descriptionAR ??'' :  model.description ?? ''),

            )));
  }
}
