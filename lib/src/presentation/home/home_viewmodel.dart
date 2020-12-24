import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dovuihainao_flutter/src/configs/configs.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dovuihainao_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:toast/toast.dart';
import '../../resource/resource.dart';
import '../base/base.dart';

enum OrientationType { left, right, top, bottom }

class HomeViewModel extends BaseViewModel {
  final List<String> chooseImages = [
    AppImages.icAnswerA,
    AppImages.icAnswerB,
    AppImages.icAnswerC,
    AppImages.icAnswerD
  ];
  final OtherRepository repository;
  final Random rd = Random();
  final BehaviorSubject<bool> victorySubject =
      new BehaviorSubject.seeded(false);
  final BehaviorSubject<bool> loseSubject = new BehaviorSubject.seeded(false);
  final BehaviorSubject<bool> gameOverSubject =
      new BehaviorSubject.seeded(false);
  final BehaviorSubject<String> explainSubject = new BehaviorSubject.seeded("");
  final ScreenshotController screenshotController = ScreenshotController();

  bool get disposeAnswer =>
      victorySubject.value || loseSubject.value || gameOverSubject.value;

  HomeViewModel({@required this.repository});

  init() async {
    AppShared.watchProcess().listen((event) {
      if (event != null && event.heart == 0) {
        gameOverSubject.add(true);
      }
    });
  }

  void chooseAnswerFalse() {
    if (!disposeAnswer) {
      loseSubject.add(true);
      AppSound.play("fail.wav");
    }
  }

  void chooseAnswerTrue() {
    if (!disposeAnswer) {
      victorySubject.add(true);
      AppSound.play("victory.wav");
    }
  }

  void updateLose() async {
    loseSubject.add(false);
    await AppShared.setProcessDecrementHeart();
    notifyListeners();
  }

  void updateWin() async {
    victorySubject.add(false);
    await AppShared.setProcessIncrementScore();
    notifyListeners();
  }

  void gameOver() async {
    await AppShared.setProcess(ProcessModel(heart: AppValues.MAX_HEART));
    Navigator.pop(context);
  }

  void shareQuestion() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      Toast.show("Đang xử lý...", context, duration: Toast.LENGTH_SHORT);
      screenshotController
          .capture(delay: Duration(milliseconds: 10), pixelRatio: 3)
          .then((File image) async {
        try {
          await ImageGallerySaver.saveImage(image.readAsBytesSync(),
              quality: 100);
          toastSaveImage(true);
        } catch (e) {
          toastSaveImage(false);
        }
      }, onError: (e) {});
    } else if (status.isDenied)
      toastSaveImage(false);
    else {
      await Permission.storage.request();
      shareQuestion();
    }
  }

  void toastSaveImage(bool status) {
    Toast.show(
        status
            ? "Lưu câu hỏi thành công.\nChia sẽ với bạn bè để được giúp đỡ!"
            : "Lỗi khi lưu câu hỏi!",
        context,
        duration: Toast.LENGTH_LONG);
  }

  Future<QuestionModel> randomQuestion() async {
    ProcessModel process = await AppShared.getProcess();
    int index = process?.offset ?? 0;
    if (process != null &&
        process.questions != null &&
        process.questions.length != 0) {
      int index = rd.nextInt(process.questions.length);
      QuestionModel question = process.questions[index];
      process.questions.removeAt(index);
      process.offset = process.offset + 1;
      await AppShared.setProcess(process);
      await Future.delayed(Duration(milliseconds: 750));
      if (question.giaiThich != null && question.giaiThich.length != 0)
        explainSubject.add(question.giaiThich);
      else
        explainSubject.add(randomExplain());
      return question;
    } else {
      Toast.show("Đang tải thêm câu hỏi!", context,
          duration: Toast.LENGTH_LONG);
      final NetworkState<List<QuestionModel>> rs =
          await repository.getQuestionByIndex(index: index);
      if (rs?.data != null && rs?.data?.length != 0) {
        await AppShared.setProcess(process.copyWith(questions: rs.data));
      }
      return await randomQuestion();
    }
  }

  String randomExplain() {
    int index = rd.nextInt(AppValues.RANDOM_EXPLAIN.length);
    return AppValues.RANDOM_EXPLAIN[index];
  }

  @override
  void dispose() async {
    super.dispose();
    await gameOverSubject.drain();
    gameOverSubject.close();
    await victorySubject.close();
    victorySubject.close();
    await loseSubject.drain();
    loseSubject.close();
  }
}
