import 'package:flutter/material.dart';

import 'keys_modal_view_new_account_create.dart';
import 'keys_modal_view_new_account_recover.dart';
import 'package:sizer/sizer.dart';

class KeysModalViewNewAccount extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 0.5 * 3.h)),
        KeysModalViewNewAccountCreate(),
        Padding(padding: EdgeInsets.only(top: 0.5 * 2.h)),
        KeysModalViewNewAccountRecover(),
      ],
    );
  }
}