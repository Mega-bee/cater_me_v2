import 'package:cater_me_v2/abstracts/states/error_state.dart';
import 'package:cater_me_v2/abstracts/states/loading_state.dart';
import 'package:cater_me_v2/abstracts/states/state.dart';
import 'package:cater_me_v2/module_settings/reponse/rateing_response.dart';
import 'package:cater_me_v2/module_settings/repository/contactus_repository.dart';
import 'package:cater_me_v2/module_settings/request/submit_survey_request.dart';
import 'package:cater_me_v2/module_settings/ui/screen/rating_screen.dart';
import 'package:cater_me_v2/module_settings/ui/state/rate_option_success.dart';
import 'package:cater_me_v2/module_settings/ui/widgets/success_rate_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

@injectable
class SurveyCubit extends Cubit<States> {
  final ContactUsRepository _contactUsRepository;
  SurveyCubit(this._contactUsRepository) : super(LoadingState());



  final _loadingStateSubject = PublishSubject<AsyncSnapshot>();
  Stream<AsyncSnapshot> get loadingStream => _loadingStateSubject.stream;

  getRateOptions(RatingScreenState screenState) {
    emit(LoadingState());
    _contactUsRepository.getRateOption().then((value) {
      if (value == null) {
        emit(ErrorState(
            errMsg: 'Connection error',
            retry: () {
              getRateOptions(screenState);
            }));
      } else if (value.code == 200) {
        List<RateOptionResponse> occList = [];
        for (var item in value.data.insideData) {
          occList.add(RateOptionResponse.fromJson(item));
        }
        emit(RateOptionsSuccess(screenState: screenState, options: occList));
      } else {
        emit(ErrorState(
            errMsg: value.errorMessage,
            retry: () {
              getRateOptions(screenState);
            }));
      }
    });
  }

  submitRating(RatingScreenState screenState , SubmitSurveyRequest request) {
    _loadingStateSubject.add(AsyncSnapshot.waiting());
    _contactUsRepository.submitRate(request).then((value) {
      if (value == null) {
        _loadingStateSubject.add(AsyncSnapshot.nothing());
        emit(ErrorState(
            errMsg: 'Connection error',
            retry: () {
              submitRating(screenState ,request);
            }));
      } else if (value.code == 200) {
        _loadingStateSubject.add(AsyncSnapshot.nothing());
        showDialog(context: screenState.context, builder: (context) => SuccessRateAlter(),);

      } else {
        _loadingStateSubject.add(AsyncSnapshot.nothing());
        emit(ErrorState(
            errMsg: value.errorMessage,
            retry: () {
              submitRating(screenState ,request);
            }));
      }
    });
  }
}
