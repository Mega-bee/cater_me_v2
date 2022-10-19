import 'package:cater_me_v2/abstracts/states/error_state.dart';
import 'package:cater_me_v2/module_notification/repository/noti_repository.dart';
import 'package:cater_me_v2/module_notification/response/notifications_response.dart';
import 'package:cater_me_v2/module_notification/ui/state/notification_list_success.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../abstracts/states/loading_state.dart';
import '../../abstracts/states/state.dart';
import '../ui/screens/notifications_screen.dart';

@injectable
class NotificationCubit extends Cubit<States> {
  final NotificationRepository _notificationRepository;
  NotificationCubit(this._notificationRepository) : super(LoadingState());

  getNotification(NotificationsScreenState screenState) {
    emit(LoadingState());
    _notificationRepository.getNotifications().then((value) {
      if (value == null) {
        emit(ErrorState(
            errMsg: 'Connection error',
            retry: () {
              getNotification(screenState);
            }));
      } else if (value.code == 200) {
        List<NotificationResponse> occList = [];
        for (var item in value.data.insideData) {
          occList.add(NotificationResponse.fromJson(item));
        }
        emit(NotificationListSuccess(
            screenState: screenState, notiList: occList));
      } else {
        emit(ErrorState(
            errMsg: value.errorMessage,
            retry: () {
              getNotification(screenState);
            }));
      }
    });
  }
}
