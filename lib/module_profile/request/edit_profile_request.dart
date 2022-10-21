class UpdateProfileRequest {
  String? Name;
  int? gender;
  String? BirthDate;



  UpdateProfileRequest({required this.Name,   this.BirthDate ,this.gender});

  Map<String, dynamic> toJson() {
    return {
      'Name':Name,
      'GenderId':gender,
      'BirthDate':BirthDate,
    };
  }
}
