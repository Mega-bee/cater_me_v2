
import 'package:cater_me_v2/abstracts/states/error_state.dart';
import 'package:cater_me_v2/module_credits/repository/credits_repository.dart';
import 'package:cater_me_v2/module_credits/request/create_credit_request.dart';
import 'package:cater_me_v2/module_credits/response/credit_response.dart';
import 'package:cater_me_v2/module_payments/repository/payment_repository.dart';
import 'package:cater_me_v2/module_payments/request/payment_request.dart';
import 'package:cater_me_v2/module_payments/response/pay_response.dart';
import 'package:cater_me_v2/module_payments/ui/screens/payment_method_screen.dart';
import 'package:cater_me_v2/module_payments/ui/screens/payment_verify_otp_screen.dart';
import 'package:cater_me_v2/module_payments/ui/state/selected_credits_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tip_dialog/tip_dialog.dart';
import '../../abstracts/states/loading_state.dart';
import '../../abstracts/states/state.dart';

@injectable
class PaymentCubit extends Cubit<States> {
  final PaymentRepository _paymentRepository;
  final CreditsRepository _creditsRepository;
  PaymentCubit(this._paymentRepository, this._creditsRepository)
      : super(LoadingState());

  getCredits(PaymentMethodScreenState screenState) {
    emit(LoadingState());
    _creditsRepository.getCredits().then((value) {
      if (value == null) {
        emit(ErrorState(
            errMsg: 'Connection error',
            retry: () {
              getCredits(screenState);
            }));
      }
      else if (value.code == 200) {
        List<CreditsResponse> occList = [];
        for (var item in value.data.insideData) {
          occList.add(CreditsResponse.fromJson(item));
        }
        emit(
            SelectedCreditsListSuccess(screenState: screenState, creditsList: occList));
      }
      else {
        emit(ErrorState(
            errMsg: value.errorMessage,
            retry: () {
              getCredits(screenState);
            }));
      }
    });
  }

  createCredit(PaymentMethodScreenState screenState, CreateCreditRequest request) {
    emit(LoadingState());
    _creditsRepository.createCredit(request).then((value) {
      if (value == null) {
        emit(ErrorState(
            errMsg: 'Connection error',
            retry: () {
              getCredits(screenState);
            }));
      } else if (value.code == 201) {
        getCredits(screenState);
      } else {
        emit(ErrorState(
            errMsg: value.errorMessage,
            retry: () {
              getCredits(screenState);
            }));
      }
    });
  }

  paymentRequest (PaymentMethodScreenState screenState, PaymentTypeRequest request){
    print('loooooooo');
    TipDialogHelper.loading('Loading');
    _paymentRepository.requestPayment(request).then((value)  {
      if(value != null) {
        PaymentResponse response = PaymentResponse.fromJson(value.data.insideData);
        // TipDialogHelper.dismiss();
        Navigator.pushAndRemoveUntil(screenState.context, MaterialPageRoute(builder: (context) =>
            PaymentVerifyOtpScreen(webUrl: response.link ??''),), (route) => false);
      }else{
        TipDialogHelper.fail(value?.errorMessage ?? 'connection error');
      }
    });
  }
}
