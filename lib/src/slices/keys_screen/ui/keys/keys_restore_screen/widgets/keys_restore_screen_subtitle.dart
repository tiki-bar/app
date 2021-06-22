/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/widgets.dart';

class KeysRestoreScreenSubtitle extends StatelessWidget {
  static const String _text =
      "Upload, scan, or manually enter your TIKI account keys";
  static final double _fontSize = 5.w;

  @override
  Widget build(BuildContext context) {
    return Text(_text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: _fontSize,
            fontWeight: FontWeight.w600,
            color: ConfigColor.emperor));
  }
}
