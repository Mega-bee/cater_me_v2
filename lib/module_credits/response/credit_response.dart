class CreditsResponse {
  CreditsResponse({
     this.id,
     this.name,
    this.cardId,
    this.cardNumber,
    this.expiryDate,
    this.type


   });

    int? id;
    String? cardId;
   String? name;

   String? expiryDate;
   String? cardNumber;
   String? type;


  CreditsResponse.fromJson(Map<String, dynamic> json)  {
       name =  json["ownerName"];
       id = json["id"];
       cardId = json["cardId"];
       expiryDate = json["expiryDate"];
       cardNumber = json["cardNumber"];
       type = json["type"];

     }
 }
