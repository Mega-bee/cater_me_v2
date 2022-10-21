import 'package:cater_me_v2/consts/globale_cart.dart';
import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_addresses/address_route.dart';
import 'package:cater_me_v2/module_addresses/response/address_response.dart';
import 'package:cater_me_v2/module_friends/friends_route.dart';
import 'package:cater_me_v2/module_home/request/place_order_request.dart';
import 'package:cater_me_v2/module_home/response/homepage_response.dart';
import 'package:cater_me_v2/module_home/ui/widget/item_details_widget/order_item_card.dart';
import 'package:cater_me_v2/utils/components/custom_feild.dart';
import 'package:cater_me_v2/utils/components/custom_loading_button.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:tip_dialog/tip_dialog.dart';

class CartSheet extends StatefulWidget {
  final OrderSettings settings;
  final Function(PlaceOrderRequest) onCheckOut;
  const CartSheet(this.settings, this.onCheckOut);

  @override
  State<CartSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CartSheet> {
  var titleController = TextEditingController();
  late DateTime _selectedDate;
  DateTime _now = DateTime.now();
  late TimeOfDay _selectTime;
  bool isDabbrneiActive = false;
  bool isArabic = false;
  late DateTime dabbrneiDate;
  late DateTime orderDate;

  NumberOfGuest? selectedGuest;
  List<NumberOfGuest>  selectedSetupItem = [];
  List<PaymentFriend>  friends = [];
  List<String>  selectedSetupItemNames = [];
  AddressResponse? selectedAddress;
  bool isShisha = false;

  num basePrice = 0;
  // num taxPrice = 0;
  num dabbrneTotalPrice = 0;
  // num totalAmount = 0;
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectTime = TimeOfDay.now();
    checkDabbnei();
  }

  void checkDabbnei() {
    orderDate = DateTime(_selectedDate.year, _selectedDate.month,
        _selectedDate.day, _selectTime.hour, _selectTime.minute);

    dabbrneiDate = DateTime(_now.year, _now.month, _now.day,
        _now.hour + widget.settings.hoursOfDaberni, _now.minute);

    print(dabbrneiDate);
    print('---------------------------');
    print(orderDate);

    if (orderDate.isAfter(dabbrneiDate)) {
      isDabbrneiActive = false;
    } else {
      isDabbrneiActive = true;
    }
    calculatePrice();
  }

  void calculatePrice() {
    basePrice =0;
    dabbrneTotalPrice = 0;
    itemsInCart.forEach((element) {
      basePrice = basePrice + (element.price! * element.selectedQuantity!);
      dabbrneTotalPrice = dabbrneTotalPrice + (element.daberniPrice!* element.selectedQuantity!);
    });
    isShisha =  itemsInCart.contains((element) => element.isShisha == true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    isArabic =
        Localizations.localeOf(context).languageCode == 'ar' ? true : false;
    return Stack(
      children: [
        DraggableScrollableSheet(
            initialChildSize: 0.95,
            // maxChildSize: 0.9,
            builder: (context, scrollController) => Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  child: ListView(
                    controller: scrollController,
                    physics: BouncingScrollPhysics(),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(30))),
                        child: ListTile(
                          title: Text(
                            S.of(context).whatOrder,
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          subtitle: Text(
                            S.of(context).whatOrderYouWant,
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                          leading: Icon(Icons.calendar_month, color: Colors.white),
                          trailing: Icon(Icons.add_circle_outline,
                              size: 30, color: Colors.white),
                        ),
                      ),

                      //title
                      CustomFormField(
                        validator: true,
                        preIcon: Icon(
                          Icons.title,
                        ),
                        hintText: S.of(context).occasionTitle,
                        controller: titleController,
                      ),

                      // date
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
                        child: DayPicker.single(
                            selectedDate: _selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2025),
                            onChanged: (DateTime value) {
                              print(value);
                              _selectedDate = value;
                              setState(() {});
                              checkDabbnei();
                            },
                            datePickerLayoutSettings: DatePickerLayoutSettings(
                                scrollPhysics: NeverScrollableScrollPhysics())),
                      ),

                      //time
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).timeOfEvent,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  showCupertinoModalPopup(builder: (context) =>
                                      Container(
                                        height: 200,
                                        color: Theme.of(context).cardColor,
                                        child: CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.time,
                                          onDateTimeChanged: (value) {
                                            _selectTime = TimeOfDay(hour: value.hour, minute: value.minute);
                                            setState(() {});
                                            checkDabbnei();
                                          },
                                          initialDateTime: DateTime.now(),
                                        ),
                                      ),context: context);
                                },
                                child: Text(_selectTime.format(context)),
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      isDabbrneiActive
                          ? Center(
                              child: Text(
                              'You are in dabbrni mode',
                              style: TextStyle(
                                  color: Colors.red.shade600, fontSize: 18),
                            ))
                          : Container(),

                      // address
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).deliveringTo,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        Navigator.pushNamed(
                                                context, AddressRoutes.VIEW_ADDRESS,
                                                arguments: true)
                                            .then((value) {
                                          if (value != null) ;
                                          value as AddressResponse;
                                          selectedAddress = value;
                                          setState(() {});
                                        });
                                      },
                                      child: Text(S.of(context).select),
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            side: BorderSide(
                                              color: Theme.of(context).primaryColor,
                                              width: 2,
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                                // SizedBox(height: 5,) ,

                                selectedAddress != null
                                    ? ListTile(
                                        title: Text(selectedAddress?.title ?? ''),
                                        subtitle:
                                            Text(selectedAddress?.street ?? ''),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                      ),

                      // friends
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).selectFriendsForBill,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        Navigator.pushNamed(
                                                context, FriendsRoutes.VIEW_SELECT_FRIEND)
                                            .then((value) {
                                          if (value != null) ;
                                          value as List<PaymentFriend>;
                                          friends = value;
                                          setState(() {});
                                        });
                                      },
                                      child: Text(S.of(context).select),
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            side: BorderSide(
                                              color: Theme.of(context).primaryColor,
                                              width: 2,
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                                // SizedBox(height: 5,) ,

                                friends.isNotEmpty
                                    ? Wrap(children: friends.map((e) =>
                                    Row(children: [
                                      Text(e.name.toString() + ' : '),
                                      Text(e.amount.toString() + S.of(context).sar , style: TextStyle(color: Colors.green.shade600),)
                                ],)).toList(),)
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                      ),


                      //items

                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 5,
                          // color: Theme.of(context).cardColor,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ListView.builder(
                              itemBuilder: (context, index) => OrderItemCard(
                                isDarrby: isDabbrneiActive,
                                model: itemsInCart[index],
                                onDelete: () {
                                  itemsInCart.remove(itemsInCart[index]);
                                  calculatePrice();
                                },
                                claulate: (){
                                  calculatePrice();
                                },
                              ),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: itemsInCart.length,
                            ),
                          ),
                        ),
                      ),

                      //number of guest
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(15, 2, 0, 0),
                        child: Text(
                            S.of(context).numberOfGuest,
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                      //   child: Card(
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(12)),
                      //     elevation: 3,
                      //     child: DropdownButton2(
                      //       dropdownFullScreen: true,
                      //
                      //       hint: Text(S.of(context).numberOfGuest),
                      //       items: widget.settings.numberOfGuests
                      //           ?.map((item) => DropdownMenuItem<NumberOfGuest>(
                      //                 value: item,
                      //                 child: Text(
                      //                   isArabic
                      //                       ? item.titleAr ?? ''
                      //                       : item.title ?? '',
                      //                   style: const TextStyle(
                      //                     fontSize: 14,
                      //                   ),
                      //                 ),
                      //               ))
                      //           .toList(),
                      //       onChanged: (value) {
                      //         setState(() {
                      //           selectedGuest = value as NumberOfGuest;
                      //         });
                      //       },
                      //       underline: Container(),
                      //       dropdownElevation: 5,
                      //       isExpanded: true,
                      //       dropdownOverButton: true,
                      //       // dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                      //       dropdownDecoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(4),
                      //         color: Colors.grey.shade200,
                      //       ),
                      //       itemPadding: EdgeInsetsDirectional.all(5),
                      //       value: selectedGuest,
                      //       buttonPadding: EdgeInsetsDirectional.all(5),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 3,
                          child: DropdownSearch<NumberOfGuest>(
                            items: widget.settings.numberOfGuests!,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                // labelText: S.of(context).numberOfGuest,
                                hintText: S.of(context).numberOfGuest,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8)
                                // filled: true,
                              ),
                            ),
                            popupProps: PopupProps.modalBottomSheet(
                              itemBuilder: _customPopupItemBuilderExample2 ,
                              title: Text(S.of(context).numberOfGuest),
                              showSelectedItems: true,
                            ),
                            selectedItem: selectedGuest,
                             onChanged: (v){
                              selectedGuest = v;
                             },
                            itemAsString: (item) => item.title ?? '',
                              compareFn: (item1, item2) => item1.id == item2.id,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      //step of item
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(15, 2, 0, 0),
                        child: Text(
                          S.of(context).setupItem,
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 3,
                          child: DropdownSearch<NumberOfGuest>.multiSelection(

                            // clearButtonProps: ClearButtonProps(isVisible: true),
                            popupProps: PopupPropsMultiSelection.modalBottomSheet(
                              showSelectedItems: true,
                              itemBuilder: _customPopupItemBuilderExample2,
                            ),
                            compareFn: (item, selectedItem) =>
                            item.id == selectedItem.id,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  hintText: S.of(context).setupItem,
                                  contentPadding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                                // filled: true,
                              ),
                            ),
                            dropdownBuilder: _customDropDownExampleMultiSelection,
                            items: widget.settings.setupItems!,
                            onChanged: (value) {
                              selectedSetupItem = value;
                            },
                            selectedItems: selectedSetupItem,
                          ),
                        ),
                      ),

                      // Padding(
                      //   padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 15, 0),
                      //   child: Card(
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(12)),
                      //     elevation: 3,
                      //     child: DropdownButton2(
                      //       hint: Text(S.of(context).setupItem),
                      //       selectedItemBuilder: (context) {
                      //         return widget.settings.setupItems!.map(
                      //               (item) {
                      //             return Container(
                      //               alignment: AlignmentDirectional.center,
                      //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      //               child: Text(
                      //                 selectedSetupItemNames.join(', '),
                      //                 style: const TextStyle(
                      //                   fontSize: 14,
                      //                   overflow: TextOverflow.ellipsis,
                      //                 ),
                      //                 maxLines: 1,
                      //               ),
                      //             );
                      //           },
                      //         ).toList();
                      //       },
                      //       items: widget.settings.setupItems
                      //           ?.map((item) => DropdownMenuItem<NumberOfGuest>(
                      //                 value: item,
                      //                 child: StatefulBuilder(
                      //                    builder:(context, menuSetState) {
                      //                      final _isSelected = selectedSetupItem.contains(item);
                      //                      return InkWell(
                      //                        onTap: () {
                      //                          if(_isSelected){
                      //                            selectedSetupItem.remove(item) ;
                      //                          isArabic?  selectedSetupItemNames.remove(item.titleAr)
                      //                              : selectedSetupItemNames.remove(item.title);
                      //                          }else {
                      //                            selectedSetupItem.add(item) ;
                      //                            isArabic?  selectedSetupItemNames.add(item.titleAr ?? '')
                      //                                : selectedSetupItemNames.add(item.title ?? '');
                      //                          }
                      //
                      //                          //This rebuilds the StatefulWidget to update the button's text
                      //                          setState(() {});
                      //                          //This rebuilds the dropdownMenu Widget to update the check mark
                      //                          menuSetState(() {});
                      //                        },
                      //                        child: Container(
                      //                          height: double.infinity,
                      //                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      //                          child: Row(
                      //                            children: [
                      //                              _isSelected
                      //                                  ? const Icon(Icons.check_box_outlined)
                      //                                  : const Icon(Icons.check_box_outline_blank),
                      //                              const SizedBox(width: 16),
                      //                              Text(
                      //                              isArabic ? item.titleAr ?? '' : item.title ?? '',
                      //                              ),
                      //                            ],
                      //                          ),
                      //                        ),
                      //                      );
                      //                    },
                      //                 ),
                      //               ))
                      //           .toList(),
                      //       onChanged: (value) {
                      //       },
                      //       underline: Container(),
                      //       dropdownElevation: 5,
                      //       isExpanded: true,
                      //       dropdownOverButton: true,
                      //       // dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                      //       dropdownDecoration: BoxDecoration( borderRadius: BorderRadius.circular(4),
                      //         color: Colors.grey.shade200,),
                      //       itemPadding: EdgeInsetsDirectional.all(5),
                      //       value: selectedSetupItem.isEmpty ? null : selectedSetupItem.last,
                      //       buttonPadding: EdgeInsetsDirectional.all(5),
                      //
                      //     ),
                      //   ),
                      // ),

                      // total amount
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:  isDabbrneiActive ?  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(S.of(context).dabbrniePrice),
                                         Text(dabbrneTotalPrice.toString() + S.of(context).sar)
                                  ],
                                ) :
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(S.of(context).totalPrice),
                                    Text(basePrice.toString() + S.of(context).sar)

                                  ],
                                )
                              )   ,

                              Divider(
                                height: 1,
                                thickness: 1,
                                endIndent: 10,
                                indent: 10,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(child:
                                 isShisha ? Text(S.of(context).taxShesha , style: TextStyle(color: Colors.red),) :
                                  Text(S.of(context).taxAlert , style: TextStyle(color: Colors.red),))
                            ]),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(15, 8, 15, 8),
                        child: CustomLoadingButton(
                            bgColor: Theme.of(context).primaryColor,
                            text: S.of(context).checkOut,
                            textColor: Colors.white,
                            loading: false,
                            buttonTab: () {
                              if(titleController.text.isNotEmpty){
                                List<int> setup = [];
                                List<OrderItem> orders = [];
                                selectedSetupItem.forEach((element) {
                                  setup.add(element.id ??-1);
                                });
                                itemsInCart.forEach((element) {
                                  orders.add(OrderItem(element.id, element.selectedQuantity));
                                });
                                widget.onCheckOut(
                                    PlaceOrderRequest(
                                        selectedAddress?.id,
                                        isDabbrneiActive ? 2 :1,
                                        titleController.text,
                                        DateFormat('yyyy-MM-dd')
                                            .format(_selectedDate),
                                        _selectTime.format(context).split(' ').first,
                                        selectedGuest?.id,
                                        '', '', setup,orders,friends));
                              }else{
                                Fluttertoast.showToast(msg: 'Write occasion title');
                              }
                            }),
                      )
                    ],
                  ),
                )),
        TipDialogContainer(
            duration: const Duration(seconds: 2),
            outsideTouchable: true,
            onOutsideTouch: (Widget tipDialog) {
              if (tipDialog is TipDialog &&
                  tipDialog.type == TipDialogType.LOADING) {
                TipDialogHelper.dismiss();
              }
            })
      ],
    );
  }
  Widget _customPopupItemBuilderExample2(
      BuildContext context,
      NumberOfGuest? item,
      bool isSelected,
      ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.shade300
      ),
      child: ListTile(
        selected: isSelected,
        title:isArabic? Text(item?.titleAr ?? '') :Text(item?.title ?? ''),
      ),
    );
  }

  Widget _customDropDownExampleMultiSelection(
      BuildContext context, List<NumberOfGuest?> selectedItems) {
    return Wrap(
      children: selectedItems.map((e) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            child: isArabic? Text(e?.titleAr ?? '') :Text(e?.title ?? ''),
          ),
        );
      }).toList(),
    );
  }
}
