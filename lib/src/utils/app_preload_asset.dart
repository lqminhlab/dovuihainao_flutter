import 'package:audioplayers/audio_cache.dart';
import 'package:dovuihainao_flutter/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';

class AppPreloadAsset {
  AppPreloadAsset._();

  static AudioCache _audioCache = AudioCache(prefix: "assets/sound/");

  static Future preloadImages(
      {List<String> images,
      @required BuildContext context,
      Duration duration}) async {
    images.forEach((element) {
      precacheImage(new AssetImage(element), context);
    });
    await Future.delayed(duration ?? Duration(seconds: 1));
    return;
  }

  static Future preloadSounds({List<String> sounds, Duration duration}) async {
    AppSound.setPlayer(_audioCache);
    await _audioCache.loadAll(sounds);
    await Future.delayed(duration ?? Duration(milliseconds: 350));
    return;
  }
}
