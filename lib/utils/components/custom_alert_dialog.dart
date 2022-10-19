import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_auth/authorization_routes.dart';
import 'package:cater_me_v2/utils/images/images.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String title;

  const CustomDialogBox({required this.title});

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 12, right: 12, top: 40),
          margin: EdgeInsets.only(top: 40),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 18),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AuthorizationRoutes.LOGIN_SCREEN,
                          (route) => false,
                    );
                  },
                  icon: Icon(Icons.login),
                  label: Text(S.of(context).login),
                ),
              )
            ],
          ),
        ),
        Positioned(
          left: 5,
          right: 5,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 40,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Image.asset(ImageAsset.PASSWORD)),
          ),
        ),
      ],
    );
  }
}