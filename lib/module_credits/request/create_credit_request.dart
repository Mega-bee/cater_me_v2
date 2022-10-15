class CreateCreditRequest {
  int? id;
  String title;
  String dateTime;

  CreateCreditRequest({this.id,required this.title,required this.dateTime});

  Map<String, dynamic> toJson() {
    return {'id': id ?? 0, 'Title': title, "Date": dateTime};
  }
}
