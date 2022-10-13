import 'package:cached_network_image/cached_network_image.dart';
import 'package:cater_me_v2/module_home/response/homepage_response.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OrderItemCard extends StatefulWidget {
  final Item model;
  const OrderItemCard({required this.model});

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: CachedNetworkImage(
                    key: UniqueKey(),
                    imageUrl: widget.model.image ?? '',
                    fit: BoxFit.cover,
                    height: 105,
                    imageBuilder: (context, imageProvider) => Container(
                      // width: 150,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
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
                flex: 1,
                fit: FlexFit.loose,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.model.title ?? ''),
                    Text(
                      "${widget.model.price}" + ".0" +" SAR" ,
                      style: GoogleFonts.poppins(
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Theme.of(context).primaryColorDark),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              if (widget.model.selectedQuantity != widget.model.max) {
                                widget.model.selectedQuantity =
                                (widget.model.selectedQuantity! +
                                    widget.model.increment!);
                              }
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.add_box_rounded,
                              size: 35,
                            )),
                        Text(
                          widget.model.selectedQuantity.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        IconButton(
                            onPressed: () {
                              if (widget.model.selectedQuantity != widget.model.min) {
                                widget.model.selectedQuantity =
                                (widget.model.selectedQuantity! -
                                    widget.model.increment!);
                              }
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.indeterminate_check_box,
                              size: 35,
                            )),
                        Icon(Icons.delete ,size: 20,),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(thickness: 2,indent: 50,endIndent: 50,)
        ],
      ),
    );
  }
}
