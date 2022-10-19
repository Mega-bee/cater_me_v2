class NotificationResponse {
  NotificationResponse({
    this.id,
    this.orderId,
    this.title,
    this.description,
    this.descriptionAR,

  });

  int? id;
  int? orderId;
  String? title;
  String? description;
  String? descriptionAR;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
    id: json["id"],
    orderId: json["orderId"],
    title: json["title"],
    descriptionAR: json["descriptionAR"],
    description: json["description"],);
}
