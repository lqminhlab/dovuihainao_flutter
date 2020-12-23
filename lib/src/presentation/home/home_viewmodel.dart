import 'dart:async';
import 'dart:math';

import 'package:rxdart/rxdart.dart';
import 'package:dovuihainao_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../resource/resource.dart';
import '../base/base.dart';

enum OrientationType { left, right, top, bottom }

class HomeViewModel extends BaseViewModel {
  final OtherRepository repository;
  final Random rd = Random();
  final BehaviorSubject<bool> victorySubject = new BehaviorSubject();
  final BehaviorSubject<bool> lostSubject = new BehaviorSubject();

  HomeViewModel({@required this.repository});

  init() async {}

  void updateLost() async {
    lostSubject.add(false);
    ProcessModel process = await AppShared.getProcess();
    await AppShared.setProcess(ProcessModel(score: process.heart - 1));
    notifyListeners();
  }

  void updateWin() async {
    victorySubject.add(false);
    ProcessModel process = await AppShared.getProcess();
    await AppShared.setProcess(ProcessModel(score: process.score + 1));
    notifyListeners();
  }

  Future<QuestionModel> randomQuestion() async {
    ProcessModel process = await AppShared.getProcess();
    if (process != null && process.questions != null) {
      int index = rd.nextInt(process.questions.length);
      QuestionModel question = process.questions[index];
      process.questions.removeAt(index);
      await AppShared.setProcess(process);
      await Future.delayed(Duration(seconds: 1));
      return question;
    } else
      return null;
  }
}
