import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/dBHelper/db_helper.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  TextEditingController tittleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  RxList<dynamic> allData=[].obs;

  void refreshData()async{
    final data= await SqlHelper.getAllData();
      allData.value=data;
    isLoading.value=false;
  }

  Future<void> addData()async{
    await SqlHelper.createData(tittleController.text, descController.text);
    refreshData();
  }

  Future<void> updateData(int id)async{
    await SqlHelper.updateData(id, tittleController.text, descController.text);
    refreshData();
  }

  Future<void> deleteData(int id,BuildContext context)async{
    await SqlHelper.deleteData(id);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("Data Deletes")));
    refreshData();
  }

  Future<void> deleteAll()async{
    await SqlHelper.deleteAll();
    refreshData();
  }
}