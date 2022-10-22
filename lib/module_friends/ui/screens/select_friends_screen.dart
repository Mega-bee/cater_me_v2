import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_friends/request/create_friend_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../abstracts/states/state.dart';
import '../../state_manager/friends_state_manager.dart';
import '../widget/create_friend_sheet.dart';

@injectable
class SelectFriendsScreen extends StatefulWidget {
  final FriendsCubit cubit;

  const SelectFriendsScreen(
    this.cubit,
  );

  @override
  State<SelectFriendsScreen> createState() => SelectFriendsScreenState();
}

class SelectFriendsScreenState extends State<SelectFriendsScreen> {
  num? price;
  bool flag = true;
  @override
  void initState() {
    super.initState();

  }

  getFriends() {
    widget.cubit.getFriendsForSelect(this);
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
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && flag) {
      price = args as num;
      flag = false;
      widget.cubit.getFriendsForSelect(this);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).selectFriendsForBill),
      ),
      body: BlocBuilder<FriendsCubit, States>(
        bloc: widget.cubit,
        builder: (context, state) {
          return state.getUI(context);
        },
      ),
    );
  }
}
