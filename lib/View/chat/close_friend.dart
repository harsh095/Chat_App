import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:Chat_app/View/chat/request_chat.dart';

import '../../Api/get_chat.dart';
import '../../Controller/profile_data.dart';
import '../../Model/getchat.dart';
import '../../constant.dart';
import 'chat_room.dart';



class close_frd extends StatefulWidget {
  const close_frd({super.key});

  @override
  State<close_frd> createState() => _close_frdState();
}

class _close_frdState extends State<close_frd> {

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
    get_chat().data2().then((value1) {
      setState(() {
        data=value1;
        print(value1.toString());

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: me.width * .6,
                          child: Text("Circle",maxLines:1,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 31,fontWeight: FontWeight.bold),)),
                      SizedBox(height: me.height * .01,),

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
