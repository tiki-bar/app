/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/constants/constants_colors.dart';
import 'package:app/src/constants/constants_strings.dart';
import 'package:app/src/screens/screen_home.dart';
import 'package:app/src/screens/screen_intro_abstract.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class ScreenIntroTogether extends ScreenIntroAbstract {
  static final String _titleText = ConstantsStrings.INTRO_3_TITLE;
  static final String _subtitleText = ConstantsStrings.INTRO_3_SUBTITLE;
  static final String _buttonText = ConstantsStrings.INTRO_3_BUTTON_TEXT;
  static final int _dotFilled = 3;
  static final int _dotTotal = 3;
  static final Widget _nextScreen = ScreenHome();
  static final Color _backgroundColor = ConstantsColors.MACARONI_AND_CHEESE;

  ScreenIntroTogether()
      : super(_titleText, _subtitleText, _buttonText, _dotFilled, _dotTotal);

  @override
  Widget stack(BuildContext context) {
    return GestureDetector(
      child: Stack(children: [
        Center(child: Container(color: _backgroundColor)),
        Align(
            alignment: Alignment.bottomLeft,
            child: Image(image: AssetImage('res/images/intro-blob.png'))),
        Align(
            alignment: Alignment.bottomRight,
            child:
                Image(image: AssetImage('res/images/intro-pineapple-90.png'))),
        Row(children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.only(
                      left: ScreenIntroAbstract.lrPadding,
                      right: ScreenIntroAbstract.lrPadding),
                  child: Column(children: [
                    title(),
                    subtitle(),
                    dots(),
                    button(context)
                  ])))
        ])
      ]),
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) Navigator.pop(context);
      },
    );
  }

  @override
  void buttonPressed(BuildContext context) {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => _nextScreen,
            transitionDuration: Duration(seconds: 0)));
  }
}
