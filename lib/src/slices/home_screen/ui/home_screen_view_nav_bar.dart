/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_screen_service.dart';
import 'home_screen_view_nav_bar_item.dart';

class HomeScreenViewNavBar extends StatelessWidget {
  static const double _fontSize = 12;
  static const double _radius = 50;

  const HomeScreenViewNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeScreenService service = Provider.of<HomeScreenService>(context);
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(_radius)),
          boxShadow: [
            BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(4.0, 4.0),
                blurRadius: 20),
          ],
        ),
        child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(_radius)),
            child: BottomNavigationBar(
              currentIndex: service.model.currentScreenIndex,
              onTap: (index) => service.controller.onNavTap(index),
              items: [
                HomeScreenViewNavBarItem("Data", "eye-icon"),
                HomeScreenViewNavBarItem("Choices", "choices-icon"),
                HomeScreenViewNavBarItem("Money", "money-icon")
              ],
              backgroundColor: ColorProvider.white,
              unselectedItemColor: ColorProvider.blue,
              unselectedLabelStyle: TextStyle(
                  fontFamily: TextProvider.familyNunitoSans, package: 'tiki_style',
                  fontWeight: FontWeight.w800,
                  fontSize: _fontSize.sp),
              selectedItemColor: ColorProvider.orange,
              selectedLabelStyle: TextStyle(
                  fontFamily: TextProvider.familyNunitoSans, package: 'tiki_style',
                  fontWeight: FontWeight.w800,
                  fontSize: _fontSize.sp),
            )));
  }
}
