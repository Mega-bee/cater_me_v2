import 'package:cater_me_v2/module_auth/enums/auth_status.dart';
import 'package:cater_me_v2/module_auth/request/register_request/register_request.dart';
import 'package:cater_me_v2/module_auth/request/register_request/verfy_code_request.dart';
import 'package:cater_me_v2/module_auth/service/auth_service/auth_service.dart';
import 'package:cater_me_v2/module_auth/ui/screen/singup_screen.dart';
import 'package:cater_me_v2/module_auth/ui/states/signup_states/confirm_code_state.dart';
import 'package:cater_me_v2/module_auth/ui/states/signup_states/signUp_state.dart';
import 'package:cater_me_v2/module_auth/ui/states/signup_states/signup_state_init.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class SignUpStateManager {
  final AuthService _authService;

  final PublishSubject<SignUpState> _SignUpStateSubject =
      PublishSubject<SignUpState>();
  final _loadingStateSubject = PublishSubject<AsyncSnapshot>();

  late SingUpScreenState _screenState;

  SignUpStateManager(this._authService) {
    _authService.authListener.listen((event) async {
      _loadingStateSubject.add(AsyncSnapshot.nothing());
      switch (event) {
        case AuthStatus.CONFIRM_CODE:
          _SignUpStateSubject.add(ConfirmCodeState(_screenState));
          break;
        case AuthStatus.AUTHORIZED_CLIENT:
          _screenState.moveToHomePage();
          break;
        default:
          _SignUpStateSubject.add(SignUpStateInit(_screenState));
          break;
      }
    }).onError((err) {
      _loadingStateSubject.add(AsyncSnapshot.nothing());
      print('onErrorr statttet');
      if(_screenState.currentStates is SignUpStateInit){
        print('in Sing error state');
        _SignUpStateSubject.add(SignUpStateInit(_screenState, error: err));
      }
      else
      _SignUpStateSubject.add(ConfirmCodeState(_screenState,error: err));

    });
  }

  Stream<SignUpState> get stateStream => _SignUpStateSubject.stream;
  Stream<AsyncSnapshot> get loadingStream => _loadingStateSubject.stream;

  void signUpClient(
    RegisterRequest request,
    SingUpScreenState _SignUpScreenState,
  ) {
    _screenState = _SignUpScreenState;
    _loadingStateSubject.add(AsyncSnapshot.waiting());
    _authService.signUpApi(request);
  }

  void confirmOtp(
      VerifyCodeRequest request,
      SingUpScreenState _SignUpScreenState,
      ) {
    _screenState = _SignUpScreenState;
    _loadingStateSubject.add(AsyncSnapshot.waiting());
    _authService.confirmOtpApi(request);
  }
}
