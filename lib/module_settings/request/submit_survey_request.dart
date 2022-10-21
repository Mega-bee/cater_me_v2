class SubmitSurveyRequest {
  String? complain;
  List<FeedBackOptions>? options;

  SubmitSurveyRequest({this.complain, this.options});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['complaint'] = complain;
    data['feedbackOptions'] = List<dynamic>.from(options!.map((x) => x.toJson()));
    return data;
  }

}
class FeedBackOptions{
  int? id;
  double? rate;

  FeedBackOptions({this.id, this.rate});
  Map<String, dynamic> toJson() {
    return {'id': id ?? 0, 'rating': rate,  };
  }
}