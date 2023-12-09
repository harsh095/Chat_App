import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/AllData.dart';





class userData {
  Future<AllData> data(

      ) async {
    SharedPreferences SUId = await SharedPreferences.getInstance();
    var  id = SUId.getString('user_id').toString();
    print("User Id Basic:"+id);
    var url = Uri.parse('Your regitration Api');
    var response = await http.post(url,
        body: ({
          'id': id,
        }));


    Map<String, dynamic> map = await jsonDecode(response.body);
    print("All Data");
    print(response.body);

    final data = AllData.fromJson(map);
    return data;
  }




}