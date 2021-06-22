/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/login/login_otp/login_otp_req/bloc/login_otp_req_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginInboxScreenSentTo extends StatelessWidget {
  static const String _text = "I sent an email with a link to";
  static final double _fontSize = 5.w;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginOtpReqBloc, LoginOtpReqState>(
        builder: (BuildContext context, LoginOtpReqState state) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(_text,
            style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w600)),
        Text(state.email == null ? "" : state.email!,
            style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.bold))
      ]);
    });
  }
}
