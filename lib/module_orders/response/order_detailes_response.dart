
import 'package:cater_me_v2/module_addresses/response/address_response.dart';
import 'package:cater_me_v2/module_credits/response/credit_response.dart';
import 'package:cater_me_v2/module_home/response/homepage_response.dart';

class OrderDetailsResponse {
  OrderDetailsResponse({

    this.address,
    this.orderItems,
    this.event,
    // this.creditCard,
    this.setupItems,
    this.total,
  });


  AddressResponse? address;
  List<OrderItem>? orderItems;
  Event? event;
  // CreditsResponse? creditCard;
  List<NumberOfGuest>? setupItems;
  int? total;


  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) => OrderDetailsResponse(
    address: AddressResponse.fromJson(json["address"]),
    orderItems: List<OrderItem>.from(json["orderItems"].map((x) => OrderItem.fromJson(x))),
    event: Event.fromJson(json["event"]),
    // creditCard: CreditsResponse.fromJson(json["creditCard"]),
    setupItems: List<NumberOfGuest>.from(json["setupItems"].map((x) => x)),
    total: json["total"],
  );

}

class OrderItem {
  OrderItem({
    this.imageAr,
    this.item,
    this.itemAr,
    this.quantity,
    this.price,
    this.image,
    this.total,
    this.tax,
  });

  String? imageAr;
  String? item;
  String? itemAr;
  int? quantity;
  int? price;
  String? image;
  int? total;
  int? tax;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      OrderItem(
        imageAr: json["imageAR"],
        item: json["item"],
        itemAr: json["itemAR"],
        quantity: json["quantity"],
        price: json["price"],
        image: json["image"],
        total: json["total"],
        tax: json["tax"],
      );
}
class Event {
  Event({
    this.eventType,
    this.eventName,
    this.eventDate,
    this.numberOfGuests,
    this.numberOfGuestsAr,
    this.contactPhoneNumber,
    this.contactName,
  });

  String? eventType;
  String? eventName;
  DateTime? eventDate;
  String? numberOfGuests;
  String? numberOfGuestsAr;
  String? contactPhoneNumber;
  String? contactName;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    eventType: json["eventType"],
    eventName: json["eventName"],
    eventDate: DateTime.parse(json["eventDate"]),
    numberOfGuests: json["numberOfGuests"],
    numberOfGuestsAr: json["numberOfGuestsAr"],
    contactPhoneNumber: json["contactPhoneNumber"],
    contactName: json["contactName"],
  );

}