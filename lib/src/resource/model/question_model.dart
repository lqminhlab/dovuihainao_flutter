/// ID : "1"
/// CauHoi : "Phải làm gì để theo đuổi giấc mơ?"
/// A : "Tắt báo thức"
/// B : "Có ý chí"
/// C : "Quyết tâm"
/// D : "Chăm chỉ"
/// GiaiThich : "Tắt báo thức ngủ tiếp chúng ta sẽ tiếp tục giấc mơ của mình"
/// isvisible : "1"
/// uid : "default"
/// qtime : "2017-02-06"
/// level : "2"

class QuestionModel {
  String id;
  String cauHoi;
  String a;
  String b;
  String c;
  String d;
  String giaiThich;
  String isvisible;
  String uid;
  String qtime;
  String level;

  QuestionModel({
      this.id, 
      this.cauHoi, 
      this.a, 
      this.b, 
      this.c, 
      this.d, 
      this.giaiThich, 
      this.isvisible, 
      this.uid, 
      this.qtime, 
      this.level});

  QuestionModel.fromJson(dynamic json) {
    id = json["ID"];
    cauHoi = json["CauHoi"];
    a = json["A"];
    b = json["B"];
    c = json["C"];
    d = json["D"];
    giaiThich = json["GiaiThich"];
    isvisible = json["isvisible"];
    uid = json["uid"];
    qtime = json["qtime"];
    level = json["level"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["ID"] = id;
    map["CauHoi"] = cauHoi;
    map["A"] = a;
    map["B"] = b;
    map["C"] = c;
    map["D"] = d;
    map["GiaiThich"] = giaiThich;
    map["isvisible"] = isvisible;
    map["uid"] = uid;
    map["qtime"] = qtime;
    map["level"] = level;
    return map;
  }

}