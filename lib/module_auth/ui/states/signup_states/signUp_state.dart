import 'package:cater_me_v2/module_auth/ui/screen/singup_screen.dart';
import 'package:flutter/material.dart';

abstract class SignUpState {
  final SingUpScreenState screen;
  SignUpState(this.screen);

  Widget getUI(BuildContext context);
}
