



import 'package:get/get.dart';

import '../Api/AllData.dart';
import '../Model/AllData.dart';

class profile extends  GetxController
{
  RxString name="".obs;
  RxString id="".obs;
  RxString email="".obs;
  RxString mood="".obs;
  RxString fid="".obs;
  void GetData()
  {
    userData().data().then((value1) {
      AllData? data1=value1;
      name?.value=data1!.data![0].name.toString();
      id?.value=data1!.data![0].id.toString();
      email?.value=data1!.data![0].email.toString();
      mood?.value=data1!.data![0].mood.toString();
      fid?.value=data1!.data![0].fId.toString();

    });
  }







}