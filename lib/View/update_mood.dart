import 'dart:convert';

import 'package:Chat_app/Controller/profile_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';


class mood_select1 extends StatefulWidget {
  const mood_select1({super.key});

  @override
  State<mood_select1> createState() => _mood_select1State();
}

class _mood_select1State extends State<mood_select1> {

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
      mood=controller.mood.toString();


    super.initState();
  }
  Future<void> update()
  async {
    var response=await post(Uri.parse("chnage status api"),
        body: {'id':id.toString(),'mood': mood.toString()});
    if(response.statusCode == 200)
    {
      var data=jsonDecode(response.body);
      String? message=data['message'];
      if(message == "Updated successfully")
      {
        controller.GetData();
        tost("Update Succesfully");


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
      backgroundColor: Color(0xffFFFDF3),
      body: Column(
        children: [

          SizedBox(height: me.height * .06,),
          Stack(
            children: [
              Image.asset("assets/img_9.png",width: me.width,fit: BoxFit.fitWidth,),
              Container(
                padding: EdgeInsets.only(top: 20,left: 20),
                child: Row(
                  children: [


                    SizedBox(width: 10,),
                    Text("Status of Mood",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 31),)
                  ],
                ),
              ),

            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),

            child: Column(
              children: [
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
                                color: mood=="1"?Colors.black.withOpacity(.2):Colors.transparent,
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
                                  Text("Feeling Good",style: TextStyle(color: Colors.black,fontSize: 16,fontStyle: FontStyle.italic),)
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: me.height * .2,

                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 7),
                            decoration: BoxDecoration(
                                color: mood=="2"?Colors.black.withOpacity(.2):Colors.transparent,
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
                                  Text("I'm In Bad \nShape",textAlign :TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 16,fontStyle: FontStyle.italic),)
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
                                color: mood=="3"?Colors.black.withOpacity(.2):Colors.transparent,
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
                                  Text("I'm Okay, Just\nStressed",textAlign :TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 16,fontStyle: FontStyle.italic),)
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: me.height * .2,

                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 7),
                            decoration: BoxDecoration(
                                color: mood=="4"?Colors.black.withOpacity(.2):Colors.transparent,
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
                                  Text("I Could Really\nUse Support",textAlign :TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 16,fontStyle: FontStyle.italic),)
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
                    primary: main_color   ,
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
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

