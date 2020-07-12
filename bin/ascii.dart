import 'dart:io';
import 'package:ascii/constants.dart';
import 'package:image/image.dart';

main() {
  Image importedImage = decodeImage(File('test.jpg').readAsBytesSync());
  int finalImageWidth = 65;
  int finalImageHeight =
      ((importedImage.height * (finalImageWidth / importedImage.width)) / 2)
          .round();
  Image image = copyResize(contrast(brightness(importedImage, 135), 116),
      width: finalImageWidth, height: finalImageHeight);
  int height = image.height;
  int width = image.width;
  splitter(height, width, image);
}

splitter(height, width, image) {
  String strip = '';
  for (int i = 0; i < height; i++) {
    strip = '';
    for (int j = 0; j < width; j++) {
      int pixel = image.getPixel(j, i);
      int luminance = getLuminance(pixel);
      strip = strip + brightnessToAscii(luminance);
    }
    print(strip);
  }
}

String brightnessToAscii(int luminance) {
  Map asciiConversionMap = Constants.asciiConversionMap;
  double doubleAsciiLuminance = luminance * (asciiConversionMap.length / 255);
  int asciiLuminance = doubleAsciiLuminance.ceil().toInt();
  String asciiOut;
  asciiConversionMap.forEach((k, v) {
    if (k == asciiLuminance) {
      asciiOut = v;
    } else if (asciiLuminance == 0) {
      asciiOut = ' ';
    }
  });
  return asciiOut;
}
