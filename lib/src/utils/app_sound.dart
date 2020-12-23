import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

enum StopSoundType {
  flash, loop, all
}

class AppSound {
  AppSound._();

  static AudioCache _audioCache;
  static AudioPlayer _playerLoop;
  static AudioPlayer _playerFlash;

  static setPlayer(AudioCache audioCache) {
    _audioCache = audioCache;
  }

  static Future<bool> play(String sound, {double volume = 1.0}) async {
    _playerFlash = await _audioCache.play(sound,
        mode: PlayerMode.LOW_LATENCY, isNotification: false, volume: volume);
    return _playerFlash != null;
  }

  static Future<bool> playLoopBackground(String sound,
      {double volume = 1.0, PlayerMode mode = PlayerMode.LOW_LATENCY}) async {
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
    switch(type){
      case StopSoundType.loop:
        return await _playerFlash.stop();
        break;
      case StopSoundType.loop:
        return await _playerLoop.stop();
        break;
      default:
        await _playerFlash.stop();
        return await _playerLoop.stop();
        break;
    }
  }
}
