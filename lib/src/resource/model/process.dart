import 'package:dovuihainao_flutter/src/resource/model/model.dart';

class ProcessModel {
  int score;
  int offset;
  int heart;
  List<QuestionModel> questions;

  ProcessModel({this.questions, this.heart, this.offset, this.score});

  ProcessModel copyWith(
      {List<QuestionModel> questions, int heart, int offset, int score}) {
    return ProcessModel(questions: questions ?? this.questions,
        offset: offset ?? this.offset,
        score: score ?? this.score,
        heart : heart ?? this.heart);
  }

  ProcessModel.fromJson(dynamic json) {
    questions = json["questions"] != null
        ? QuestionModel.listFromJson(json["questions"])
        : [];
    score = json["score"];
    heart = json["heart"];
    offset = json["offset"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["questions"] = questions;
    map["score"] = score;
    map["heart"] = heart;
    map["offset"] = offset;
    return map;
  }
}
