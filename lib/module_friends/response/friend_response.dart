class FriendsResponse {
  FriendsResponse({
     this.id,
     this.name,
     this.phoneNumber,
     this.email,
     this.image,
    this.isSelected = false,
    this.amount
   });

    int? id;
   String? name;
   String? phoneNumber;
   String? email;
   String? image;
   bool ? isSelected;
   num? amount;


  FriendsResponse.fromJson(Map<String, dynamic> json)  {
       name =  json["name"];
       id = json["id"];
       image = json["image"];
       phoneNumber = json["phoneNumber"];
       email = json["email"];
       isSelected = false;
       amount = 0;

     }
 }
