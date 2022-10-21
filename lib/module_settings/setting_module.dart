import 'package:cater_me_v2/abstracts/module/yes_module.dart';
import 'package:cater_me_v2/module_settings/setting_routes.dart';
import 'package:cater_me_v2/module_settings/ui/screen/rating_screen.dart';
import 'package:cater_me_v2/module_settings/ui/screen/setting_screen.dart';
import 'package:injectable/injectable.dart';

@injectable
class SettingModule extends RoutModule {
  final RatingScreen _ratingScreen;
  final SettingScreen _settingScreen;
  SettingModule(this._ratingScreen, this._settingScreen) {
    RoutModule.RoutesMap.addAll({
      SettingRoutes.SETTING_SCREEN: (context) => _settingScreen,
      SettingRoutes.RATE_SCREEN: (context) => _ratingScreen
    });
  }
}
