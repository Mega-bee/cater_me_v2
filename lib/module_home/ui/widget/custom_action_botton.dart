import 'package:cater_me_v2/module_home/ui/widget/cart_sheet.dart';
import 'package:flutter/material.dart';
import 'package:tip_dialog/tip_dialog.dart';

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
      padding: const EdgeInsets.all(8.0),
      child: Theme(
        data: Theme.of(context).copyWith(
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
          extendedSizeConstraints: BoxConstraints.tightFor(
            height: 65,
          ),
        )),
        child: FloatingActionButton.extended(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              transitionAnimationController: controller,
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(15))),
              isScrollControlled: true,
              context: context,
              elevation: 5,
              builder: (BuildContext context) {
                return  CartSheet( );
              },
            );
            },
          label: Row(
            children: [
              Icon(Icons.calendar_month),
              SizedBox(width: 15),
              Padding(
                padding: const EdgeInsets.only(
                  top: 70.0,
                  bottom: 70.0,
                  right: 120.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What's your order?",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "What do you want to order?",
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
              Icon(
                Icons.add_circle_outline,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
