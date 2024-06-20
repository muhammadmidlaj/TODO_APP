import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:todo/core/utils/toast_components.dart';

extension IntExtention on int {
  SizedBox get hs {
    return SizedBox(
      height: toDouble(),
    );
  }

  SizedBox get ws {
    return SizedBox(
      width: toDouble(),
    );
  }
}

extension StringExtention on String {
  String capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  showMessage(ToastType type) {
    return showToastWidget(
      ToastBar(message: this, toastType: type),
      position: ToastPosition.bottom,
      dismissOtherToast: true,
    );
  }
}

extension BuildContextExtentions on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get screenSize => mediaQuery.size;

  
}