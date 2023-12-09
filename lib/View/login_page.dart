import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import 'Name_page.dart';
import 'mood_select.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  TextEditingController _Emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  Future<void> Login()
  async {
    Response response =await post(Uri.parse("Login Check login api "),
    body: {"email": _Emailcontroller.text.toString(),"password":_passwordcontroller.text.toString()});
    print({"email": _Emailcontroller.text.toString(),"password":_passwordcontroller.text.toString()});
    print(response.body.toString());
    if(response.statusCode == 200 )
      {
        var data=jsonDecode(response.body);
        print("All Data"+data.toString());
        var message=data['message'];
        String id=data['id'];
        if(message== "Create New Registration")
          {
            tost("Regitration Succesfully");
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: select_name(id: id.toString(), email: _Emailcontroller.text.toString(), password: _passwordcontroller.text.toString(),)));
          }
        else if(message == "Login Successful")
          {

            SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
          sharedPreferences.setBool("isLogin", true);
          sharedPreferences.setString("user_id", id.toString());
            tost("Login Succesfully");
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: mood_select()));

          }
        else
          {
            Fluttertoast.showToast(msg: "Invalid credentials");
          }
      }
  }

  @override
  Widget build(BuildContext context) {
    final me = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/img_8.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: me.height * .1,
                ),
                Image.asset(
                  "assets/img_7.png",
                  height: me.height * .1,
                  width: me.width * .3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Chat",
                      style: TextStyle(
                          color: s_color,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "App",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                    )
                  ],
                ),
                SizedBox(
                  height: me.height * .17,
                ),
                Text(
                  "Login  your Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      color: font_color,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: me.height * .025,
                ),
                Text(
                  "Enter given login credential to access wonderness",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: font_color,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: me.height * .05,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),

                  child: TextFormField(
                    controller: _Emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter Email ',
                      hintStyle: TextStyle(fontSize: 12, color: t_color),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: me.height * .02,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),

                  child: TextFormField(
                    controller: _passwordcontroller,

                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      hintStyle: TextStyle(fontSize: 12, color: t_color),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: me.height * .06,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () {

                      if(_Emailcontroller.text.toString() != ""&&_passwordcontroller.text.toString() != "")
                        {
                          Login();
                        }
                      else
                        {
                          Fluttertoast.showToast(msg: "Please Enter All Detils");
                        }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: main_color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Container(
                      height: me.height * .06,
                      width: me.width,
                      child: Center(
                        child: Text(
                          "Let’s Get Started",
                          style: TextStyle(
                            color: main_color,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
