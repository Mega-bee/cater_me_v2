class FriendsResponse {
  FriendsResponse({
     this.id,
     this.name,
     this.phoneNumber,
     this.email,
     this.image,
   });

    int? id;
   String? name;
   String? phoneNumber;
   String? email;
   String? image;


  FriendsResponse.fromJson(Map<String, dynamic> json)  {
       name =  json["name"];
       id = json["id"];
       image = json["image"];
       phoneNumber = json["phoneNumber"];
       email = json["email"];

     }
 }
