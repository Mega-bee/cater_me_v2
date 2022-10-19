import 'package:cater_me_v2/module_notification/ui/widget/noti_card.dart';
import 'package:flutter/material.dart';
import '../../../abstracts/states/state.dart';
import '../../response/notifications_response.dart';
import '../screens/notifications_screen.dart';

class NotificationListSuccess extends States {
  final List<NotificationResponse> notiList;
  NotificationsScreenState screenState;

  NotificationListSuccess({required this.notiList, required this.screenState});

  @override
  Widget getUI(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) =>  NotificationCard(
          model: notiList[index],
        ),
      itemCount: notiList.length,
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
    );
  }
}
