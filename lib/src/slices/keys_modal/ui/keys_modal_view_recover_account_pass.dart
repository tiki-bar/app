import '../keys_modal_service.dart';
import 'package:provider/provider.dart';

import '../../../config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class KeysModalViewRecoverAccountPass extends StatelessWidget {
  final String _text = "I have a pin code and passphrase";

  @override
  Widget build(BuildContext context) {
    KeysModalService service = Provider.of<KeysModalService>(context);
    return TextButton(
      style: TextButton.styleFrom(
          fixedSize: Size.fromWidth(80.w),
          padding: EdgeInsets.symmetric(vertical: 2.h),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3.w))),
          side: BorderSide(width: 2, color: ConfigColor.tikiPurple)),
      child: Text(_text,
          style: TextStyle(
              color: ConfigColor.tikiPurple,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold)),
      onPressed: () => service.controller.goToRecoverAccount(),
    );
  }
}



