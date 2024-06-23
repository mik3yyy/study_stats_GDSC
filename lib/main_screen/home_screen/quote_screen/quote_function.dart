import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:study_stats/global_comonents/custom_messageHandler.dart';

class QuoteFunction {
  static const MethodChannel _channel = MethodChannel('image_gallery_saver');

  static FutureOr<dynamic> saveImage(Uint8List imageBytes,
      {int quality = 80,
      String? name,
      bool isReturnImagePathOfIOS = false,
      required BuildContext context}) async {
    final result =
        await _channel.invokeMethod('saveImageToGallery', <String, dynamic>{
      'imageBytes': imageBytes,
      'quality': quality,
      'name': name,
      'isReturnImagePathOfIOS': isReturnImagePathOfIOS
    });

    if (result["isSuccess"]) {
      MyMessageHandler.showSnackBar(context, "Image Saved Successfully",
          sucess: true);
      Future.delayed(Duration(milliseconds: 500), () {
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //     CustomerMain.id, (Route<dynamic> route) => false);
      });
    } else {
      MyMessageHandler.showSnackBar(context, "Unsuccessful");
    }
    return result;
  }

  // static Future<void> saveAndShare(
  //     Uint8List imageBytes, BuildContext context) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   // final image = XFile("${directory.path}/order_${orderProvider.id}.png");
  // // Image _image= Image.memory( imageBytes);
  // //   XFile file = XFile(_image.image)
  //   await Share.shareFiles([],'ESYS AMLOG', 'amlog.jpg', ubytes, 'image/jpg');

  //   // image.writeAsBytes(imageBytes);
  //   await Share.shareXFiles([file], text: "Quote");
  // }
  static Future<void> shareScreenShort(String title,
      {required GlobalKey previewContainer,
      int originalSize = 1600,
      required BuildContext context}) async {
    try {
      RenderRepaintBoundary boundary = previewContainer.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      double pixelRatio = originalSize /
          MediaQuery.of(previewContainer.currentContext!).size.width;
      ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final filePathAndName = await getApplicationDocumentsDirectory();
      print(filePathAndName.path);
      var randomNumber = Random();
      String path =
          join(filePathAndName.path, "${randomNumber.nextInt(100)}_Qoutes.png");

      File imgFile = File(path);
      await imgFile.writeAsBytes(pngBytes);
      await Share.shareXFiles(
        [XFile(imgFile.path)],
        sharePositionOrigin:
            boundary.localToGlobal(Offset.zero) & boundary.size,
      );
    } catch (ex) {
      MyMessageHandler.showSnackBar(context, ex.toString());
      print(ex.toString());
    }
  }
}
