import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_credits/request/create_credit_request.dart';
import 'package:cater_me_v2/module_credits/response/credit_response.dart';
import 'package:cater_me_v2/utils/components/custom_feild.dart';
import 'package:cater_me_v2/utils/components/custom_loading_button.dart';
import 'package:flutter/material.dart';
 import 'package:fluttercontactpicker/fluttercontactpicker.dart';


class CreateCreditSheet extends StatefulWidget {
  final Function(CreateCreditRequest) createCredit;
  final CreditsResponse? response;
  const CreateCreditSheet(
      {required this.createCredit, this.response});

  @override
  State<CreateCreditSheet> createState() => _CreateOccasionCardState();
}

class _CreateOccasionCardState extends State<CreateCreditSheet> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();


  final GlobalKey<FormState> _addFriendKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        child: ListView(
          controller: scrollController,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [

            Form(
              key: _addFriendKey,
              child: Column(children: [
                CustomFormField(
                  validator: true,
                  preIcon: Icon(
                    Icons.person,
                  ),
                  hintText: S.of(context).friendName,
                  controller: nameController,
                ),
                CustomFormField(
                  validator: true,
                  preIcon: Icon(
                    Icons.phone_android,
                  ),
                  hintText: S.of(context).phoneNumber,
                  controller: phoneController,
                ),
              ],),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(S.of(context).selectFromContact,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),
                InkWell(
                  onTap: ()async{

                    final FullContact contact =
                    (await FlutterContactPicker.pickFullContact());
                    print('--------------------------------');
                    print(contact.name?.firstName);
                    print(contact.phones.first.number);
                    setState(() {
                    nameController.text = contact.name?.firstName ?? '';
                    phoneController.text = contact.phones.first.number.toString();
                    });
                  },
                  child: Card(
                      elevation: 3,
                      color:  Colors.green.shade900,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.contact_phone_sharp ,color: Colors.white,size: 20,),
                      )),
                ),
              ],
            ),


            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomLoadingButton(
                bgColor: Theme.of(context).primaryColor,
                text: S.of(context).updateCredit,
                textColor: Colors.white,
                loading: false,
                buttonTab: () {
                  if(_addFriendKey.currentState!.validate()){

                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
