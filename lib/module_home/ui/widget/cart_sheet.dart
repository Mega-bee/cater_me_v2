import 'package:cater_me_v2/consts/globale_cart.dart';
import 'package:cater_me_v2/module_home/ui/widget/item_details_widget/order_item_card.dart';
import 'package:flutter/material.dart';

class CartSheet extends StatefulWidget {

  const CartSheet();

  @override
  State<CartSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CartSheet> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        child: ListView(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_month),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              "What's your order?",
                              style: TextStyle(
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "What do you want to order?",
                              style: TextStyle(
                                  fontSize: 10),
                            )
                          ],
                        ),
                      ],
                    ),
                    // SvgPicture.asset(
                    //   ImageAsset.PASSWORD,
                    //   height: 30,
                    // )
                  ],
                ),
              ),
            ),
          ),
          ListView.builder(itemBuilder: (context, index) =>
              OrderItemCard(model: itemsInCart[index]),physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount: itemsInCart.length,)
        ],),
      )
    );


  }
}
