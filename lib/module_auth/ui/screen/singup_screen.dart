import 'dart:async';
import 'package:cater_me_v2/module_auth/request/register_request/register_request.dart';
import 'package:cater_me_v2/module_auth/request/register_request/verfy_code_request.dart';
import 'package:cater_me_v2/module_auth/state_manager/signup_state_manager.dart';
import 'package:cater_me_v2/module_auth/ui/states/signup_states/signUp_state.dart';
import 'package:cater_me_v2/module_auth/ui/states/signup_states/signup_state_init.dart';
import 'package:cater_me_v2/module_home/homepage_route.dart';
import 'package:cater_me_v2/utils/components/fixed_container.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class SingUpScreen extends StatefulWidget {
  final SignUpStateManager _stateManager;

  SingUpScreen(this._stateManager);

  @override
  SingUpScreenState createState() => SingUpScreenState();
}

class SingUpScreenState extends State<SingUpScreen> {
  late SignUpState currentStates;
  late AsyncSnapshot loadingSnapshot;
  late StreamSubscription _stateSubscription;

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    loadingSnapshot = AsyncSnapshot.nothing();
    currentStates = SignUpStateInit(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      if (mounted) {
        setState(() {
          currentStates = event;
        });
      }
    });
    widget._stateManager.loadingStream.listen((event) {
      if (this.mounted) {
        setState(() {
          loadingSnapshot = event;
        });
      }
    });
    super.initState();;
  }

  bool  argsF = false;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null ) {
      argsF = true;
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(

        body: FixedContainer(
          child: loadingSnapshot.connectionState != ConnectionState.waiting
              ? currentStates.getUI(context)
              : Stack(
            children: [
              currentStates.getUI(context),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    super.dispose();
  }

  void signUpClient(RegisterRequest request) {
    widget._stateManager.signUpClient(request,this);
  }
  void confirmOtp(VerifyCodeRequest request) {
    widget._stateManager.confirmOtp(request,this);
  }
  void moveToHomePage() {
    Navigator.pushNamedAndRemoveUntil(context, HomePageRoutes.homePage,(route) => false,);
  }

}
