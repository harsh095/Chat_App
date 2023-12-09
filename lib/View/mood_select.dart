import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Chat_app/Controller/profile_data.dart';
import 'package:Chat_app/View/bottom%20navigation.dart';

import '../constant.dart';


class mood_select extends StatefulWidget {
  const mood_select({super.key});

  @override
  State<mood_select> createState() => _mood_selectState();
}

class _mood_selectState extends State<mood_select> {

  String? id;
  String? mood;
  Future<void> GetData()

  async {
    SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    id=sharedPreferences.getString("user_id");
    setState(() {});
  }
  profile controller=Get.put(profile());
  @override
  void initState() {
   GetData();
   print("User_id"+id.toString());
   mood="1";



    super.initState();
  }
  Future<void> update()
  async {
    var response=await post(Uri.parse("Update status api"),
        body: {'id':id.toString(),'mood': mood.toString()});
    if(response.statusCode == 200)
      {
        var data=jsonDecode(response.body);
        String? message=data['message'];
        if(message == "Updated successfully")
          {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: bottom_navigation()));

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
  @override
  Widget build(BuildContext context) {
    final me =MediaQuery.of(context).size;
    return  Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/img_8.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),

            child: Column(
              children: [
                SizedBox(height:  me.height *.1,),
                Text("Hi Milona, Welcome to TakeCare",textAlign :TextAlign.center,style: TextStyle(fontSize:  30,color: font_color,fontStyle: FontStyle.italic),),
                SizedBox(height:  me.height *.025,),
                Text("Explore the app, Find some peace of mind to chat with others",textAlign :TextAlign.center,style: TextStyle(fontSize:  16,color: font_color,fontStyle: FontStyle.italic),),
                SizedBox(height:  me.height *.07,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: me.height * .2,
                         
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 7),
                            decoration: BoxDecoration(
                              color: mood=="1"?Colors.white.withOpacity(.5):Colors.transparent,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: InkWell(
                              onTap: (){

                               setState(() {
                                 mood="1";
                               });
                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Color(0xff64DB2C),
                                    child: Text("Green",style: TextStyle(color: Colors.white),),
                                  ),
                                  SizedBox(height: me.height * .01,),
                                  Text("Feeling Good",style: TextStyle(color: font_color,fontSize: 16,fontStyle: FontStyle.italic),)
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: me.height * .2,

                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 7),
                            decoration: BoxDecoration(
                                color: mood=="2"?Colors.white.withOpacity(.5):Colors.transparent,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: InkWell(
                              onTap: (){

                                setState(() {
                                  mood="2";
                                });
                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.black,
                                    child: Text("Black",style: TextStyle(color: Colors.white),),
                                  ),
                                  SizedBox(height: me.height * .01,),
                                  Text("I'm In Bad \nShape",textAlign :TextAlign.center,style: TextStyle(color: font_color,fontSize: 16,fontStyle: FontStyle.italic),)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: me.height * .03,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: me.height * .2,

                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 7),
                            decoration: BoxDecoration(
                                color: mood=="3"?Colors.white.withOpacity(.5):Colors.transparent,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: InkWell(
                              onTap: (){

                                setState(() {
                                  mood="3";
                                });
                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Color(0xffFFB300),
                                    child: Text("Yellow",style: TextStyle(color: Colors.white),),
                                  ),
                                  SizedBox(height: me.height * .01,),
                                  Text("I'm Okay, Just\nStressed",textAlign :TextAlign.center,style: TextStyle(color: font_color,fontSize: 16,fontStyle: FontStyle.italic),)
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: me.height * .2,

                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 7),
                            decoration: BoxDecoration(
                                color: mood=="4"?Colors.white.withOpacity(.5):Colors.transparent,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: InkWell(
                              onTap: (){

                                setState(() {
                                  mood="4";
                                });
                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Color(0xff5A2250),
                                    child: Text("Purple",style: TextStyle(color: Colors.white),),
                                  ),
                                  SizedBox(height: me.height * .01,),
                                  Text("I Could Really\nUse Support",textAlign :TextAlign.center,style: TextStyle(color: font_color,fontSize: 16,fontStyle: FontStyle.italic),)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height:  me.height *.07,),
                ElevatedButton(
                  onPressed: () {
                    update();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: main_color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Container(
                    height: me.height * .07,
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
                )
             ],
            ),
          )


        ],
      ),
    );
  }
}

