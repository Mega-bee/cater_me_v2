import 'package:cater_me_v2/abstracts/states/state.dart';
import 'package:cater_me_v2/module_friends/response/friend_response.dart';
import 'package:cater_me_v2/module_friends/ui/screens/select_friends_screen.dart';
import 'package:cater_me_v2/module_friends/ui/widget/selected_friend_card.dart';
import 'package:cater_me_v2/module_home/request/place_order_request.dart';
import 'package:cater_me_v2/utils/components/custom_feild.dart';
import 'package:flutter/material.dart';

class SelectFriendState extends States {
  final List<FriendsResponse> friends;
  final SelectFriendsScreenState screenState;
  SelectFriendState({ required  this.screenState ,required this.friends});

  List<PaymentFriend> paymentFriends = [];
  List<FriendsResponse> selectedFriends = [];
  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          itemBuilder: (context, index) => SelectFriendCard(
            onDelete: (){
              print('delete');
              selectedFriends.remove(friends[index]);
              screenState.refresh();
            },
              model: friends[index],
              onSelect: () {
                print('select');
                selectedFriends.add(friends[index]);
                 screenState.refresh();
              }),
          shrinkWrap: true,
          itemCount: friends.length,
        ),
        floatingActionButton: selectedFriends.isNotEmpty
            ? FloatingActionButton(
                onPressed: () {
                  selectedFriends.forEach((element) {
                    paymentFriends.add(PaymentFriend(id: element.id ,amount: element.amount,name: element.name));
                  });
                  Navigator.pop(context, paymentFriends);
                },
                child: Icon(Icons.done_all_sharp),
                backgroundColor: Theme.of(context).primaryColor,
              )
            : Container());
  }


}
