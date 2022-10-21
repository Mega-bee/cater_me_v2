import 'package:cater_me_v2/abstracts/states/state.dart';
import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_auth/ui/widget/login_widgets/custem_button.dart';
import 'package:cater_me_v2/module_settings/reponse/rateing_response.dart';
import 'package:cater_me_v2/module_settings/request/submit_survey_request.dart';
import 'package:cater_me_v2/module_settings/ui/screen/rating_screen.dart';
import 'package:cater_me_v2/module_settings/ui/widgets/question_card.dart';
import 'package:cater_me_v2/utils/components/custom_feild.dart';
import 'package:cater_me_v2/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RateOptionsSuccess extends States {
  final List<RateOptionResponse> options;
  final RatingScreenState screenState;

  RateOptionsSuccess({required this.options, required this.screenState});

  var complaintController = TextEditingController();

  List<FeedBackOptions> ratedList = [];

  @override
  Widget getUI(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImageAsset.RATING,
              height: 200,
            ),
            Text(
             S.of(context).rateTitle,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
                itemBuilder: (context, index) =>
                    QuestionCard(model: options[index],
                        onRateUpdate: (rateVal) {
                          ratedList.add(FeedBackOptions(id: options[index].id , rate: double.parse(rateVal.toString())));
                    }),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: options.length),
            SizedBox(
              height: 15,
            ),
            Align(
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      S.of(context).complaint,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                )),
            CustomFormField(
              controller: complaintController,
              preIcon: Icon(Icons.comment),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomButton(
                buttonTab: () {
                  screenState.submitRate(SubmitSurveyRequest(complain: complaintController.text ,options: ratedList));
                },
                loading: screenState.loadingSnapshot.connectionState ==
                    ConnectionState.waiting,
                text: S.of(context).rateUs,
                bgColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
