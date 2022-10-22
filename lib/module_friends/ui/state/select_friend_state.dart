import 'package:cater_me_v2/abstracts/states/state.dart';
import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_friends/response/friend_response.dart';
import 'package:cater_me_v2/module_friends/ui/screens/select_friends_screen.dart';
import 'package:cater_me_v2/module_friends/ui/widget/selected_friend_card.dart';
import 'package:cater_me_v2/module_home/request/place_order_request.dart';
import 'package:cater_me_v2/utils/components/custom_feild.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SelectFriendState extends States {
  final List<FriendsResponse> friends;
  final SelectFriendsScreenState screenState;
  SelectFriendState({required this.screenState, required this.friends});

  List<PaymentFriend> paymentFriends = [];
  List<FriendsResponse> selectedFriends = [];
  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).secondaryHeaderColor),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(S.of(context).sharedAmount +
                        ' ' +
                        '${screenState.price}' +
                        S.of(context).sar),
                  )),
            ),
            ListView.builder(
              itemBuilder: (context, index) => SelectFriendCard(
                  onDelete: () {
                    print('delete');
                    selectedFriends.remove(friends[index]);
                    screenState.refresh();
                  },
                  model: friends[index],
                  onSelect: () {
                    print('select');
                    checkAmountBeforeAdd(friends[index]);
                  }),
              shrinkWrap: true,
              itemCount: friends.length,
            ),
          ],
        ),
        floatingActionButton: selectedFriends.isNotEmpty
            ? FloatingActionButton(
                onPressed: () {
                  selectedFriends.forEach((element) {
                    paymentFriends.add(PaymentFriend(
                        id: element.id,
                        amount: element.amount,
                        name: element.name));
                  });
                  Navigator.pop(context, paymentFriends);
                },
                child: Icon(Icons.done_all_sharp),
                backgroundColor: Theme.of(context).primaryColor,
              )
            : Container());
  }

  checkAmountBeforeAdd(FriendsResponse item) {
    num shardedAmount = 0;
    selectedFriends.forEach((element) {
      shardedAmount = shardedAmount + element.amount!;
    });
    num newAm = shardedAmount + item.amount!;
    if (newAm > screenState.price!) {
      item.amount = 0;
      item.isSelected = false;
      screenState.refresh();
      Fluttertoast.showToast(msg: S.current.amountWrong);
    }else{
      selectedFriends.add(item);
      screenState.refresh();
    }
  }
}
