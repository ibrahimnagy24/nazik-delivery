import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_base/core/app_core.dart';
import 'package:flutter_base/core/app_notification.dart';

import 'styles.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    if (newValue.text.length <= 2) {
      double value = double.parse(newValue.text);

      final formatter = NumberFormat.currency(
        locale: 'en',
        decimalDigits: 0,
      );

      String newText = formatter.format(value);

      return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    } else {
      AppCore.showSnackBar(
        notification: AppNotification(
          message: "Maximum text 2 characters exceeded",
          backgroundColor: Styles.IN_ACTIVE,
          borderColor: Styles.DARK_RED,
          iconName: "fill-close-circle",
        ),
      );
      return newValue.copyWith(text: oldValue.text);
    }
  }
}

class DaysInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    if (int.parse(newValue.text) <= 30) {
      return newValue.copyWith(text: newValue.text);
    } else {
      return newValue.copyWith(text: oldValue.text);
    }
  }
}

class PercentageInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    if (int.parse(newValue.text) <= 100) {
      return newValue.copyWith(text: newValue.text);
    } else {
      return newValue.copyWith(text: oldValue.text);
    }
  }
}
