class CreateFriendRequest {
  int? id;
  String name;
  String phone;

  CreateFriendRequest({this.id,required this.name,required this.phone});

  Map<String, dynamic> toJson() {
    return {'id': id ?? 0, 'Name': name, "PhoneNumber": phone};
  }
}
