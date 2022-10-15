import 'package:cater_me_v2/abstracts/response/action_response.dart';
import 'package:cater_me_v2/consts/urls.dart';
import 'package:cater_me_v2/http_client/http_client.dart';
import 'package:cater_me_v2/module_auth/service/auth_service/auth_service.dart';
import 'package:cater_me_v2/module_credits/request/create_credit_request.dart';
 import 'package:injectable/injectable.dart';

@injectable
class PaymentRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  PaymentRepository(this._apiClient, this._authService);

}
