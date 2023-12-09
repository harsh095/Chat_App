import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Model/getchat.dart';

class get_chat {
  Future<getchat> data1(

      ) async {
    SharedPreferences SUId = await SharedPreferences.getInstance();
    var  id = SUId.getString('user_id').toString();
    print("User Id Basic:"+id);
    var url = Uri.parse('Your chat list Api');
    var response = await http.post(url,
        body: ({
          'user_id': id,
        }));


    Map<String, dynamic> map = await jsonDecode(response.body);
    print("All Data");
    print(response.body);

    final data = getchat.fromJson(map);
    return data;
  }
  Future<getchat> data2(

      ) async {
    SharedPreferences SUId = await SharedPreferences.getInstance();
    var  id = SUId.getString('user_id').toString();
    print("User Id Basic:"+id);
    var url = Uri.parse('Cloase frd List Api');
    var response = await http.post(url,
        body: ({
          'user_id': id,
        }));


    Map<String, dynamic> map = await jsonDecode(response.body);

    final data = getchat.fromJson(map);
    return data;
  }



}