import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/safe_area_values.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../settings/constants.dart';

class MyMessageHandler {
  static void showSnackBar(BuildContext context, String message,
      {sucess = false}) {
    showTopSnackBar(
      Overlay.of(context),
      sucess
          ? CustomSnackBar.success(
              message: message,
            )
          : CustomSnackBar.error(
              message: message,
            ),
    );
  }
}
