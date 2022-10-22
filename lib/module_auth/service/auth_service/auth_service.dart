import 'package:cater_me_v2/abstracts/response/action_response.dart';
import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_auth/enums/auth_status.dart';
import 'package:cater_me_v2/module_auth/exceptions/auth_exception.dart';
import 'package:cater_me_v2/module_auth/presistance/auth_prefs_helper.dart';
import 'package:cater_me_v2/module_auth/repository/auth/auth_repository.dart';
import 'package:cater_me_v2/module_auth/request/login_request/login_request.dart';
import 'package:cater_me_v2/module_auth/request/register_request/generate_otp.dart';
import 'package:cater_me_v2/module_auth/request/register_request/register_request.dart';
import 'package:cater_me_v2/module_auth/request/register_request/verfy_code_request.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class AuthService {
  final AuthPrefsHelper _prefsHelper;
  final AuthRepository _authManager;
  final PublishSubject<AuthStatus> _authSubject = PublishSubject<AuthStatus>();

  AuthService(
    this._prefsHelper,
    this._authManager,
  );

  bool get isLoggedIn => _prefsHelper.isSignedIn();


  Stream<AuthStatus> get authListener => _authSubject.stream;
  String get username => _prefsHelper.getUsername() ?? '';
  String get password => _prefsHelper.getPassword() ?? '';


  Future<void> loginApi(String username, String password) async {
    WebServiceResponse? loginResult = await _authManager.getToken(LoginRequest(
      username: username,
      password: password,
    ));
    if (loginResult == null) {
      await logout();
      _authSubject.addError('Connection error');
      // throw AuthorizationException('Connection error');
    } else if (  loginResult.code != 200  ) {
      await logout();
      _authSubject.addError(loginResult.errorMessage);
      // throw AuthorizationException(S.current.invalidCredentials);
    }
    _prefsHelper.setUsername(username);
    _prefsHelper.setPassword(password);
    _prefsHelper.setToken(loginResult?.data!.token);
    // _prefsHelper.setToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiNzg5NTExNzgiLCJQSUQiOiI4MTQiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjU4NGQ1YWRjLWY3NzEtNDQ3NC04MTBhLTY0Y2NhMGZmNjU2ZSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlVzZXIiLCJuYmYiOjE2NjUxNDExMjMsImV4cCI6MTY5NjY3NzEyMywiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NDQzMTAiLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdDo0NDMxMCJ9.kXS72XWE3UrwJ3Ogk_tsD3ChfdmisKXVthQJwM_yWyE');
    _authSubject.add(AuthStatus.AUTHORIZED_CLIENT);
  }

  Future<void> signUpApi(RegisterRequest request) async {
    WebServiceResponse? signResult = await _authManager.registerClient(request);
    if (signResult == null) {
      _authSubject.addError('Connection error');
      // throw AuthorizationException('Connection error');
    } else if (  signResult.code != 200  ) {
      _authSubject.addError(signResult.errorMessage);
      // throw AuthorizationException(signResult.errorMessage);
    }
  else  generateOtpApi(GenerateOtpRequest(request.phone),request.password ??'');
  }

  Future<void> generateOtpApi(GenerateOtpRequest request,String pass) async {
    WebServiceResponse? generateResult = await _authManager.generateOtp(request);
    if (generateResult == null) {
      _authSubject.addError('Connection error');
      // throw AuthorizationException('Connection error');
    } else if (  generateResult.code != 200  ) {
      _authSubject.addError(generateResult.errorMessage);
      // throw AuthorizationException(generateResult.errorMessage);
    }
      _prefsHelper.setPassword(pass);
      _prefsHelper.setUsername(request.phoneNumber ?? '');
    _authSubject.add(AuthStatus.CONFIRM_CODE);
  }

  Future<void> confirmOtpApi(VerifyCodeRequest request) async {
    request.phoneNumber = username;
    WebServiceResponse? confirmResult = await _authManager.confirmOtp(request);
    if (confirmResult == null) {
      _authSubject.addError('Connection error');
      throw AuthorizationException('Connection error');
    } else if (  confirmResult.code != 200  ) {
      _authSubject.addError(confirmResult.errorMessage);
      throw AuthorizationException(confirmResult.errorMessage);
    }
    loginApi(request.phoneNumber??'' ,password);
  }

  Future<String?> getToken() async {
    try {
      return _prefsHelper.getToken();
    } on AuthorizationException {
      _prefsHelper.deleteToken();
      await _prefsHelper.cleanAll();
      return null;
    } on TokenExpiredException {
      return await refreshToken();
    } catch (e) {
      await _prefsHelper.cleanAll();
      return null;
    }
  }

  /// refresh API token, this is done using Firebase Token Refresh
  Future<String?> refreshToken() async {
    String? username = _prefsHelper.getUsername();
    String? password = _prefsHelper.getPassword();
    if (username != null && password != null) {
      await loginApi(
        username,
        password,
      );
    }
    var token = await getToken();
    if (token != null) {
      return token;
    }
    throw const AuthorizationException('error getting token');
  }

  Future<void> logout() async {
    await _prefsHelper.cleanAll();
  }


}
