class PaymentTypeRequest {
  int? orderId;
  String? cardId;
  String? type;

  PaymentTypeRequest( { this.orderId, this.cardId ,this.type });
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId ?? 0,
      'cardId': cardId,
      'type': type,
    };
  }
}
