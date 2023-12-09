import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:share_plus/share_plus.dart';
import '../../Controller/profile_data.dart';
import '../../constant.dart';


class add_chat extends StatefulWidget {
  const add_chat({super.key});

  @override
  State<add_chat> createState() => _add_chatState();
}

class _add_chatState extends State<add_chat> {
  TextEditingController _namecontroller=TextEditingController();
  profile controller=Get.put(profile());
  String? id;

  Future<void> add()
  async {
    print("Add FUn Called");
   var response=await post(Uri.parse("chat reauest api"),body:
   {
     "user_id":id.toString(),
     "name":_namecontroller.text.toString()
   });
   print(response.body);

   if(response.statusCode == 200)
     {
       var data=jsonDecode(response.body);
       var message=data['message'];
       if(message == "Name not found in register table")
         {
          tost("User Not Found");
         }
       else if(message == "Data inserted successfully")
         {
           tost("Chat Request sent successfully");
           _namecontroller.clear();
         }

     }
   else
     {
       tost("Server Error");
     }
  }

  @override
  void initState() {
    // TODO: implement initState
    id=controller.id.toString();
    print("My Id:"+id.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final me=MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: me.height,
          width: me.width, 
          decoration: BoxDecoration(
              color: Color(0xffFFFDF3),),
          
          child: Column(
            children: [
              SizedBox(height: me.height * .06,),
              Image.asset("assets/img_9.png",width: me.width,fit: BoxFit.fitWidth,),
              Column(
                children: [
                  Image.asset("assets/img_10.png",height: me.height * .25,width: me.width * .45,),
                  Text("Invite Your Contact",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),),
                  SizedBox(height: me.height * .01,),
                  Text("Enter user name of contact to continue\nconversation",textAlign :TextAlign.center,style: TextStyle(fontSize: 16,fontStyle: FontStyle.italic),),
                  SizedBox(height: me.height * .05,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),

                    child: TextFormField(
                      controller: _namecontroller,
                      decoration: InputDecoration(
                        hintText: 'Write a contact username',
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
                  SizedBox(height: me.height * .03,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                          if(_namecontroller.text.toString()!="")
                            {
                              add();
                            }
                          else
                            {
                              tost("Field is can't be empty");
                            }
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
                            "Add to the Chat",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: me.height * .03,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        final String url = 'https://www.mechodal.com';

                        // Use platform-specific code to share the link
                        // The code shown below is for sharing on Android
                        Share.share(url);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: main_color)
                        ),
                      ),
                      child: Container(
                        height: me.height * .065,
                        width: me.width,
                        decoration: BoxDecoration(

                        ),
                        child: Center(
                          child: Text(
                            "Invite Your friends",
                            style: TextStyle(
                              color: main_color,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
       ],
              )
            ],
          ),

        ),
      ),
    );
  }
}
