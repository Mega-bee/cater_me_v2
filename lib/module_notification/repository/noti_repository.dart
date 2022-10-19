import 'package:cater_me_v2/abstracts/response/action_response.dart';
import 'package:cater_me_v2/consts/urls.dart';
import 'package:cater_me_v2/http_client/http_client.dart';
import 'package:cater_me_v2/module_auth/service/auth_service/auth_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class NotificationRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  NotificationRepository(this._apiClient, this._authService);

  Future<WebServiceResponse?> getNotifications() async {
    var token = await _authService.getToken();
    WebServiceResponse? response = await _apiClient.get(
      Urls.GET_NOTIFICATION,
      headers: {'Authorization': 'Bearer ' '$token'},
    );
    if (response == null) return null;
    return response;
  }

}
