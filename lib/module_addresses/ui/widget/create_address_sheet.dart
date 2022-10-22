import 'dart:math';

import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_addresses/request/create_address_request.dart';
import 'package:cater_me_v2/module_addresses/response/address_response.dart';
import 'package:cater_me_v2/module_addresses/ui/widget/choose_location_wedgit.dart';
import 'package:cater_me_v2/utils/components/custom_feild.dart';
import 'package:cater_me_v2/utils/components/custom_loading_button.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateAddressSheet extends StatefulWidget {
  final Function(CreateAddressRequest) createAddress;
  final AddressResponse? response;
  final bool isUpdated;
  const CreateAddressSheet(
      {required this.createAddress, this.response, required this.isUpdated});

  @override
  State<CreateAddressSheet> createState() => _CreateOccasionCardState();
}

class _CreateOccasionCardState extends State<CreateAddressSheet> {
  var titleController = TextEditingController();
  var cityController = TextEditingController();

  var buldingNameController = TextEditingController();
  var floorController = TextEditingController();
  var streetController = TextEditingController();

  LatLng? addressLoca;
   CameraPosition ca = CameraPosition(target: LatLng(0, 0));
  final GlobalKey<FormState> _addAddressKey = GlobalKey<FormState>();
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    if (widget.isUpdated) {
      titleController.text = widget.response?.title ?? '';
      cityController.text = widget.response?.city ?? '';
      buldingNameController.text = widget.response?.buildingName ?? '';
      floorController.text = widget.response?.floorNumber.toString() ?? '';
      streetController.text = widget.response?.street ?? '';
      if (widget.response!.latitude!.isEmpty ||
          widget.response!.longitude!.isEmpty) {
      } else {
        addressLoca = LatLng(double.parse(widget.response?.latitude ?? '0.0'),
            double.parse(widget.response?.longitude ?? '0.0'));
        ca = CameraPosition(target: addressLoca!, zoom: 15);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      maxChildSize: 1.0,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        child: ListView(
          controller: scrollController,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Form(
              key: _addAddressKey,
              child: Column(
                children: [
                  CustomFormField(
                    validator: true,
                    preIcon: Icon(
                      Icons.title,
                    ),
                    hintText: S.of(context).titleAddress,
                    controller: titleController,
                  ),

                  CustomFormField(
                    validator: true,
                    preIcon: Icon(
                      Icons.location_history,
                    ),
                    hintText: S.of(context).street,
                    controller: streetController,
                  ),
                  CustomFormField(
                    validator: true,
                    preIcon: Icon(
                      Icons.business_rounded,
                    ),
                    hintText: S.of(context).buildingName,
                    controller: buldingNameController,
                  ),
                  CustomFormField(
                    validator: true,
                    numbers: true,
                    preIcon: Icon(
                      Icons.business_rounded,
                    ),
                    hintText: S.of(context).floorNumber,
                    controller: floorController,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).secondaryHeaderColor
                    ),
                    child: widget.isUpdated
                        ? TextButton.icon(icon: Icon(Icons.location_on),label: Text(S.of(context).updateLocation,),onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChooseLocationWidget(
                                previousLocation: addressLoca,
                              ))).then((value) {
                        if (value != null) {
                          addressLoca = value as LatLng;
                          ca = CameraPosition(
                              target: addressLoca!, zoom: 15);
                          mapController?.animateCamera(CameraUpdate.newCameraPosition(ca));
                          setState(() {});
                        }
                      });
                    },)
                        :TextButton.icon(icon: Icon(Icons.location_on),label: Text(S.of(context).selectLocation,),onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChooseLocationWidget(
                                previousLocation: addressLoca,
                              ))).then((value) {
                        if (value != null) {
                          addressLoca = value as LatLng;
                          ca = CameraPosition(
                              target: addressLoca!, zoom: 15);
                          mapController?.animateCamera(CameraUpdate.newCameraPosition(ca));
                          setState(() {});
                        }
                      });
                    },),
                  ),
                  addressLoca != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 150,
                            child: GoogleMap(
                              onMapCreated: (controller){
                                setState(() {
                                  mapController = controller;
                                });
                              },
                              markers: {
                              Marker(
                                  markerId: MarkerId(
                                      Random().nextInt(100).toString()),
                                  position: addressLoca!)
                            }, initialCameraPosition: ca,),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomLoadingButton(
                bgColor: Theme.of(context).primaryColor,
                text: widget.isUpdated
                    ? S.of(context).updateAddress
                    : S.of(context).createAddress,
                textColor: Colors.white,
                loading: false,
                buttonTab: () {
                  if (_addAddressKey.currentState!.validate() && addressLoca !=null) {
                    widget.createAddress(CreateAddressRequest(
                        0,
                        cityController.text,
                        streetController.text,
                        buldingNameController.text,
                        titleController.text,
                        addressLoca?.longitude.toString(),
                        addressLoca?.latitude.toString(),
                        int.parse(floorController.text)));
                  }else{
                    Fluttertoast.showToast(msg: S.of(context).selectLocation);
                  }
                },
              ),
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}
