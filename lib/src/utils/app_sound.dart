import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dovuihainao_flutter/src/resource/model/model.dart';
import 'package:dovuihainao_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';

enum StopSoundType { flash, loop, all }

class AppSound {
  AppSound._();

  static AudioCache _audioCache;
  static AudioPlayer _playerLoop;
  static AudioPlayer _playerFlash;

  static setPlayer(AudioCache audioCache) {
    _audioCache = audioCache;
  }

  static Future<bool> play(String sound, {double volume = 1.0}) async {
    ProcessModel process = await AppShared.getProcess();
    if (process?.sound ?? true) {
      _playerFlash = await _audioCache.play(sound,
          mode: PlayerMode.LOW_LATENCY, isNotification: false, volume: volume);
      return _playerFlash != null;
    } else
      return false;
  }

  static Future<bool> playLoopBackground(String sound,
      {double volume = 1.0, PlayerMode mode = PlayerMode.MEDIA_PLAYER}) async {
    _playerLoop = await _audioCache.loop(sound, volume: volume, mode: mode);
    return _playerLoop != null;
  }

  static Future<int> pauseLoopBackground() async {
    return await _playerLoop.pause();
  }

  static Future<int> resumeLoopBackground() async {
    return await _playerLoop.resume();
  }

  static Future<int> stopSound({@required StopSoundType type}) async {
    switch (type) {
      case StopSoundType.flash:
        return await _playerFlash?.stop() ?? 0;
        break;
      case StopSoundType.loop:
        return await _playerLoop?.stop() ?? 0;
        break;
      default:
        await _playerFlash?.stop();
        return await _playerLoop?.stop() ?? 0;
        break;
    }
  }
}
