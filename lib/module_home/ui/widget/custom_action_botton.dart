import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_home/ui/widget/cart_sheet.dart';
import 'package:flutter/material.dart';


class CustomActionButton extends StatefulWidget {

  const CustomActionButton();

  @override
  State<CustomActionButton> createState() => _CustomActionButtonState();
}

class _CustomActionButtonState extends State<CustomActionButton>
    with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 500);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(25, 1, 25, 5),
      child: InkWell(
        onTap: (){
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            transitionAnimationController: controller,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(30))),
            isScrollControlled: true,
            context: context,
            elevation: 5,
            builder: (BuildContext context) {
              return  CartSheet( );
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius:
              BorderRadius.all(  Radius.circular(30))),
          child: ListTile(title:  Text(
            S.of(context).whatOrder,
            style: TextStyle(fontSize: 14,color: Colors.white),
          ),subtitle:Text(
            S.of(context).whatOrderYouWant,
            style: TextStyle(fontSize: 10,color: Colors.white),
          )
            ,leading:  Icon(Icons.calendar_month,color: Colors.white),trailing: Icon(
                Icons.add_circle_outline,
                size: 30,
                color: Colors.white
            ),),),
      ),
    );
  }
}
