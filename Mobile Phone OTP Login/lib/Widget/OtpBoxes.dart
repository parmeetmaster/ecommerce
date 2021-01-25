


import 'package:flutter/material.dart';
import 'package:flutter_app_zomato_signin/Providers/OtpScreenProvider.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpBoxWidgets extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final otpscreenProvider= Provider.of<OtpScreenProvider>(context);

    return PinFieldAutoFill(
      codeLength: 6,
      autofocus: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      onCodeChanged:otpscreenProvider.onCodeChange,
      onCodeSubmitted:otpscreenProvider.onCodeSubmitted,
      focusNode: FocusNode(skipTraversal: false),

      decoration: BoxLooseDecoration(
        strokeColorBuilder:
        PinListenColorBuilder(Colors.grey[300], Colors.grey[900]),
      ),
    );
  }
}
