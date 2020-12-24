import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dovuihainao_flutter/src/configs/constanst/constants.dart';
import 'package:dovuihainao_flutter/src/presentation/presentation.dart';
import 'package:dovuihainao_flutter/src/resource/resource.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetApp extends StatelessWidget {
  final Apps app;

  const WidgetApp({this.app});

  download(BuildContext context) async {
    String url = Platform.isAndroid
        ? "https://play.google.com/store/apps/details?id=${app.linkdown}"
        : app.linkdownios;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show("Xảy ra lỗi khi tải ứng dụng này!", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        leading: CachedNetworkImage(
          width: 50,
          height: 50,
          imageUrl: "${app.logolink}",
          placeholder: (BuildContext context, String url) => Center(
            child: WidgetCircleProgress(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        title: Text(
          app.name,
          style: AppStyles.DEFAULT_MEDIUM_BOLD.copyWith(color: AppColors.black),
        ),
        trailing: WidgetImageButton(
          onTap: () => download(context),
          height: 40,
          width: 95,
          unpressedImage: Image.asset(AppImages.imgDown),
          pressedImage: Image.asset(AppImages.imgDownPress),
        ),
      ),
    );
  }
}
