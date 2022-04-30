/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_screen_service.dart';
import '../model/home_screen_model.dart';
import 'home_screen_decision_container.dart';
import 'home_screen_money_container.dart';
import 'home_screen_view_nav_bar.dart';
import 'home_screen_view_overlay.dart';

class HomeScreenViewStack extends StatelessWidget {
  final DataScreenService dataScreenService;

  const HomeScreenViewStack(
      {Key? key, required this.dataScreenService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeScreenModel model = Provider.of<HomeScreenService>(context).model;
    return Stack(children: [
      Scaffold(
          backgroundColor: ColorProvider.greyOne,
          bottomNavigationBar: const HomeScreenViewNavBar(),
          body: SafeArea(
              top: false,
              child: IndexedStack(index: model.currentScreenIndex, children: [
                dataScreenService.presenter.render(),
                const HomeScreenDecisionContainer(),
                const HomeScreenMoneyContainer(),
              ]))),
      if (model.showOverlay == true && model.currentScreenIndex == 1)
        const HomeScreenViewOverlay()
    ]);
  }
}
