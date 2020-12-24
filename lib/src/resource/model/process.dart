import 'package:dovuihainao_flutter/src/resource/model/model.dart';

class ProcessModel {
  int score;
  int offset;
  int heart;
  bool sound;
  List<QuestionModel> questions;

  ProcessModel(
      {this.questions, this.heart, this.offset, this.score, this.sound});

  ProcessModel copyWith(
      {List<QuestionModel> questions,
      int heart,
      int offset,
      int score,
      bool sound}) {
    return ProcessModel(
        questions: questions ?? this.questions,
        offset: offset ?? this.offset,
        score: score ?? this.score,
        heart: heart ?? this.heart,
        sound: sound ?? this.sound);
  }

  ProcessModel.fromJson(dynamic json) {
    questions = json["questions"] != null
        ? QuestionModel.listFromJson(json["questions"])
        : [];
    score = json["score"];
    heart = json["heart"];
    offset = json["offset"];
    sound = json["sound"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["questions"] = questions;
    map["score"] = score;
    map["heart"] = heart;
    map["offset"] = offset;
    map["sound"] = sound;
    return map;
  }
}
