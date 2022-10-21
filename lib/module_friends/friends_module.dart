import 'package:cater_me_v2/abstracts/module/yes_module.dart';
import 'package:cater_me_v2/module_friends/ui/screens/friends_screen.dart';
import 'package:cater_me_v2/module_friends/ui/screens/select_friends_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'friends_route.dart';

@injectable
class FriendsModule extends RoutModule {
  final FriendsScreen _friendsScreen;
  final SelectFriendsScreen _selectFriendsScreen;
  FriendsModule(this._friendsScreen, this._selectFriendsScreen) {
    RoutModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      FriendsRoutes.VIEW_Friend: (context) => _friendsScreen,
      FriendsRoutes.VIEW_SELECT_FRIEND: (context) => _selectFriendsScreen,
    };
  }
}
