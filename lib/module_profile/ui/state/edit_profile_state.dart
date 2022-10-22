import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_profile/request/edit_profile_request.dart';
import 'package:cater_me_v2/utils/components/custom_feild.dart';
import 'package:cater_me_v2/utils/components/custom_loading_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../abstracts/states/state.dart';
import '../../response/get_profile_response.dart';
import '../screen/edit_profile_screen.dart';

class EditProfileSate extends States {
  EditProfileScreenState screenState;
  ProfileResponse model;

  EditProfileSate({
    required this.screenState,
    required this.model,
  }) : super() {
    nameController.text = model.name ?? '';
    genderValue = model.genderId ?? 1;
    birController.text = model.birthDate!.split('T').first;
    _selectDate =
        DateFormat('yyyy-MM-dd','en').parse(model.birthDate ?? '1996-02-01');
  }

  var nameController = TextEditingController();
  var birController = TextEditingController();
  DateTime _selectDate = DateTime.now();
  int genderValue = 1;
  final GlobalKey<FormState> _updateProKey = GlobalKey<FormState>();

  @override
  Widget getUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Form(
          key: _updateProKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).username,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              CustomFormField(
                controller: nameController,
                validator: true,
                hintText: S.of(context).username,
              ),
              Text(
                S.of(context).birthDay,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              CustomFormField(
                controller: birController,
                readOnly: true,
                validator: true,
                hintText: S.of(context).birthDay,
                onTap: () {
                  showCupertinoModalPopup(
                      builder: (context) => Container(
                            height: 200,
                            color: Theme.of(context).cardColor,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              onDateTimeChanged: (value) {
                                _selectDate = value;
                                birController.text = DateFormat('yyyy-MM-dd').format(_selectDate);
                                screenState.refresh();
                              },
                              initialDateTime: _selectDate,
                            ),
                          ),
                      context: context);
                },
              ),
              Text(
                S.of(context).gender,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Wrap(
                children: [
                  RadioListTile(
                    value: 1,
                    groupValue: genderValue,
                    onChanged: (v) {
                      genderValue = v as int;
                      screenState.refresh();
                    },
                    title: Text(S.of(context).male),
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: genderValue,
                    onChanged: (v) {
                      genderValue = v as int;
                      screenState.refresh();
                    },
                    title: Text(S.of(context).female),
                  ),
                  RadioListTile(
                    value: 3,
                    groupValue: genderValue,
                    onChanged: (v) {
                      genderValue = v as int;
                      screenState.refresh();
                    },
                    title: Text(S.of(context).ratherToSay),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              CustomLoadingButton(
                bgColor: Theme.of(context).primaryColor,
                text: S.of(context).updateProfile,
                textColor: Colors.white,
                loading: screenState.loadingSnapshotLogin.connectionState ==
                    ConnectionState.waiting,
                buttonTab: () {
                  if (_updateProKey.currentState!.validate()) {
                    screenState.updateProfile(UpdateProfileRequest(
                        Name: nameController.text,
                        BirthDate: DateFormat('yyyy-MM-dd','en').format(_selectDate),
                        gender: genderValue));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
