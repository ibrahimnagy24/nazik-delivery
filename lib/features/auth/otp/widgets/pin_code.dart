import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/validator.dart';
import '../../../../helpers/styles.dart';
import '../bloc/otp_bloc.dart';

class PinCodeWidget extends StatelessWidget {
  const PinCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12),
        fieldHeight: 45.h,
        fieldWidth: 45.h,
        activeBorderWidth: 1,
        borderWidth: 1,
        disabledBorderWidth: 1,
        errorBorderColor: Styles.IN_ACTIVE,
        errorBorderWidth: 1,
        inactiveBorderWidth: 1,
        selectedBorderWidth: 1,
        inactiveFillColor: context.theme.primaryColorLight,
        activeFillColor: Colors.white,
        activeColor: context.theme.primaryColor,
        selectedFillColor: context.theme.primaryColor,
        selectedColor: context.theme.primaryColor,
        inactiveColor: Styles.BORDER_COLOR,
      ),
      animationDuration: const Duration(milliseconds: 300),
      textStyle: const TextStyle(fontSize: 20),
      controller: context.read<OtpBloc>().codeTEC,
      keyboardType: TextInputType.phone,
      appContext: context,
      length: 6,
      validator: OTPValidator.otpValidator,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}
