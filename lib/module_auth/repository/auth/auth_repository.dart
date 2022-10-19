import 'package:cater_me_v2/abstracts/response/action_response.dart';
import 'package:cater_me_v2/consts/urls.dart';
import 'package:cater_me_v2/http_client/http_client.dart';
import 'package:cater_me_v2/module_auth/request/login_request/login_request.dart';
import 'package:cater_me_v2/module_auth/request/register_request/generate_otp.dart';
import 'package:cater_me_v2/module_auth/request/register_request/register_request.dart';
import 'package:cater_me_v2/module_auth/request/register_request/verfy_code_request.dart';
import 'package:cater_me_v2/utils/logger/logger.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthRepository {
  final ApiClient _apiClient;
  final Logger _logger;
  AuthRepository(this._apiClient, this._logger);


  Future<WebServiceResponse?> getToken(LoginRequest loginRequest) async {
    WebServiceResponse? result = await _apiClient.post(
      Urls.LOGIN,
      loginRequest.toJson(),
    );
    if (result == null) {
      return null;
    }
    return result;
  }
  Future<WebServiceResponse?> registerClient(RegisterRequest request) async {
    WebServiceResponse? result = await _apiClient.post(
      Urls.SIGNUP,
      request.toJson(),
    );
    if (result == null) {
      return null;
    }
    return result;
  }
  Future<WebServiceResponse?> confirmOtp(VerifyCodeRequest request) async {
    WebServiceResponse? result = await _apiClient.put(
      Urls.CONFIRM_OTP,
      request.toJson(),
    );
    if (result == null) {
      return null;
    }
    return result;
  }
  Future<WebServiceResponse?> generateOtp(GenerateOtpRequest request) async {
    WebServiceResponse? result = await _apiClient.post(
      Urls.GENERATE_OTP,
      request.toJson(),
    );
    if (result == null) {
      return null;
    }
    return result;
  }
}
