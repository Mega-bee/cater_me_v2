import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_auth/request/register_request/register_request.dart';
import 'package:cater_me_v2/module_auth/ui/screen/singup_screen.dart';
import 'package:cater_me_v2/module_auth/ui/states/signup_states/signUp_state.dart';
import 'package:cater_me_v2/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:cater_me_v2/utils/helpers/custom_flushbar.dart';
import 'package:cater_me_v2/utils/images/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
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

  DateTime _selectDate = DateTime.now();
  var birController = TextEditingController();
  int? genderValue = 1;
  bool termsAgree = false;
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _loginKey,
        child: Container(
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
                  height: 25,
                ),
                CustomLoginFormField(
                  hintText: S.of(context).username,
                  validator: true,
                  controller: usernameController,
                  preIcon: Icon(Icons.person),
                  borderRadius: 15,
                ),
                SizedBox(
                  height: 25,
                ),
                CustomLoginFormField(
                  hintText: S.of(context).phoneNumber,
                  validator: true,
                  controller: phoneController,
                  password: false,
                  phone: true,
                  preIcon: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
                    child: Text('+966'),
                  ),
                  borderRadius: 15,
                ),
                SizedBox(
                  height: 25,
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
                  height: 20,
                ),
                CustomLoginFormField(
                  controller: birController,
                  readOnly: true,
                  validator: true,
                  hintText: S.of(context).birthDay,
                  preIcon: Icon(Icons.cake),
                  onTap: () {
                    showCupertinoModalPopup(
                        builder: (context) => Container(
                          height: 200,
                          color: Theme.of(context).cardColor,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (value) {
                              _selectDate = value;
                              birController.text = DateFormat('yyyy-MM-dd').format(_selectDate);
                              screen.refresh();
                            },
                            initialDateTime: _selectDate,
                          ),
                        ),
                        context: context);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  S.of(context).gender,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Wrap(
                  children: [
                    RadioListTile(
                      value: 1,
                      groupValue: genderValue,
                      onChanged: (v) {
                        genderValue = v as int;
                        screen.refresh();
                      },
                      title: Text(S.of(context).male),
                    ),
                    RadioListTile(
                      value: 2,
                      groupValue: genderValue,
                      onChanged: (v) {
                        genderValue = v as int;
                        screen.refresh();
                      },
                      title: Text(S.of(context).female),
                    ),
                    RadioListTile(
                      value: 3,
                      groupValue: genderValue,
                      onChanged: (v) {
                        genderValue = v as int;
                        screen.refresh();
                      },
                      title: Text(S.of(context).ratherToSay),
                    ),
                  ],
                ),

                Row(children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: S.of(context).terms,
                          style: TextStyle(color: Colors.green.shade600 , fontSize: 16 ,fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              final url = 'https://caterme.azurewebsites.net/caterme/termsandconditions?lang=${Localizations.localeOf(context).languageCode}';
                              if (await canLaunch(url)) {
                                await launch(
                                  url,
                                  forceSafariVC: false,
                                );
                              }
                            },
                        ),
                      ],
                    )),
                  Checkbox(value: termsAgree, onChanged: (v){
                    termsAgree = v ??false;
                    screen.refresh();
                  })
                ],),
                SizedBox(
                  height: 50,
                ),
                CustomButton(
                  buttonTab: () {
                    if (_loginKey.currentState!.validate() && termsAgree) {
                      screen.signUpClient(RegisterRequest(
                        password: passwordController.text,
                        phone: phoneController.text,
                        userName: usernameController.text,
                        genderId: genderValue,
                        birtDay: DateFormat('yyyy-MM-dd','en').format(_selectDate)
                      ));
                    }else {
                      Fluttertoast.showToast(msg: S.of(context).agreeTerms);
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
