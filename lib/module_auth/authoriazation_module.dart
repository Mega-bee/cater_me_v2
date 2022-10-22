import 'package:cater_me_v2/abstracts/module/yes_module.dart';
import 'package:cater_me_v2/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:cater_me_v2/module_auth/ui/screen/singup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import 'authorization_routes.dart';
import 'ui/screen/terms_and_conditions.dart';

@injectable
class AuthorizationModule extends RoutModule {
  final LoginScreen _loginScreen;
  final SingUpScreen  _singUpScreen;
  final TermsAndConditions  _termsAndConditions;


  AuthorizationModule(
      this._loginScreen, this._singUpScreen, this._termsAndConditions, ) {
    RoutModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      AuthorizationRoutes.LOGIN_SCREEN: (context) => _loginScreen,
      AuthorizationRoutes.REGISTER_SCREEN: (context) => _singUpScreen,
      AuthorizationRoutes.TERMS_CONDITIONS: (context) => _termsAndConditions,

    };
  }
}
