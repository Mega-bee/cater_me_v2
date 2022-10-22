import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_friends/response/friend_response.dart';
import 'package:cater_me_v2/utils/components/custom_feild.dart';
import 'package:flutter/material.dart';

class SelectFriendCard extends StatefulWidget {
  final FriendsResponse model;
  final VoidCallback onSelect;
  final VoidCallback onDelete;
  const SelectFriendCard({ required this.model, required this.onSelect, required this.onDelete}) ;

  @override
  State<SelectFriendCard> createState() => _SelectFriendCardState();
}

class _SelectFriendCardState extends State<SelectFriendCard> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(widget.model.isSelected!){
          widget.model.isSelected = false;
          setState(() {});
          widget.onDelete();
        }else{
         showDialog(context: context, builder: (context) => showAlertForAmount(),);
        }
      },
      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              ListTile(
                title: Text(widget.model.name ?? ''),
                subtitle: Text(widget.model.phoneNumber ?? ''),
                trailing:  Icon(
                  widget.model.isSelected! ?
                  Icons.check_circle_sharp:
                  Icons.circle_outlined ,color: Colors.green,size: 45,),
              ),
              !widget.model.isSelected! ? Container():
              Text(widget.model.amount.toString() + S.of(context).sar  ,style: TextStyle(fontWeight: FontWeight.bold ),)
            ],
          ),
        ),
      )
    );
  }



  Widget showAlertForAmount( ){
    var amountController = TextEditingController();
    return AlertDialog(title: Text(S.of(context).addAmount),actions: [
      TextButton(onPressed: (){
        widget.model.amount =int.parse( amountController.text);
        widget.model.isSelected = true;
        setState(() {});
        Navigator.pop(context);
        widget.onSelect();
      }, child: Text(S.of(context).add))
    ],content: CustomFormField(hintText: S.of(context).amount,
      numbers: true,controller: amountController, ),);
  }
}
