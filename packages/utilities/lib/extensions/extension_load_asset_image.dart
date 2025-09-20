import 'package:flutter/cupertino.dart';

/*
Author: Nagaraju.lj
Date: April, 2024.
Description: Extension on String to load asset images.
The string refers to the name of the asset image.
TODO: Check the existence of asset name, if not available, load default image.
*/

extension LoadAssetImage on String {
  Image loadAsset({
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gapLessPlayback = false,
    bool isAntiAlias = false,
    String? package = 'utilities',
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image.asset(
      this,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gapLessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
    );
  }
}

extension LoadImageProviderAsset on String {
  AssetImage loadImageProviderAsset() {
    return AssetImage(this, package: 'utilities');
  }
}
