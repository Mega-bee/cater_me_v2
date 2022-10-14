import 'package:cater_me_v2/consts/globale_cart.dart';
import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_home/ui/widget/item_details_widget/order_item_card.dart';
import 'package:cater_me_v2/utils/components/custom_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

class CartSheet extends StatefulWidget {
  const CartSheet();

  @override
  State<CartSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CartSheet> {
  var titleController = TextEditingController();
  late DateTime _selectedDate;
  late TimeOfDay _selectTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
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
                    child: ListTile(title:  Text(
                    S.of(context).whatOrder,
                    style: TextStyle(fontSize: 14,color: Colors.white),
                  ),subtitle:Text(
                    S.of(context).whatOrderYouWant,
                    style: TextStyle(fontSize: 10,color: Colors.white),
                  )
                    ,leading:  Icon(Icons.calendar_month,color: Colors.white),trailing: Icon(
                      Icons.add_circle_outline,
                      size: 30,
                          color: Colors.white
                    ),),),

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
                    padding: const EdgeInsets.all(5.0),
                    child: DayPicker.single(
                        selectedDate: _selectedDate,
                        firstDate:DateTime(2020),
                        lastDate: DateTime(2025),
                        onChanged: (DateTime value) {
                          print(value);
                          _selectedDate = value;
                          setState(() {});
                        },
                      datePickerLayoutSettings: DatePickerLayoutSettings(scrollPhysics :NeverScrollableScrollPhysics())
                    ),
                  ),

                  //time
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              S.of(context).timeOfEvent,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                _selectTime = (await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now()))!;
                                setState(() {

                                });
                              },
                              child: Text(_selectTime.format(context)),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(color: Theme.of(context).primaryColor , width: 2,)
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),


                  //items
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
                      // color: Theme.of(context).cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListView.builder(
                          itemBuilder: (context, index) => OrderItemCard(
                            model: itemsInCart[index],
                            onDelete: () {
                              itemsInCart.remove(itemsInCart[index]);
                              setState(() { });
                            },
                          ),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: itemsInCart.length,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}
