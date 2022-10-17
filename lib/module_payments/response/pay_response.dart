class PaymentResponse {
  PaymentResponse({
     this.link,

   });
   String? link;


  PaymentResponse.fromJson(Map<String, dynamic> json)  {
       link =  json["link"];
     }
 }
