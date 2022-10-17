class PaymentRequest {
  int? orderId;
  String? cardId;

  PaymentRequest( { this.orderId, this.cardId });
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId ?? 0,
      'cardId': cardId,
    };
  }
}
