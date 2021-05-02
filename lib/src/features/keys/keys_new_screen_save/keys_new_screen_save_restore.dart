/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_navigate.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeysNewScreenSaveRestore extends StatelessWidget {
  static const String _text = "Already have an account?";
  static final double _fontSize = 5 * PlatformRelativeSize.blockHorizontal;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(ConfigNavigate.path.keysRestore);
        },
        child: Text(_text,
            style: TextStyle(
                color: ConfigColor.orange,
                fontWeight: FontWeight.bold,
                fontSize: _fontSize)));
  }
}
