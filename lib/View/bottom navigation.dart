import 'dart:io';

import 'package:Chat_app/View/update_mood.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:Chat_app/Controller/profile_data.dart';
import 'package:Chat_app/View/update_mood.dart';
import 'chat/add_chat.dart';
import 'chat/chat_home.dart';
import '../constant.dart';
import 'chat/close_friend.dart';
import 'mood_select.dart';


class bottom_navigation extends StatefulWidget {
  const bottom_navigation({super.key});

  @override
  State<bottom_navigation> createState() => _bottom_navigationState();
}

class _bottom_navigationState extends State<bottom_navigation> {
  Directory directory = Directory('/path/to/directory');
  List<Widget> _pages() {
    return [
      chat_home(),
      close_frd(),
      add_chat(),
      mood_select1()


    ];
  }
  profile controller=Get.put(profile());


  List<PersistentBottomNavBarItem> _navBarItem() {
    return [

      PersistentBottomNavBarItem(
        title: "Cares",
        activeColorPrimary: main_color,
        inactiveColorPrimary: Colors.white,
        icon: Image.asset("assets/img_3.png"),
        inactiveIcon: Image.asset("assets/img_4.png"),
      ),
      PersistentBottomNavBarItem(
          icon: Image.asset("assets/img_1.png"),
          title: "Circle",
          activeColorPrimary: main_color,
          inactiveColorPrimary: Colors.white,
          inactiveIcon: Image.asset("assets/img_2.png")
      ),
      PersistentBottomNavBarItem(
        title: "Add",
        activeColorPrimary: main_color,
        inactiveColorPrimary: Colors.white,
        icon: Icon(
          Icons.add,
          color: main_color,
        ),
        inactiveIcon: Icon(
          Icons.add,
          color: dis,
        ),
      ),
      PersistentBottomNavBarItem(
        title: "Status",
        activeColorPrimary: main_color,
        inactiveColorPrimary: Colors.white,
        icon: Image.asset("assets/img_6.png"),
        inactiveIcon:Image.asset("assets/img_5.png"),
      ),
    ];
  }

  int i=0;
  @override
  void initState() {
    controller.GetData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        onWillPop: () async {
          setState(() {
            i++;
          });debugPrint("object");
          if (i == 2) {
            SystemNavigator.pop();
            return true;
          }
          return false;
        },
        child:Scaffold(
          body: Container(),
          bottomNavigationBar: PersistentTabView(
            context,
            controller: PersistentTabController(initialIndex: 1),
            screens: _pages(),
            items: _navBarItem(),
            decoration:
            NavBarDecoration(borderRadius: BorderRadius.circular(1)),
            navBarStyle: NavBarStyle.style3,
          ),
        )

    );
  }
}
