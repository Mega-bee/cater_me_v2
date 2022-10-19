import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_auth/request/register_request/register_request.dart';
import 'package:cater_me_v2/module_auth/ui/screen/singup_screen.dart';
import 'package:cater_me_v2/module_auth/ui/states/signup_states/signUp_state.dart';
import 'package:cater_me_v2/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:cater_me_v2/utils/helpers/custom_flushbar.dart';
import 'package:cater_me_v2/utils/images/images.dart';
import 'package:flutter/material.dart';
import '../../widget/login_widgets/custem_button.dart';

class SignUpStateInit extends SignUpState {
  SignUpStateInit(SingUpScreenState screen, {String? error}) : super(screen) {
    if (error != null) {
      CustomFlushBarHelper.createError(
              title: S.current.warning, message: error)
          .show(screen.context);
    }
  }
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  DateTime? _birthDay;
  int? genderId;

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
                MediaQuery.of(context).viewInsets.bottom == 0
                    ? Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Image.asset(
                          ImageAsset.LOGOAuth,
                          width: 100,
                          height: 230,
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 45,
                ),
                CustomLoginFormField(
                  hintText: S.of(context).username,
                  validator: true,
                  controller: usernameController,
                  preIcon: Icon(Icons.person),
                  borderRadius: 15,
                ),
                SizedBox(
                  height: 45,
                ),
                CustomLoginFormField(
                  hintText: S.of(context).phoneNumber,
                  validator: true,
                  controller: phoneController,
                  password: false,
                  phone: true,
                  preIcon: Icon(Icons.phone_android),
                  borderRadius: 15,
                ),
                SizedBox(
                  height: 45,
                ),
                CustomLoginFormField(
                  hintText: S.of(context).password,
                  validator: true,
                  controller: passwordController,
                  password: true,
                  preIcon: Icon(Icons.password),
                  borderRadius: 15,
                ),

                SizedBox(
                  height: 50,
                ),
                CustomButton(
                  buttonTab: () {
                    if (_loginKey.currentState!.validate()) {
                      screen.signUpClient(RegisterRequest(
                        password: passwordController.text,
                        phone: phoneController.text,
                        userName: usernameController.text,
                        genderId: 1,
                        birtDay: '1996-02-01'
                      ));
                    }
                  },
                  loading: screen.loadingSnapshot.connectionState ==
                      ConnectionState.waiting,
                  text: S.of(context).createAccount,
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
