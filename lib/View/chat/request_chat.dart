import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import 'package:http/http.dart';
import 'package:Chat_app/Controller/profile_data.dart';
import '../../Api/get_res.dart';
import '../../Model/get_response.dart';
import '../../constant.dart';

class request_chat extends StatefulWidget {
  const request_chat({super.key});

  @override
  State<request_chat> createState() => _request_chatState();
}

class _request_chatState extends State<request_chat> {

  getres? data;
  String? id;
  bool isloding=false;


  void get()
  {
    get_res().data1().then((value1) {
      setState(() {
        data=value1;
        print(value1.toString());
        isloding=true;
      });
    });

  }

  Future<void> add(String id1)
  async {
    var response =await post(Uri.parse("add chat api"),body: {
      "user_id1": id.toString(),
      "user_id2":id1.toString()
    });
    if(response.statusCode == 200)
      {
        var data=jsonDecode(response.body);
        String message=data['message'];
        if(message == "Data inserted successfully")
          {
            tost("Add Chat Succesfully");
            get();
          }

      }
    else
      {
        tost("Server Error");
      }

  }
  profile controller=Get.put(profile());
  @override
  void initState() {
    // TODO: implement initState
    id=controller.id.toString();
    get();
    print("My Idertw:"+id.toString());
    super.initState();
  }
  Future<void> _refreshData() async {
    get();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final me=MediaQuery.of(context).size;
    return Scaffold(
      body: isloding?RefreshIndicator(
        onRefresh: _refreshData,
        color: main_color,

        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            width: me.width,
            decoration: BoxDecoration(
              color: Color(0xffFFFDF3),),

            child: Column(
              children: [
                SizedBox(height: me.height * .06,),
                Stack(
                  children: [
                    Image.asset("assets/img_9.png",width: me.width,fit: BoxFit.fitWidth,),
                    Container(
                      padding: EdgeInsets.only(top: 20,left: 20),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },

                            child: CircleAvatar(
                              radius: 22, backgroundColor: Colors.white,
                              child: Center(child: Icon(Icons.arrow_back,color: Colors.black,),),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text("Connector's",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 31),)
                        ],
                      ),
                    ),

                  ],
                ),
                Image.asset("assets/img_12.png",height: me.height * .04,width: me.width * .7,fit: BoxFit.fitWidth,),
                SizedBox(height: me.height * .02,),
                ListView.builder(
                  itemCount:  data!.records!.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context,index)
                 {
                  return Container(
                    height: me.height * .07,
                    width: me.width,

                    margin: EdgeInsets.symmetric(horizontal: 24,vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                    child: Row(
                      children: [
                        Container(
                          width: me.width * .6,
                          child:RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: data!.records![index].name.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16
                                  ),
                                ),
                                TextSpan(
                                    text: ' Want to make a connection',
                                    style: TextStyle(
                                        color: Colors.black54,
                                      fontSize: 16
                                    )
                                ),
                              ],
                          ),
                          ),
                        ),
                        InkWell(
                          onTap:()
                          {
                            add(data!.records![index].id.toString());
                          },
                          child: CircleAvatar(
                            radius: 38,
                            backgroundColor: Color(0xffFFB300),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/img_13.png"),
                            ),
                          ),
                        )
                      ],
                    ),

                  );
                })


              ],
            ),

          ),
        ),
      ):Center(
        child: CircularProgressIndicator(
          color: s_color,
        ),
      ),
    );
  }
}