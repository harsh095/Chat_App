import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:Chat_app/Controller/profile_data.dart';
import '../../constant.dart';
import 'audio_controller.dart';
import 'dart:typed_data';



class ChatRoom extends StatefulWidget {
  final Map<String, dynamic> userMap;
  final String chatRoomId;
  final String name;
  final String mood;
  final String fi;
  final String id2;


  ChatRoom({required this.chatRoomId, required this.userMap,required this.name,required this.mood,required this.fi,required this.id2});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _message = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;



  final FirebaseAuth _auth = FirebaseAuth.instance;

  File? imageFile;
  bool sti=false;

  String? name;
  bool all = false;
  String? User_id;
  bool voic =false;
  List<bool> play=[];

  String? photo;
  void audio(String abc) async {

    Map<String, dynamic> messages = {
      "sendby": controller.name.toString(),
      "message": abc.toString(),
      "type": "text2",
      "time": FieldValue.serverTimestamp(),
    };

    _message.clear();
    await _firestore
        .collection('chatroom')
        .doc(widget.chatRoomId)
        .collection('chats')
        .add(messages);

  }
  final List<String> imageUrls = [
    'assets/img_15.png',
    'assets/img_16.png',
    'assets/img_17.png',
    'assets/img_18.png',
    'assets/img_19.png',
    'assets/img_20.png',
  ];

  final player = AudioPlayer();
  List abc1=['Message 1','Message 2','Message 3','Message 4','Message 5'];
 profile controller=Get.put(profile());
  first()
  async {
    Map<String, dynamic> messages = {
      "sendby": name.toString(),
      "message": "Hey $name welcome to the chat, Start your peaceful chat here",
      "type": "text",
      "time": FieldValue.serverTimestamp(),
    };

    _message.clear();
    await _firestore
        .collection('chatroom')
        .doc(widget.chatRoomId)
        .collection('chats')
        .add(messages);

   print(controller.id.toString());
   print(widget.id2.toString());

    var response=await post(Uri.parse("https://mechodalgroup.xyz/tech_care/api/update_first.php"),
    body: {
      "user_id":controller.id.toString(),
      "chat_id": widget.id2.toString(),
      "first":"1"
    });
    print("AllData");
 if(response.statusCode == 200)
      {
        print("All Responswe"+response.body.toString());
        tost("Welcome to the Chat");

      }

  }

  AudioController audioController = Get.put(AudioController());
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {


    print("lkdf"+widget.userMap['sendby'].toString());
    print(controller.name.toString());

    User_id = widget.userMap['w_id'].toString();
    name=controller.name.toString();
    print("seen"+widget.fi.toString());
    if(widget.fi.toString() == "0")
      {
        first();
      }

    super.initState();
  }

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": controller.name.toString(),
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }
  int i = 0;
Future<void> sendm(String abc)
async {
  Map<String, dynamic> messages = {
    "sendby": name.toString(),
    "message": abc.toString(),
    "type": "text",
    "time": FieldValue.serverTimestamp(),
  };

  _message.clear();
  await _firestore
      .collection('chatroom')
      .doc(widget.chatRoomId)
      .collection('chats')
      .add(messages);
}

  void onSendMessage2(String img) async {

      Map<String, dynamic> messages = {
        "sendby": controller.name.toString(),
        "message": img,
        "type": "text1",
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .add(messages);

  }
  late String recordFilePath;
  String audioURL = "";
  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }
  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath =
        "${storageDirectory.path}/record${DateTime.now().microsecondsSinceEpoch}.acc";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return "$sdPath/test_${i++}.mp3";
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      recordFilePath = await getFilePath();
      RecordMp3.instance.start(recordFilePath, (type) {
        setState(() {});
      });
    } else {}
    setState(() {});
  }

  void stopRecord() async {
    bool stop = RecordMp3.instance.stop();
    audioController.end.value = DateTime.now();
    audioController.calcDuration();
    var ap = AudioPlayer();
    await ap.play(AssetSource("Notification.mp3"));
    ap.onPlayerComplete.listen((a) {});
    if (stop) {
      audioController.isRecording.value = false;
      audioController.isSending.value = true;
       await uploadAudio1();

    }
  }

   uploadAudio(var audioFile, String fileName) async {

    try
        {
          Reference reference = storage.ref().child(fileName);
          UploadTask uploadTask = reference.putFile(audioFile);
          uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
            double progress = snapshot.bytesTransferred / snapshot.totalBytes;
            print('Upload progress: $progress');
          });
          await uploadTask.whenComplete(() {
            print('Audio uploaded successfully.');
          });
          String downloadURL = await reference.getDownloadURL();
          audio(downloadURL.toString());



  }
        catch (e)
     {
       tost("Error"+e.toString());
     }

     }

  uploadAudio1() async {
    uploadAudio(File(recordFilePath),
        "audio/${DateTime.now().millisecondsSinceEpoch.toString()}");


  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Color(0xffFFFDF3),
      body:SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            SizedBox(height: size.height * .06,),
            Stack(
              children: [
                Image.asset("assets/img_9.png",width: size.width,fit: BoxFit.fitWidth,),
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
                      SizedBox(width: 20,),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                       Text(widget.name.toString()),
                         SizedBox(height: 5,),
                         if(widget.mood.toString()=="1")
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
                         else if(widget.mood.toString()=="2")
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
                         else if(widget.mood.toString()=="3")
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
                     ],)
                    ],
                  ),
                ),

              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: ()
                  {
                    setState(() {
                      sti=false;
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .7,
                    width: size.width,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('chatroom')
                          .doc(widget.chatRoomId)
                          .collection('chats')
                          .orderBy("time", descending: false)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.data != null) {
                          return ListView.builder(
                            reverse: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              play.add(true);
                              int abc =
                                  snapshot.data!.docs.length - 1 - index;
                              Map<String, dynamic> map =
                              snapshot.data!.docs[abc].data()
                              as Map<String, dynamic>;
                              return messages(size, map, context,index);
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
                sti==false?Container(
                  height: size.height * .13,
                  width: size.width,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 20,),
                          voic?InkWell(
                              onTap: ()
                              {
                                setState(() {
                                  voic=false;
                                  stopRecord();
                                });
                              },
                              child: CircleAvatar(backgroundColor: Colors.black12,child: Icon(Icons.square,color: Colors.red,))):InkWell(
                              onTap: ()
                              {
                                setState(() async {
                                  voic=true;
                                  var audioPlayer = AudioPlayer();
                                  await audioPlayer.play(AssetSource("Notification.mp3"));
                                  audioPlayer.onPlayerComplete.listen((a) {
                                    audioController.start.value = DateTime.now();
                                    startRecord();
                                    audioController.isRecording.value = true;
                                  });


                                });
                              },
                              child: CircleAvatar(backgroundColor: Colors.black12,child: Icon(Icons.keyboard_voice_sharp,color: Colors.black,))),
                          SizedBox(width: 10,),
                          // GestureDetector(
                          //     onLongPress: () async {
                          //       var audioPlayer = AudioPlayer();
                          //       await audioPlayer.play(AssetSource("Notification.mp3"));
                          //       audioPlayer.onPlayerComplete.listen((a) {
                          //         audioController.start.value = DateTime.now();
                          //         startRecord();
                          //         audioController.isRecording.value = true;
                          //       });
                          //     },
                          //     onLongPressEnd: (details) {
                          //       stopRecord();
                          //     },
                          //     child: CircleAvatar(backgroundColor: Colors.black12,child: Icon(Icons.keyboard_voice_sharp,color: Colors.black,))),
                          SizedBox(width: 10,),
                          Container(
                            height: size.height / 17,
                            width: size.width * .4,
                             decoration: BoxDecoration(
                               color: Color(0xffFFDE59),
                               borderRadius: BorderRadius.circular(40)
                             ),

                            child: voic?Container(padding: EdgeInsets.only(left: 10),child: Center(child: Text("Audio Recoding Start..!",maxLines:1,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),):TextField(
                              controller: _message,
                              decoration: InputDecoration(
                                  hintText: "Send Message",
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff3F2D20)),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(40),
                                    borderSide:
                                    BorderSide(color: s_color),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(40),
                                    borderSide: BorderSide(
                                      color:
                                      s_color, // Set the border color when the TextField is focused
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              onSendMessage();
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height *
                                  .06,
                              width:
                              MediaQuery.of(context).size.width * .13,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: s_color),
                                  color: Color(0xffFFFFFF)),
                              child: Icon(
                                Icons.send,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  sti=true;
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: Color(0xffFFDE59),
                                radius: 25,
                                child: Container(padding :EdgeInsets.all(12),child: Image.asset("assets/img_14.png")),
                              ),
                            ),
                          ),

                        ],
                      ),
                     Expanded(
                       child: ListView.builder(
                         itemCount: abc1.length,
                         scrollDirection: Axis.horizontal,
                           itemBuilder: (context,index){
                         return  InkWell(
                           onTap: ()
                           {
                             sendm(abc1[index].toString());
                           },
                           child: Container(
                             margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                             height: 40,
                             padding: EdgeInsets.symmetric(horizontal: 10),


                             decoration: BoxDecoration(
                                 color: Color(0xffFFDE59),
                                 borderRadius: BorderRadius.circular(40),
                               border: Border.all(
                                 color: Colors.black
                               )

                             ),
                             child: Center(child: Text(abc1[index].toString())),
                           ),
                         );
                       }),
                     )
                    ],
                  ),
                ):Container(),

              ],
            ),
          ],
        ),
      ),
      bottomSheet: sti ?Container(
        height: MediaQuery.of(context).size.height *.3,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20
          ),
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: ()
              {
                onSendMessage2(imageUrls[index]);
                setState(() {
                  sti=false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(  imageUrls[index]),
                    fit: BoxFit.cover,

                  )
                ),

              ),
            );
          },
        ),
      ): Container(
        height: 1,
      ),

    );
  }

  Widget messages(Size size, Map<String, dynamic> map, BuildContext context,int index)
  {
   return map['type'] == "text"
        ? Container(
      width: size.width,
      alignment: map['sendby'] == name.toString()
          ? Alignment.bottomRight
          : Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: map['sendby'] == name.toString() ? Color(0xffFFDE59) : Colors.white,
        ),
        child: Text(
          map['message'],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    )
        : map['type'] == "text1" ?Container(
      height: size.height / 4,
      width: size.width,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      alignment: map['sendby'] == name
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          print("photo"+map['message'].toString());
        },
        child: Container(
          height: size.height / 2.5,
          width: size.width / 2,
          decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(map['message']),
              fit: BoxFit.cover
            )

          ),
          alignment: map['message'] != "" ? null : Alignment.center,

        ),
      ),
    ):map['type'] == "text2" ?Container(
      height: size.height * .07,
      width: size.width,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      alignment: map['sendby'] == name
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        height: size.height * .07,
        width: size.width / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: map['sendby'] == name.toString() ? Color(0xffFFDE59) : Colors.white,
          border: Border.all()
        ),
        alignment: map['message'] != "" ? null : Alignment.center,
        child: Row(
 crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 5,),
            play[index]?IconButton(onPressed: () async {
              setState(() {
                play[index]=false;
              });
              await player.play(UrlSource( map['message']));
            }, icon: Icon(Icons.play_arrow,size: 30,)):IconButton(onPressed: (){
             setState(() {
               play[index]=true;
             });
             player.pause();
            }, icon: Icon(Icons.pause,size: 30,)),
            map['sendby'] == name.toString() ?Text("Audio Sended..."):Text("Audio Recived...")
          ],
        ),

      ),
    ):Container(
      height: size.height / 2.5,
      width: size.width,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      alignment: map['sendby'] == name
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: size.height / 2.5,
          width: size.width / 2,
          decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(20),

          ),
          alignment: map['message'] != "" ? null : Alignment.center,
          child: Container(
            child: map['message'] != ""
                ? Image.network(
              map['message'],
              fit: BoxFit.cover,
            )
                : CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

//
