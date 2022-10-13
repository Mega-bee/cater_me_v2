import 'package:cached_network_image/cached_network_image.dart';
import 'package:cater_me_v2/module_home/homepage_route.dart';
import 'package:cater_me_v2/module_home/response/homepage_response.dart';
import 'package:flutter/material.dart';


class MenusCard extends StatelessWidget {
  final Item? model;
  const MenusCard({ required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, HomePageRoutes.itemsDetails,
            arguments: model);
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
        color: Colors.grey.shade50,
        child: Hero(
          tag: model?.image ?? '',
          child: CachedNetworkImage(
            // cacheManager: customCacheManager,
            // maxHeightDiskCache: 100,
            key: UniqueKey(),
            imageUrl: model?.image ?? '',
            fit: BoxFit.cover,
            color: Colors.grey.shade50,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fitWidth,

                ),
              ),
            ),
            // placeholder: (context, url) => Center(
            //   child: LoadingAnimationWidget.inkDrop(
            //       color: Theme.of(context).primaryColor, size: 20),
            // ),
            errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
          ),
        ),
      ),
    );
  }
}
