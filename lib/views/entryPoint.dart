import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:top_care/controllers/tab_index_controller.dart';
import 'package:top_care/views/cart_view.dart';
import 'package:top_care/views/home.dart';
import 'package:top_care/views/profile_view.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> pageList = const [HomeView(), CartView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TabIndexController());
    PersistentTabController _controller =
        PersistentTabController(initialIndex: controller.tabIndex);
    return Obx(
      () => SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Column(
              children: [
                pageList[controller.tabIndex],
              ],
            ),
            bottomNavigationBar: PersistentTabView(
              context,
              controller: _controller,
              screens: pageList,
              items: _navBarsItems(),
              backgroundColor: Colors.white,
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: true,
              hideNavigationBarWhenKeyboardShows: true,
              decoration: NavBarDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset(1, 1),
                      blurRadius: 5,
                      spreadRadius: 7),
                ],
                borderRadius: BorderRadius.circular(10.0),
                colorBehindNavBar: Colors.white,
              ),
              popAllScreensOnTapOfSelectedTab: true,
              popActionScreens: PopActionScreensType.all,
              itemAnimationProperties: ItemAnimationProperties(
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: ScreenTransitionAnimation(
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 200),
              ),
              navBarStyle: NavBarStyle.style1,
            )),
      ),
    );
  }
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.home),
      title: ("Home"),
      activeColorPrimary: Colors.teal,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.cart),
      title: ("Cart"),
      activeColorPrimary: Colors.teal,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: ("Profile"),
      activeColorPrimary: Colors.teal,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
