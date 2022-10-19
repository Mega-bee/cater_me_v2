import 'package:cater_me_v2/abstracts/states/state.dart';
import 'package:cater_me_v2/module_settings/reponse/contact_reponse.dart';
import 'package:cater_me_v2/module_settings/repository/contactus_repository.dart';
import 'package:cater_me_v2/module_settings/ui/screen/setting_screen.dart';
import 'package:cater_me_v2/module_settings/ui/state/loading_contact_state.dart';
import 'package:cater_me_v2/module_settings/ui/state/success_contact_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ContactCubit extends Cubit<States> {
  final ContactUsRepository _contactUsRepository;
  ContactCubit(this._contactUsRepository) : super(LoadingContactSate());

  getContactInfo(SettingScreenState screenState ) {
    emit(LoadingContactSate());
    _contactUsRepository.getContactUs().then((value) {
      if (value == null) {

      } else if (value.code == 200) {
        ContactResponse response = ContactResponse.fromJson(value.data.insideData);
         emit(SuccessContactSate(response));
      } else {

      }
    });
  }

}