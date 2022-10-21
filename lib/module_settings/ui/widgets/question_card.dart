import 'package:cater_me_v2/module_settings/reponse/rateing_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class QuestionCard extends StatelessWidget {
  final RateOptionResponse model;
  final Function(num) onRateUpdate;

    QuestionCard({required this.model, required this.onRateUpdate});

  bool isArabic = false;
  @override
  Widget build(BuildContext context) {
    isArabic =  Localizations.localeOf(context).languageCode == 'ar'  ? true : false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(isArabic ? model.titleAr?? '' :model.title ?? '' ,
              style: TextStyle(fontWeight: FontWeight.w500 ,fontSize: 16),),
            SizedBox(height: 5,),
            Center(
              child: RatingBar.builder(
                initialRating: 0,
                itemCount: 5,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return Icon(
                        Icons.sentiment_very_dissatisfied,
                        color: Colors.red,

                      );
                    case 1:
                      return Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.redAccent,
                      );
                    case 2:
                      return Icon(
                        Icons.sentiment_neutral,
                        color: Colors.amber,
                      );
                    case 3:
                      return Icon(
                        Icons.sentiment_satisfied,
                        color: Colors.lightGreen,
                      );
                    case 4:
                      return Icon(
                        Icons.sentiment_very_satisfied,
                        color: Colors.green,
                      );
                  }
                  return Icon(
                    Icons.star,
                    color: Colors.amber,
                  );
                },
                onRatingUpdate: (rating) {
                  onRateUpdate(rating);
                },
              ),
            )
          ]),
        ),
        SizedBox(height: 10,),
        Divider(height: 1,thickness: 1,endIndent: 50,indent: 50,)
      ],
    );
  }
}
