import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';
import 'mood_select.dart';


class select_name extends StatefulWidget {
  const select_name({super.key,required this.id,required this.email,required this.password});
  final String? id;
  final String? email;
  final String? password;

  @override
  State<select_name> createState() => _select_nameState();
}

class _select_nameState extends State<select_name> {

  TextEditingController _namecontroller=TextEditingController();
Future<void> fun()
async {

  Response response =await post(Uri.parse("Update firebase token api"),
      body: {"id":widget.id.toString(),"f_id":FirebaseAuth.instance.currentUser!.uid.toString()});
  if(response.statusCode == 200)
  {
    var data=jsonDecode(response.body);
    String? message=data['message'];
    if(message == "Updated successfully")
    {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      sharedPreferences.setBool("isLogin", true);
      sharedPreferences.setString("user_id", widget.id.toString());
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              child: mood_select()));
 }
    else
    {
      tost("Pease try Agin");
    }

  }
  else
  {
  tost("Server Error");
  }
}
  void firebase()
  {
      FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email:  widget.email.toString(), password: widget.password.toString())
        .then((value) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "name": _namecontroller.text.toString(),
        "email":  widget.email.toString(),
        "status": "Unavalible",
        "w_id": widget.id.toString(),
        "uid": FirebaseAuth.instance.currentUser!.uid.toString(),

      }).then((value) {
        fun();
        print("lkSZJgbl");
      });
    }).catchError((e) {
      print("scjgfbskj");
    });



  }
  Future<void> Name()
  async {
    Response response =await post(Uri.parse("update name api"),
        body: {"id":widget.id.toString(),"name":_namecontroller.text.toString()});

    if(response.statusCode == 200 )
    {
      var data=jsonDecode(response.body);
      print("All Data"+data.toString());
      var message=data['message'];
      if(message== "Updated successfully")
      {
        firebase();
      }
      else if(message == "This Name Is Already Exist")
      {
        tost("Please Entre Unique Name");
      }
      else
        {
          tost("Please try agin");
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
                      "Take",
                      style: TextStyle(
                          color: s_color,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Care",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                    )
                  ],
                ),
                SizedBox(
                  height: me.height * .2,
                ),
                Text(
                  "Create a Unique \nUser Name",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      color: font_color,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: me.height * .025,
                ),
                Text(
                  "make it creative ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: font_color,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: me.height * .05,
                ),

                SizedBox(
                  height: me.height * .04,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),

                  child: TextFormField(
                    controller: _namecontroller,
                      decoration: InputDecoration(
                      hintText: 'Write User name',
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
                      Name();
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




