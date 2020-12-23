// import 'dart:async';
// import 'dart:io';
// import 'dart:math';
//
// import 'package:firebase_admob/firebase_admob.dart';
//
// /*
// iOS:
// - App id: ca-app-pub-3940256099942544~1458002511
// - Banner: ca-app-pub-3940256099942544/2934735716
// - Interstitial: ca-app-pub-3940256099942544/4411468910
// - Interstitial Video: ca-app-pub-3940256099942544/5135589807
// - Rewarded Video: ca-app-pub-3940256099942544/1712485313
// - Native Advanced: ca-app-pub-3940256099942544/3986624511
// - Native Advanced Video: ca-app-pub-3940256099942544/2521693316
// Android:
// - App id: ca-app-pub-3940256099942544~3347511713
// - Banner: ca-app-pub-3940256099942544/6300978111
// - Interstitial: ca-app-pub-3940256099942544/1033173712
// - Interstitial Video: ca-app-pub-3940256099942544/8691691433
// - Rewarded Video: ca-app-pub-3940256099942544/5224354917
// - Native Advanced: ca-app-pub-3940256099942544/2247696110
// - Native Advanced Video: ca-app-pub-3940256099942544/1044960115
//  */
//
// enum BannerAdmobStatus { hide, loading, show }
//
// enum BannerHeight { normal, padding }
//
// class BannerDataClass {
//   BannerAdmobStatus status;
//   BannerHeight height;
//
//   BannerDataClass(
//       {this.status = BannerAdmobStatus.hide,
//       this.height = BannerHeight.normal});
// }
//
// class AppAdmob {
//   AppAdmob._();
//
//   static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//     keywords: <String>['english challenge', 'solar', 'english'],
//     childDirected: true,
//     nonPersonalizedAds: true,
//   );
//
//   static String appID() {
//     return Platform.isAndroid
//         ? "ca-app-pub-3940256099942544~3347511713"
//         : "ca-app-pub-3940256099942544~1458002511";
//   }
//
//   static String bannerID() {
//     return Platform.isAndroid
//         ? "ca-app-pub-3940256099942544/6300978111"
//         : "ca-app-pub-3940256099942544/2934735716";
//   }
//
//   static String interstitialID() {
//     return Platform.isAndroid
//         ? "ca-app-pub-3940256099942544/1033173712"
//         : "ca-app-pub-3940256099942544/4411468910";
//   }
//
//   static String interstitialVideoID() {
//     return Platform.isAndroid
//         ? "ca-app-pub-3940256099942544/8691691433"
//         : "ca-app-pub-3940256099942544/5135589807";
//   }
//
//   static String rewardedVideoID() {
//     return Platform.isAndroid
//         ? "ca-app-pub-3940256099942544/5224354917"
//         : "ca-app-pub-3940256099942544/1712485313";
//   }
//
//   static String nativeAdvancedID() {
//     return Platform.isAndroid
//         ? "ca-app-pub-3940256099942544/2247696110"
//         : "ca-app-pub-3940256099942544/3986624511";
//   }
//
//   static String nativeAdvancedVideoID() {
//     return Platform.isAndroid
//         ? "ca-app-pub-3940256099942544/1044960115"
//         : "ca-app-pub-3940256099942544/2521693316";
//   }
//
//   static InterstitialAd interstitial;
//   static bool interstitialIsDispose = false;
//   static Timer _timer;
//   static int seconds = 0;
//   static int secondsForInterstitial = 180;
//
//   static Future<void> initialized() async {
//     await FirebaseAdMob.instance.initialize(appId: appID());
//     return await loadInterstitialAd();
//   }
//
//   static Future loadInterstitialAd() async {
//     final bool status = Random.secure().nextBool();
//     interstitial = _buildInterstitialAd(status);
//     return await interstitial.load();
//   }
//
//   static Future<bool> showInterstitial({bool skip = false}) async {
//     if (_timer == null) {
//       seconds = 0;
//       _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//         seconds += 1;
//         if (seconds > secondsForInterstitial) {
//           _timer.cancel();
//           _timer = null;
//         }
//       });
//     } else if (seconds < secondsForInterstitial) {
//       return false;
//     }
//
//     try {
//       final loaded = await interstitial.isLoaded();
//       if (loaded) {
//         return await interstitial.show();
//       } else if (skip)
//         return false;
//       else {
//         await interstitial.load();
//         return await showInterstitial(skip: true);
//       }
//     } catch (e) {
//       return false;
//     }
//   }
//
//   static InterstitialAd _buildInterstitialAd(bool isBanner) {
//     return InterstitialAd(
//       adUnitId: isBanner ? interstitialID() : interstitialVideoID(),
//       listener: (MobileAdEvent event) {
//         try {
//           if (event == MobileAdEvent.failedToLoad) {
//             interstitial..load();
//           } else if (event == MobileAdEvent.closed) {
//             final bool status = Random.secure().nextBool();
//             interstitial = _buildInterstitialAd(status)..load();
//           }
//         } catch (e) {}
//       },
//     );
//   }
// }
