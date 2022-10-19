import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_auth/request/register_request/verfy_code_request.dart';
import 'package:cater_me_v2/module_auth/ui/screen/singup_screen.dart';
import 'package:cater_me_v2/module_auth/ui/states/login_states/login_state.dart';
import 'package:cater_me_v2/module_auth/ui/states/signup_states/signUp_state.dart';
import 'package:cater_me_v2/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:cater_me_v2/utils/helpers/custom_flushbar.dart';
import 'package:cater_me_v2/utils/images/images.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widget/login_widgets/custem_button.dart';

class ConfirmCodeState  extends SignUpState {
  ConfirmCodeState(SingUpScreenState screen, {String? error}) : super(screen) {
    if (error != null) {
      CustomFlushBarHelper.createError(
              title: S.current.warning, message: error)
          .show(screen.context);
    }
  }

  TextEditingController codeController = TextEditingController();


  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _loginKey,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Image.asset(
                    ImageAsset.LOGOAuth,
                    width: 90,
                    height: 230,
                  ),
                ),
                SizedBox(
                  height: 45,
                ),

                CustomLoginFormField(
                  hintText: S.of(context).code,
                  validator: true,
                  controller: codeController,
                  password: false,
                  preIcon: Icon(Icons.security),
                  borderRadius: 15,
                ),

                SizedBox(
                  height: 50,
                ),
                CustomButton(
                  buttonTab: () {
                    if (_loginKey.currentState!.validate()) {
                      screen.confirmOtp(VerifyCodeRequest(
                        otp: codeController.text
                      ));
                    }
                  },
                  loading: screen.loadingSnapshot.connectionState ==
                      ConnectionState.waiting,
                  text: S.of(context).confirm,
                  bgColor: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
