import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessRateAlter extends StatelessWidget {
  const SuccessRateAlter({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      // backgroundColor: Colors.transparent,
      backgroundColor: Theme.of(context).cardColor,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return  Container(
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
          Lottie.asset(LottieAsset.STARS),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              S.of(context).thankFeedBack,
              style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 18),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(S.of(context).ok),
            ),
          )
        ],
      ),
    );
  }
}
