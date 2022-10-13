import 'package:cached_network_image/cached_network_image.dart';
import 'package:cater_me_v2/di/di_config.dart';
import 'package:cater_me_v2/module_auth/service/auth_service/auth_service.dart';
import 'package:cater_me_v2/module_home/response/homepage_response.dart';
import 'package:cater_me_v2/module_home/state_manager/homepage_state_manager.dart';
import 'package:cater_me_v2/module_home/ui/widget/item_card.dart';
import 'package:cater_me_v2/module_home/ui/widget/item_details_widget/add_to_cart_sheet.dart';
import 'package:cater_me_v2/utils/global/global_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';

@injectable
class ItemDetailsScreen extends StatefulWidget {
  final HomePageCubit cubit;
  final AuthService _authService;
  const ItemDetailsScreen(
    this.cubit,
    this._authService,
  );

  @override
  State<ItemDetailsScreen> createState() => ItemDetailsScreenState();
}

class ItemDetailsScreenState extends State<ItemDetailsScreen> {
  Item? itemDetails;
  bool flags = true;

  @override
  void initState() {
    super.initState();
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && flags) {
      itemDetails = args as Item;
      flags = false;
    }
    return Scaffold(
        backgroundColor: Theme.of(context).selectedRowColor,
        appBar: AppBar(
          title: Text(
            itemDetails?.title ?? '',
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: itemDetails?.image ?? '',
                child: CachedNetworkImage(
                  imageUrl: itemDetails?.image ?? '',
                  fit: BoxFit.fitWidth,
                  width: double.maxFinite,
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8),
                    child: Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) => AddToCartSheet(
                                    model: itemDetails!, refreshHome: () {
                                 getIt<GlobalStateManager>().updateCartList();
                                }),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15))),
                                isScrollControlled: true,
                                elevation: 5);
                          },
                          icon: Icon(Icons.add_shopping_cart_sharp),
                          label: Text('Add to cart'),
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              )),
                        )),
                  )
                ],
              ),
              Html(
                data: itemDetails?.description ?? '',
                shrinkWrap: true,
              ),
            ],
          ),
        ));
  }
}
