import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Chat_app/View/bottom%20navigation.dart';

import '../constant.dart';
import 'login_page.dart';


class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {

  Future<void> checkCondition()
  async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isLogin = sharedPreferences.getBool("isLogin");
    if(isLogin != null)
      {
        Navigator.of(context, rootNavigator: true)
            .push(MaterialPageRoute(builder: (context) => bottom_navigation()));
      }
    else
      {
        Navigator.of(context, rootNavigator: true)
            .push(MaterialPageRoute(builder: (context) => login_page()));
      }

  }
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () => checkCondition());
  }
  @override
  Widget build(BuildContext context) {
    final me =MediaQuery.of(context).size;
    return  Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/img.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/img_7.png",height: me.height * .1,width: me.width * .3,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Take",style: TextStyle(color: s_color,fontSize: 50,fontWeight: FontWeight.bold),),
                    Text("Care",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50),)
                  ],
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}

