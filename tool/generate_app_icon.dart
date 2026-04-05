// Generate assets/branding/app_icon.png for flutter_launcher_icons.
// Run from repo root: dart run tool/generate_app_icon.dart
import 'dart:io';

import 'package:image/image.dart' as img;

void main() {
  const size = 1024;
  var image = img.Image(width: size, height: size);
  image = img.fill(image, color: img.ColorRgb8(230, 74, 25));

  final inset = 160;
  image = img.fillRect(
    image,
    x1: inset,
    y1: inset + 100,
    x2: size - inset,
    y2: size - inset - 100,
    color: img.ColorRgb8(255, 255, 255),
  );
  image = img.fillRect(
    image,
    x1: inset + 48,
    y1: inset + 160,
    x2: size - inset - 48,
    y2: size - inset - 160,
    color: img.ColorRgb8(230, 74, 25),
  );

  final dir = Directory('assets/branding');
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }
  final out = File('assets/branding/app_icon.png');
  out.writeAsBytesSync(img.encodePng(image));
  // ignore: avoid_print
  print('Wrote ${out.path}');
}
