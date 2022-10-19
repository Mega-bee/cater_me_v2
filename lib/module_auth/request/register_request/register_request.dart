class RegisterRequest {
  String? password;
  String? userName;
  String? phone;
  String? birtDay;
  int? genderId;


  RegisterRequest({
      this.password, this.userName, this.phone, this.birtDay, this.genderId});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PhoneNumber'] = this.phone;
    data['password'] = this.password;
    data['Name'] = this.userName;
    data['BirthDate'] = this.birtDay;
    data['GenderId'] = this.genderId;
    return data;
  }
}
