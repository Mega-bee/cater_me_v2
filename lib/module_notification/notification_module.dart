import 'package:cater_me_v2/abstracts/module/yes_module.dart';
import 'package:cater_me_v2/module_notification/ui/screens/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'notification_route.dart';

@injectable
class NotificationModule extends RoutModule {
  final NotificationsScreen _notificationsScreen;
  NotificationModule(this._notificationsScreen,  ) {
    RoutModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      NotificationRoutes.VIEW_NOTIFICATION: (context) => _notificationsScreen,};
  }
}
