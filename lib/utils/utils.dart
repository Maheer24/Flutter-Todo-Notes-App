import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../palette.dart';

class Utils {
  void toastMessage(String message, BuildContext context) {
    showToast(
      message,
      context: context,
      textStyle: const TextStyle(fontSize: 15, color: Palette.whiteColor),
      animation: StyledToastAnimation.fade,
      duration: const Duration(
        seconds: 5,
      ),
      fullWidth: true,
      toastHorizontalMargin: 25,
      backgroundColor: Palette.greyColour,
      position: StyledToastPosition.bottom,
    );
  }
}
