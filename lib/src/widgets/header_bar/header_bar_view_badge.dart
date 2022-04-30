/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:tiki_style/tiki_style.dart';

class HeaderBarViewBadge extends StatelessWidget {
  static const _width = 31;

  final String label;

  const HeaderBarViewBadge(this.label, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.center, children: [
      SizedBox(
        width: SizeProvider.instance.width(100),
        child: FittedBox(
          child: ImgProvider.badgeHeader,
          fit: BoxFit.fitWidth,
        )
      ),
      SizedBox(
          width: SizeProvider.instance.width(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                label,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontFamily: TextProvider.familyNunitoSans,
                    fontWeight: FontWeight.w800,
                    color: ColorProvider.white,
                    fontSize: SizeProvider.instance.text(9.1)),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeProvider.instance.size(9)),
                  child: Icon(IconProvider.star, size: SizeProvider.instance.size(80)
                  )),
            ],
          ))
    ]);
  }
}
