import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:Chat_app/Api/get_chat.dart';
import 'package:Chat_app/Controller/profile_data.dart';
import 'package:Chat_app/Model/getchat.dart';
import 'package:Chat_app/View/chat/request_chat.dart';

import '../../constant.dart';
import 'chat_room.dart';

class chat_home extends StatefulWidget {
  const chat_home({super.key});

  @override
  State<chat_home> createState() => _chat_homeState();
}

class _chat_homeState extends State<chat_home> {

  int i=1;
  profile controller=Get.put(profile());
  String? id;
  getchat? data;
  @override
  void initState() {

    id=controller.id.toString();
    print("Harsh"+id.toString());
    fun();
    super.initState();
  }
  bool isloding=false;


  fun()
  {
    get_chat().data1().then((value1) {
      setState(() {
        data=value1;
        print(value1.toString());
        print("abc");
        isloding=true;
      });
    });
  }
  String chatRoomId(String u1, String u2) {
    print("ids"+"$u2");
    print("ids2"+"$u1");

    int user1=int.parse(u1.toString());
    int user2=int.parse(u2.toString());

    if(user1%2==0&&user2%2==0)
    {
      if(user1<user2)
      {
        return "$user2$user1";
      }
      else
      {
        return "$user1$user2";
      }
    }
    else if(user1%2!=0&&user2%2!=0)
    {
      if(user1<user2)
      {
        return "$user2$user1";
      }
      else
      {
        return "$user1$user2";
      }
    }
    else
    {
      if(user1%2==0)
      {
        return "$user2$user1";
      }
      else
      {
        return "$user1$user2";
      }
    }

  }
  Future<void> _refreshData() async {
    fun();
    setState(() {});
  }
  var userMap;
  void onSearch(String id2,name,mood,fi) async {
    String room_id=chatRoomId(id.toString(),id2.toString());
    print("jzghskdryhdhtdt");
    print(id.toString());
    print(fi.toString());
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection('users')
        .where("w_id", isEqualTo: id)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
      });
      print("ujAFHLIS");
      print(userMap);
    });
    pushNewScreen(
      context,
      screen: ChatRoom(
        chatRoomId: room_id.toString(),
        userMap: userMap!, name: name.toString(), mood: mood.toString(), fi: fi.toString(), id2: id2.toString(),
      ),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
  _Show_post(String name,id,mood, bool add) async {
    await Future.delayed(const Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              final me=MediaQuery.of(context).size;

              List n=name.toString().split("");
            add1()
              async {
                var response=await post(Uri.parse("update cloase frd list"),
                    body: {
                      "user_id":controller.id.toString(),
                      "chat_id": id.toString(),
                      "close_friend":"1"
                    });
                print( {
                  "user_id":controller.id.toString(),
                  "chat_id": id.toString(),
                  "close_friend":"1"
                });



                if(response.statusCode == 200)
                {
                   var data=jsonDecode(response.body);

                   if(data['message'] == "Updated successfully")
                     {
                       fun();
                       tost("Close Friend Add Succesfully");
                       Navigator.pop(context);
                     }

                }
              }
              remove()
              async {
                var response=await post(Uri.parse("update cs list"),
                    body: {
                      "user_id":controller.id.toString(),
                      "chat_id": id.toString(),
                      "close_friend":"0"
                    });



                if(response.statusCode == 200)
                {
                  var data=jsonDecode(response.body);

                  if(data['message'] == "Updated successfully")
                  {
                    fun();
                    tost("Close Friend Remove Succesfully");
                    Navigator.pop(context);
                  }

                }
              }

              return Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    InkWell(
                      onTap: ()
                      {
                        Navigator.pop(context);
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 30,left: 20),
                          child: Icon(Icons.close,color: Colors.white,size: 30,
                          )),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .1,),
                    Container(
                      height: me.height*.07,

                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: main_color),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xffF3F1E7),
                            radius: 25,
                            child: Center(child: Text(n.first.toString().toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),),),
                          ),
                          SizedBox(width: 20,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name,style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                              if(mood.toString()=="1")
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.green,
                                      radius: 5,
                                    ),
                                    SizedBox(width: 5,),
                                    Text("Green",style: TextStyle(color: Color(0xff72777A)),)
                                  ],
                                )
                              else if(mood.toString()=="2")
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 5,
                                    ),
                                    SizedBox(width: 5,),
                                    Text("Black",style: TextStyle(color: Color(0xff72777A)),)
                                  ],
                                )
                              else if(mood.toString()=="3")
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.yellow,
                                        radius: 5,
                                      ),
                                      SizedBox(width: 5,),
                                      Text("Yellow",style: TextStyle(color: Color(0xff72777A)),)
                                    ],
                                  )
                                else
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Color(0xff5A2250),
                                        radius: 5,
                                      ),
                                      SizedBox(width: 5,),
                                      Text("Purple",style: TextStyle(color: Color(0xff72777A)),)
                                    ],
                                  )

                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .5,),
                    add == true?Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          add1();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: main_color,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          height: me.height * .065,
                          width: me.width,
                          child: Center(
                            child: Text(
                              "Add to Close Friend",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ):Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () {
                            remove();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: main_color,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          height: me.height * .065,
                          width: me.width,
                          child: Center(
                            child: Text(
                              "Remove to Close Friend",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final me=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: isloding?RefreshIndicator(
          onRefresh: _refreshData,
          color: main_color,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: me.height * .2,
                  width: me.width,
                  padding: EdgeInsets.symmetric(horizontal: 35,vertical: 20),
                  decoration: BoxDecoration(
                      color: Color(0xffFFFDF3),
                      image: DecorationImage(
                          image: AssetImage("assets/img_9.png")

                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Obx(() {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: me.width * .6,
                                child: Text("Hello ,"+controller.name.toString(),maxLines:1,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 31,fontWeight: FontWeight.bold),)),
                            SizedBox(height: me.height * .01,),
                            if(controller.mood== "1")
                              Text("Green",style: TextStyle(fontSize: 16,fontFamily: "ABeeZee"),)
                            else if(controller.mood == "2")
                              Text("Black",style: TextStyle(fontSize: 16,fontFamily: "ABeeZee"),)
                            else if(controller.mood == "3")
                                Text("Yello",style: TextStyle(fontSize: 16,fontFamily: "ABeeZee"),)
                              else if(controller.mood == "4")
                                  Text("Purple",style: TextStyle(fontSize: 16,fontFamily: "ABeeZee"),)
                          ],
                        );

                      }),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: request_chat()));

                            },
                            child: Image.asset("assets/img_11.png",height: me.height * .06,)
                        ),
                      )
                    ],
                  ),
                ),
                ListView.builder(
                    itemCount: data!.records!.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context,index)
                    {

                      List n=data!.records![index].name.toString().split("");
                      print(n.first.toString());

                      return InkWell(
                        onTap: (){
                          onSearch(data!.records![index].id.toString(),data!.records![index].name.toString(),data!.records![index].mood.toString(),data!.records![index].first.toString());
                        },
                        onLongPress: ()
                        {
                          print("Close Friend"+data!.records![index].closeFriend.toString());
                          if(data!.records![index].closeFriend.toString() == "0")
                            {
                              print("a");
                              _Show_post(data!.records![index].name.toString(),data!.records![index].id.toString(),data!.records![index].mood.toString(),true);
                            }
                          else
                            {
                              print("b");
                              _Show_post(data!.records![index].name.toString(),data!.records![index].id.toString(),data!.records![index].mood.toString(),false);
                            }
                        },
                        child: Container(
                          height: me.height*.07,

                          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: data!.records![index].closeFriend.toString()=="0"?Colors.white: Color(0xffFFB300)),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Color(0xffF3F1E7),
                                radius: 25,
                                child: Center(child: Text(n.first.toString().toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),),),
                              ),
                              SizedBox(width: 20,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(data!.records![index].name.toString(),style: TextStyle(fontWeight: FontWeight.bold),),

                                      SizedBox(height: 5,),
                                      if(data!.records![index].mood.toString()=="1")
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.green,
                                              radius: 5,
                                            ),
                                            SizedBox(width: 5,),
                                            Text("Green",style: TextStyle(color: Color(0xff72777A)),)
                                          ],
                                        )
                                      else if(data!.records![index].mood.toString()=="2")
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.black,
                                              radius: 5,
                                            ),
                                            SizedBox(width: 5,),
                                            Text("Black",style: TextStyle(color: Color(0xff72777A)),)
                                          ],
                                        )
                                      else if( data!.records![index].mood.toString()=="3")
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: Colors.yellow,
                                                radius: 5,
                                              ),
                                              SizedBox(width: 5,),
                                              Text("Yellow",style: TextStyle(color: Color(0xff72777A)),)
                                            ],
                                          )
                                        else
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: Color(0xff5A2250),
                                                radius: 5,
                                              ),
                                              SizedBox(width: 5,),
                                              Text("Purple",style: TextStyle(color: Color(0xff72777A)),)
                                            ],
                                          )

                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  if(data!.records![index].mood.toString() == "2"||data!.records![index].mood.toString() == "4")
                                    Container(

                                    height: me.height * .03,
                                    width: me.width * .2,
                                    decoration: BoxDecoration(
                                      color: Color(0xffFFB300),
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Center(child: Text("Check in?",style: TextStyle(fontWeight: FontWeight.bold),)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    })


              ],
            ),
          ),
        ):Center(
            child: CircularProgressIndicator(
              color: s_color,
            )),
      ),
    );
  }

}
