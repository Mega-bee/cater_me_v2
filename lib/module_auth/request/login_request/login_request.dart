class LoginRequest {
  String? username;
  String? password;


  LoginRequest({this.username, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PhoneNumber'] = this.username;
    data['Password'] = this.password;
    return data;
  }
}
