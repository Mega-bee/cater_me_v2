class RateOptionResponse {
  int? id;
  String? titleAr;
  String? title;

  RateOptionResponse({this.id, this.titleAr, this.title});
  RateOptionResponse.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    titleAr = json["titleAr"];
    title = json["title"];
  }
}
