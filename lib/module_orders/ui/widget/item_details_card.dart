import 'package:cached_network_image/cached_network_image.dart';
import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_orders/response/order_detailes_response.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ItemDetailsCard extends StatelessWidget {
  final OrderItem model;
    ItemDetailsCard({Key? key, required this.model}) : super(key: key);


  bool isArabic= false;
  @override
  Widget build(BuildContext context) {
    isArabic =  Localizations.localeOf(context).languageCode == 'ar'  ? true : false;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: CachedNetworkImage(
                  key: UniqueKey(),
                  imageUrl:isArabic? model.imageAr ?? '' : model.image ?? '',
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
              SizedBox(width: 15,),
              Flexible(
                flex: 2,
                fit: FlexFit.loose,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(isArabic ? model.itemAr ?? '' : model.itemAr ?? ''),
                    Text(
                       "${model.price}"+S.of(context).sar ,
                      style: GoogleFonts.poppins(
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Colors.green.shade600),
                    ),
                    Text(
                       "${model.quantity}"+' ' + S.of(context).Item ,
                    ),

                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 10,),
          Divider(thickness: 2,indent: 50,endIndent: 50,height: 1,)
        ],
      ),
    );
  }
}
