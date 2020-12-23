import 'package:dovuihainao_flutter/src/configs/configs.dart';
import 'package:dovuihainao_flutter/src/presentation/presentation.dart';
import 'package:dovuihainao_flutter/src/resource/model/process.dart';
import 'package:dovuihainao_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../resource/resource.dart';
import '../base/base.dart';

class SplashViewModel extends BaseViewModel {
  final List<String> images = [
    AppImages.bgStart,
    AppImages.bgHome,
    AppImages.bgMoreApp,
    AppImages.bgBoardQuestion,
    AppImages.bgAnswerRed,
    AppImages.bgAnswerGreen,
    AppImages.imgBtnStart,
    AppImages.imgBtnStartPress,
    AppImages.imgBtnGameHot,
    AppImages.imgBtnGameHotPress,
    AppImages.imgBtnLike,
    AppImages.imgBtnLikePress,
    AppImages.imgBtnLink,
    AppImages.imgBtnLinkPress,
    AppImages.imgBtnSoundOff,
    AppImages.imgBtnSoundOn,
  ];
  final List<String> sounds = [
    "back.wav",
    "fail.wav",
    "moreapp.wav",
    "music_bg.mp3",
    "play.wav",
    "victory.wav"
  ];
  final OtherRepository repository;

  SplashViewModel({@required this.repository});

  init(BuildContext context) async {
    ProcessModel process = await AppShared.getProcess();
    int index;
    if (process == null ||
        process.offset == null ||
        process.questions == null) {
      index = 0;
      process = ProcessModel(score: 1, offset: index, heart: 5);
    } else {
      index = process.offset - process.questions.length;
      process.copyWith(heart: 5);
    }
    final NetworkState<List<QuestionModel>> rs =
        await repository.getQuestionByIndex(index: index);
    if (rs?.data != null && rs?.data?.length != 0) {
      await AppShared.setProcess(process.copyWith(questions: rs.data));
      AppPreloadAsset.preloadImages(context: context, images: images);
      AppPreloadAsset.preloadSounds(sounds: sounds);
      Navigator.pushNamed(context, Routers.start);
    } else {
      print("Error get question!");
    }
  }
}
