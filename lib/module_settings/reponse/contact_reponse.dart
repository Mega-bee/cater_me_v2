class ContactResponse{
  String? email;
  String? phoneNumber;

  ContactResponse(this.email, this.phoneNumber);

  ContactResponse.fromJson(Map<String, dynamic> json)  {
    email =  json["email"];
    phoneNumber = json["phoneNumber"];

  }
}