import 'package:cater_me_v2/abstracts/states/error_state.dart';
import 'package:cater_me_v2/module_home/ui/state/loading_home_state.dart';
import 'package:cater_me_v2/module_localization/service/localization_service/localization_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import '../../abstracts/states/loading_state.dart';
import '../../abstracts/states/state.dart';
import '../repository/homepage_repository.dart';
import '../response/homepage_response.dart';
import '../ui/screens/home_page_screen.dart';
import '../ui/state/homepage_sucess.dart';

@injectable
class HomePageCubit extends Cubit<States> {
  final HomePageRepository _homePageRepository;
  final LocalizationService _localizationService;

  HomePageCubit(this._homePageRepository, this._localizationService) : super(LoadingState());

  getHomePage(HomePageScreenState state) {
    emit(LoadingHomePage());
    _homePageRepository.getHomePage().then((value) {
      if (value == null) {
        emit(ErrorState(
            errMsg: 'Connection error',
            retry: () {
              getHomePage(state);
            }));
      } else if (value.code == 200) {
        HomePageResponse homePageModel =
            HomePageResponse.fromJson(value.data.insideData);

        emit(
          HomePageSuccess(homepage: homePageModel, homepageState: state),
        );
      }
    });
  }
}
