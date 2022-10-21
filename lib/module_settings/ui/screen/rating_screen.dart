import 'package:cater_me_v2/abstracts/states/state.dart';
import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_settings/request/submit_survey_request.dart';
import 'package:cater_me_v2/module_settings/state_manager/survey_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RatingScreen extends StatefulWidget {
  final SurveyCubit cubit;
  const RatingScreen({ required this.cubit})  ;

  @override
  State<RatingScreen> createState() => RatingScreenState();
}

class RatingScreenState extends State<RatingScreen> {
  late AsyncSnapshot loadingSnapshot;
  @override
  void initState() {
    super.initState();
    loadingSnapshot = AsyncSnapshot.nothing();
    widget.cubit.loadingStream.listen((event) {
      if (this.mounted) {
        setState(() {
          loadingSnapshot = event;
        });
      }
    });
    widget.cubit.getRateOptions(this);
  }

  getRateOptions() {
    widget.cubit.getRateOptions(this);
  }
  submitRate(SubmitSurveyRequest request) {
    widget.cubit.submitRating(this ,request);
  }
  @override
  void dispose() {
    super.dispose();
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).rateUs),
      ),
      body: BlocBuilder<SurveyCubit, States>(
        bloc: widget.cubit,
        builder: (context, state) {
          return state.getUI(context);
        },
      ),
    );
  }
}
