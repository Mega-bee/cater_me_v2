import 'package:cater_me_v2/consts/globale_cart.dart';
import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_home/response/homepage_response.dart';
import 'package:cater_me_v2/utils/components/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

class AddToCartSheet extends StatefulWidget {
  final Item model;
  final Function(bool) refreshHome;
  final bool AlreadyExist;
  final bool loggedUser;
  const AddToCartSheet(
      {required this.model,
      required this.refreshHome,
      required this.AlreadyExist, required this.loggedUser});

  @override
  State<AddToCartSheet> createState() => _AddToCartSheetState();
}

class _AddToCartSheetState extends State<AddToCartSheet> {
  bool isArabic = false;
  @override
  void initState() {
    super.initState();
    if (widget.AlreadyExist) {
    } else
      widget.model.selectedQuantity = widget.model.min ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    isArabic =
        Localizations.localeOf(context).languageCode == 'ar' ? true : false;
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      maxChildSize: 0.6,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView(
            controller: scrollController,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              ListTile(
                title: Text(
                  isArabic
                      ? widget.model.titleAr ?? ''
                      : widget.model.title ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                trailing: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).primaryColor),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(8, 2, 8, 2),
                      child: Text(
                        widget.model.price.toString() + S.of(context).sar,
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
                            color: Theme.of(context).secondaryHeaderColor,
                            child: ListTile(
                              title: Center(
                                  child: Text(
                                S.of(context).minQuantity,
                                style: TextStyle(fontWeight: FontWeight.w700),
                              )),
                              subtitle: Center(
                                  child: Text(widget.model.min.toString() +
                                      S.of(context).Item)),
                            ))),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: Container(
                            color: Theme.of(context).secondaryHeaderColor,
                            child: ListTile(
                              title: Center(
                                  child: Text(
                                S.of(context).maxQuantity,
                                style: TextStyle(fontWeight: FontWeight.w700),
                              )),
                              subtitle: Center(
                                  child: Text(widget.model.max.toString() +
                                      S.of(context).Item)),
                            ))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(S.of(context).increment +' : '),
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
                                  widget.model.min) {
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

                        Text(
                          widget.model.selectedQuantity.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        IconButton(
                            onPressed: () {
                              if (widget.model.selectedQuantity !=
                                  widget.model.max) {
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
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(2, 1, 5, 3),
                        child: ElevatedButton(
                            onPressed: () {
                              if(widget.loggedUser){
                                if(widget.model.isMenu){
                                  var f = itemsInCart.where((element) => element.isMenu);
                                  if(f.isNotEmpty && f.first.id != widget.model.id){
                                    showDialog(context: context,
                                      builder: (context) => showAlertForAnotherMenu(f.first.title ??'' , (){
                                        itemsInCart.remove(f.first);
                                        itemsInCart.add(widget.model);
                                        Navigator.pop(context);
                                        widget.refreshHome(true);
                                      }),);
                                  }else
                                    if(f.isNotEmpty && f.first.id == widget.model.id){
                                      itemsInCart.remove(widget.model);
                                      itemsInCart.add(widget.model);
                                      Navigator.pop(context);
                                      widget.refreshHome(true);
                                  }
                                  else{
                                    itemsInCart.add(widget.model);
                                    Navigator.pop(context);
                                    widget.refreshHome(true);
                                  }
                                }else{
                                  if (widget.AlreadyExist) {
                                    itemsInCart.remove(widget.model);
                                  }
                                  itemsInCart.add(widget.model);
                                  Navigator.pop(context);
                                  widget.refreshHome(true);
                                }
                              }else {
                                showDialog(context: context,builder: (context) =>
                                    CustomDialogBox(title: S.of(context).loginAlert,),);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:widget.AlreadyExist ? Colors.yellow.shade900: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            child:widget.AlreadyExist ?
                            Text(
                              S.of(context).changeQuantity,
                              style: TextStyle(color: Colors.white),
                            ):
                            Text(
                              S.of(context).addToCart,
                              style: TextStyle(color: Colors.white),
                            )),
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  widget.AlreadyExist
                      ? InkWell(
                          onTap: () {
                            itemsInCart.remove(widget.model);
                            Navigator.pop(context);
                            widget.refreshHome(false);
                          },
                          child: Icon(
                            Icons.delete,
                            size: 35,
                            color: Colors.red,
                          ))
                      : Container()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  showAlertForAnotherMenu (String menuTitle , VoidCallback replaceMenu){
  return  AlertDialog(
      title: Text(S.of(context).warning , style: TextStyle(color: Colors.yellow.shade700),),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(S.of(context).alreadySelect +' ${menuTitle}'),
          SizedBox(height: 12,),
          Text(S.of(context).removeMenu),
        ],
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
          replaceMenu();
        }, child: Text(S.of(context).ok)),
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text(S.of(context).cancel)),
    ],);
  }
}
