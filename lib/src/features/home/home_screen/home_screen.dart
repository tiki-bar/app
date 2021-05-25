/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/home/home_counter/bloc/home_counter_cubit.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_counter.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_refer.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_share.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_title.dart';
import 'package:app/src/features/home/home_screen/widgets/tiki_community_card.dart';
import 'package:app/src/features/home/home_screen/widgets/tiki_follow_us_card.dart';
import 'package:app/src/features/home/home_screen/widgets/tiki_news_card.dart';
import 'package:app/src/features/home/home_screen/widgets/tiki_release_card.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/screens/tiki_background.dart';
import 'package:app/src/widgets/screens/tiki_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/home_screen_logout.dart';

class HomeScreen extends StatelessWidget {
  static final double _marginTopTitle = 6 * PlatformRelativeSize.blockVertical;
  static final double _marginTopCount = 4 * PlatformRelativeSize.blockVertical;
  static final double _marginTopRefer = 8 * PlatformRelativeSize.blockVertical;
  static final double _marginVerticalShare =
      6 * PlatformRelativeSize.blockVertical;
  static final double _marginTopCards = 2 * PlatformRelativeSize.blockVertical;
  static final double _marginVerticalLogOut =
      4 * PlatformRelativeSize.blockVertical;

  Widget _background() {
    return TikiBackground(
      backgroundColor: ConfigColor.serenade,
      topRight: HelperImage("home-blob-tr"),
      bottomRight: HelperImage("home-pineapple"),
    );
  }

  List<Widget> _foreground(BuildContext context) {
    return [
      Container(
          margin: EdgeInsets.only(top: _marginTopTitle),
          alignment: Alignment.center,
          child: HomeScreenTitle()),
      Container(
          margin: EdgeInsets.only(top: _marginTopCount),
          child: BlocProvider(
            create: (BuildContext context) => HomeCounterCubit.provide(context),
            child: HomeScreenCounter(),
          )),
      Container(
          margin: EdgeInsets.only(top: _marginTopRefer),
          child: HomeScreenRefer()),
      Container(
          margin: EdgeInsets.symmetric(vertical: _marginVerticalShare),
          alignment: Alignment.topCenter,
          child: HomeScreenShare()),
      Container(
        margin: EdgeInsets.only(top: _marginTopCards),
        alignment: Alignment.topCenter,
        child: TikiNextReleaseCard(),
      ),
      Container(
          margin: EdgeInsets.only(top: _marginTopCards),
          alignment: Alignment.topCenter,
          child: TikiNewsCard()),
      Container(
          margin: EdgeInsets.only(top: _marginTopCards),
          alignment: Alignment.topCenter,
          child: TikiCommunityCard()),
      Container(
          margin: EdgeInsets.only(top: _marginTopCards),
          alignment: Alignment.topCenter,
          child: TikiFollowUsCard()),
      Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.symmetric(vertical: _marginVerticalLogOut),
          child: HomeScreenLogout()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return TikiScaffold(
        foregroundChildren: _foreground(context),
        background: _background() as TikiBackground?);
  }
}
