import 'package:dovuihainao_flutter/src/configs/configs.dart';
import 'package:dovuihainao_flutter/src/presentation/presentation.dart';
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
    final NetworkState<List<QuestionModel>> rs =
        await repository.getQuestionByIndex();
    final otherApp = rs.data;
    print("Questions: ${otherApp ?? "Null!"}");
    AppPreloadAsset.preloadImages(context: context, images: images);
    AppPreloadAsset.preloadSounds(sounds: sounds);
    Navigator.pushNamed(context, Routers.start);
  }
}