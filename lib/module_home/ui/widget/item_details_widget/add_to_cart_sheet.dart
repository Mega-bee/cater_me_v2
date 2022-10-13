import 'package:cater_me_v2/consts/globale_cart.dart';
import 'package:cater_me_v2/module_home/response/homepage_response.dart';
import 'package:flutter/material.dart';

class AddToCartSheet extends StatefulWidget {
  final Item model;
  final VoidCallback refreshHome;
  const AddToCartSheet({required this.model, required this.refreshHome});

  @override
  State<AddToCartSheet> createState() => _AddToCartSheetState();
}

class _AddToCartSheetState extends State<AddToCartSheet> {
  @override
  void initState() {
    super.initState();
    widget.model.selectedQuantity = widget.model.min ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      maxChildSize: 0.3,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        child: ListView(
          controller: scrollController,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            ListTile(
              title: Text(
                widget.model.title ?? '',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              trailing: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).primaryColor),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 2, 8, 2),
                    child: Text(
                      widget.model.price.toString() + '.0 SAR',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: Container(
                          color: Colors.grey.shade200,
                          child: ListTile(
                            title: Center(
                                child: Text(
                              'Minimum Quantity',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            )),
                            subtitle: Center(
                                child: Text(
                                    widget.model.min.toString() + ' Item')),
                          ))),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: Container(
                          color: Colors.grey.shade200,
                          child: ListTile(
                            title: Center(
                                child: Text(
                              'Maximum Quantity',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            )),
                            subtitle: Center(
                                child: Text(
                                    widget.model.max.toString() + ' Item')),
                          ))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Increment : '),
                  Text(
                    widget.model.increment.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            if (widget.model.selectedQuantity !=
                                widget.model.max) {
                              widget.model.selectedQuantity =
                                  (widget.model.selectedQuantity! +
                                      widget.model.increment!);
                            }
                            setState(() {

                            });
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
                            if (widget.model.selectedQuantity !=
                                widget.model.min) {
                              widget.model.selectedQuantity =
                                  (widget.model.selectedQuantity! -
                                      widget.model.increment!);
                            }
                            setState(() {

                            });
                          },
                          icon: Icon(
                            Icons.indeterminate_check_box,
                            size: 35,
                          )),
                    ],
                  ),
                ),
                Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(2, 1, 5, 3),
                      child: ElevatedButton(
                          onPressed: () {
                            itemsInCart.add(widget.model);
                            Navigator.pop(context);
                            widget.refreshHome();
                          },
                          child: Text('Add to cart')),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
