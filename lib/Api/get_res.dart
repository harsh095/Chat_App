import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Model/AllData.dart';
import '../Model/get_response.dart';

class get_res {
  Future<getres> data1(

      ) async {
    SharedPreferences SUId = await SharedPreferences.getInstance();
    var  id = SUId.getString('user_id').toString();
    print("User Id Basic:"+id);
    var url = Uri.parse('https://mechodalgroup.xyz/tech_care/api/get_response.php');
    var response = await http.post(url,
        body: ({
          'user_id': id,
        }));


    Map<String, dynamic> map = await jsonDecode(response.body);
    print("All Data");
    print(response.body);

    final data = getres.fromJson(map);
    return data;
  }



}