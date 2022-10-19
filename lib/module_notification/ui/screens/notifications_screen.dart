import 'package:cater_me_v2/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../abstracts/states/state.dart';
import '../../state_manager/notification_state_manager.dart';

@injectable
class NotificationsScreen extends StatefulWidget {
  final NotificationCubit cubit;

  const NotificationsScreen(
    this.cubit,
  );

  @override
  State<NotificationsScreen> createState() => NotificationsScreenState();
}

class NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    widget.cubit.getNotification(this);
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
        title: Text(S.of(context).notifications),
      ),
      body: BlocBuilder<NotificationCubit, States>(
        bloc: widget.cubit,
        builder: (context, state) {
          return state.getUI(context);
        },
      ),
    );
  }
}
