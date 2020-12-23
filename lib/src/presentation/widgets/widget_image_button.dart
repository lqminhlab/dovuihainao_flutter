import 'package:flutter/material.dart';

class WidgetImageButton extends StatefulWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Image unpressedImage;
  final Image pressedImage;
  final double paddingTop;
  final double width;
  final double height;
  final onTap;
  final Widget label;

  const WidgetImageButton(
      {Key key,
      this.children,
      @required this.unpressedImage,
      @required this.pressedImage,
      this.label,
      this.onTap,
      this.width,
      this.height,
      this.paddingTop = 5,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.crossAxisAlignment = CrossAxisAlignment.center})
      : super(key: key);

  @override
  _WidgetImageButtonState createState() => _WidgetImageButtonState();
}

class _WidgetImageButtonState extends State<WidgetImageButton> {
  double paddingTop;
  ImageProvider imagePressed;
  ImageProvider imageUnPressed;
  Image currentImage;
  bool preloaded = false;

  @override
  void initState() {
    super.initState();
    imagePressed = widget.pressedImage.image;
    imageUnPressed = widget.pressedImage.image;
    currentImage = widget.unpressedImage;
    paddingTop = 0.0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(imagePressed, context);
    precacheImage(imageUnPressed, context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? _doNothing,
      onTapCancel: () {
        setState(() {
          currentImage = widget.unpressedImage;
          paddingTop = 0.0;
        });
      },
      onTapDown: (TapDownDetails details) {
        setState(() {
          currentImage = widget.pressedImage;
          paddingTop = widget.paddingTop ?? 0.0;
        });
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          currentImage = widget.unpressedImage;
          paddingTop = 0.0;
        });
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
                Container(
                  height: widget.height,
                  width: widget.width,
                  padding: EdgeInsets.only(top: paddingTop),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          alignment: Alignment(0, 0),
                          image: currentImage.image)),
                  child: widget.children == null
                      ? const SizedBox()
                      : Row(
                          mainAxisAlignment: widget.mainAxisAlignment,
                          crossAxisAlignment: widget.crossAxisAlignment,
                          children: widget.children,
                        ),
                )
              ] +
              [widget.label ?? SizedBox()]),
    );
  }

  _doNothing() {}
}
