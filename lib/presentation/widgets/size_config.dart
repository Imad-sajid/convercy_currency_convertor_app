import 'package:flutter/widgets.dart';

class SizeConfig {
  late double screenWidth;
  late double screenHeight;
  late double blockSizeHorizontal;
  late double blockSizeVertical;

  late double textMultiplier;
  late double imageSizeMultiplier;
  late double heightMultiplier;
  late double widthMultiplier;

  init(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    textMultiplier = blockSizeVertical;
    imageSizeMultiplier = blockSizeHorizontal;
    heightMultiplier = blockSizeVertical;
    widthMultiplier = blockSizeHorizontal;
  }
}
