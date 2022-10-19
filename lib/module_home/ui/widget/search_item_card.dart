import 'package:cached_network_image/cached_network_image.dart';
import 'package:cater_me_v2/module_home/homepage_route.dart';
import 'package:cater_me_v2/module_home/response/homepage_response.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SearchItemCard extends StatelessWidget {
  final Item model;
    SearchItemCard({  required this.model}) ;

  bool isArabic = false;
  @override
  Widget build(BuildContext context) {
    isArabic =  Localizations.localeOf(context).languageCode == 'ar'  ? true : false;
    return  InkWell(
      onTap: (){
        Navigator.pushNamed(context, HomePageRoutes.itemsDetails,
            arguments: model);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Hero(
                    tag: model.image ?? '',
                    child: CachedNetworkImage(
                      key: UniqueKey(),
                      imageUrl:isArabic?  model.imageAr ?? '' :  model.image ?? '',
                      fit: BoxFit.cover,
                      height: 105,
                      color: Theme.of(context).cardColor,
                      imageBuilder: (context, imageProvider) => Container(
                        // width: 150,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(20)),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                      placeholder: (context, url) => Center(
                        child: LoadingAnimationWidget.inkDrop(
                            color: Theme.of(context).primaryColor, size: 20),
                      ),
                      errorWidget: (context, url, error) =>
                          Center(child: Icon(Icons.error)),
                    ),
                  ),
                ),
                SizedBox(width: 15,),
                Flexible(
                  flex: 2,
                  fit: FlexFit.loose,
                  child:  Text(isArabic ? model.titleAr ?? '' : model.title ?? ''),
                ) ,

              ],
            ),
            SizedBox(height: 10,),
            Divider(height: 1 ,thickness: 1,endIndent: 40,indent: 40,)
          ],
        ),
      ),
    );
  }
}
