import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_auth/authorization_routes.dart';
import 'package:cater_me_v2/module_auth/service/auth_service/auth_service.dart';
import 'package:cater_me_v2/module_friends/friends_route.dart';
import 'package:cater_me_v2/module_home/homepage_route.dart';
import 'package:cater_me_v2/module_occasions/occasions_route.dart';
import 'package:cater_me_v2/module_settings/ui/widgets/icon_background_card.dart';
import 'package:cater_me_v2/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class SettingScreen extends StatefulWidget {
  final AuthService _authService;
  SettingScreen(this._authService);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).selectedRowColor.withOpacity(0.9),

        appBar: AppBar(title: Text('Setting'),),
        body: SafeArea(
            child: Container(
      child: Column(
        children: [
          Row(
            children: [
              IconBackCard(title: 'Notifications',iconData: Icons.notifications_active_outlined,onTapCard: (){}),
              IconBackCard(title: 'Orders',iconData: FontAwesomeIcons.firstOrder,onTapCard: (){}),
              IconBackCard(title: S.of(context).occasions,iconData: Icons.date_range,onTapCard: (){
                Navigator.pushNamed(context, OccasionsRoutes.VIEW_OCCASION);
              }),
              IconBackCard(title: S.of(context).friends,iconData: Icons.date_range,onTapCard: (){
                Navigator.pushNamed(context, FriendsRoutes.VIEW_Friend);
              }),
              // IconBackCard(title: 'Support',iconData: Icons.support_agent_outlined,onTapCard: (){}),
            ],
          )
        ],
      ),
    )));
  }
}
