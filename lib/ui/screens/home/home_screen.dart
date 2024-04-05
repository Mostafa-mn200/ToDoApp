import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../business/homeComtroller/HomeComtroller.dart';
import '../../../conustant/my_colors.dart';
import '../../../data/dBHelper/db_helper.dart';
import '../bottomSheet/add_update_bottom_sheet.dart';
import '../conustant/empty/empty_screen.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen>{
  final homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.refreshData();
  }


 /* void showBottomSheet(int? id)async{
    //update&add
    if(id!=null){
      final existingData= homeController.allData.firstWhere((element) => element['id']==id);
      homeController.tittleController.text=existingData['title'];
      homeController.descController.text=existingData['desc'];
    }
    showModalBottomSheet(
      elevation: 5,
        isScrollControlled: true,
        context: context,
        builder: (_)=>Container(
          padding: EdgeInsets.only(
            top: 30,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom +50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: MyColors.BorderColor, width: 1.0,),
                    color: Colors.white),
                child: title(),
              ),
              SizedBox(height: 1.h,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: MyColors.BorderColor, width: 1.0,),
                    color: Colors.white),
                child: desc(),
              ),
              SizedBox(height: 1.h,),
              SizedBox(
                width: double.infinity,
                height: 8.h,
                child: TextButton(
                  style: flatButtonStyle,
                  onPressed: () async{
                    //if(_formKey.currentState!.validate()){
                      if(id==null){
                        await _addData();
                      }if(id!=null){
                        await _updateData(id);
                      }
                      tittleController.clear();
                      descController.clear();
                      Navigator.of(context).pop();
                    // }
                  },
                  child: Text(id==null?"Add":"Update",
                    style:  TextStyle(fontSize: 12.sp,
                        fontFamily: 'lexend_bold',
                        fontWeight: FontWeight.w700,
                        color: Colors.white),),
                ),
              )
            ],
          ),
        )
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.MainColor,
        title: Text("Home",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: (){
                  homeController.deleteAll();
                },
                child: SvgPicture.asset('assets/delete2.svg',width: 5.h,height: 5.h)),
          )
        ],
      ),
      body: Obx(() => !homeController.isLoading.value
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(left: 1.5.h, right: 1.5.h, top: 1.5.h),
              child: itemList(),
            )
          : const Center(
              child: CircularProgressIndicator(color: MyColors.MainColor),
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet<void>(
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              context: context,
              backgroundColor: Colors.white,
              builder: (BuildContext context) => Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddUpdateBottomSheet(null)));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: MyColors.MainColor2,
        clipBehavior: Clip.antiAlias,
        child:  const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }

  Widget itemList() {
    if (homeController.allData.isNotEmpty){
      return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: homeController.allData.length,
          itemBuilder: (context, int index) {
            return Container(
              padding: EdgeInsetsDirectional.all(1.h),
              margin: EdgeInsetsDirectional.only(bottom: 1.h),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                  border: Border.all(color: MyColors.MainColor2)),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 30.h,
                        child: Text(
                            homeController.allData[index]['title'],
                            style: TextStyle(fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: MyColors.Dark1)),
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: (){
                            //showBottomSheet(homeController.allData[index]['id']);
                            showModalBottomSheet<void>(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                ),
                                context: context,
                                backgroundColor: Colors.white,
                                builder: (BuildContext context) => Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: AddUpdateBottomSheet(homeController.allData[index]['id'])));
                          },
                          child: SvgPicture.asset('assets/edit2.svg',width: 5.h,height: 5.h,)),
                      const SizedBox(width: 5,),
                      GestureDetector(
                          onTap: (){
                            homeController.deleteData(homeController.allData[index]['id'],context);
                          },
                          child: SvgPicture.asset('assets/delete2.svg',width: 5.h,height: 5.h))
                    ],
                  ),
                  SizedBox(height: 1.h,),
                  Text(
                      homeController.allData[index]['desc'],
                      style: TextStyle(fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: MyColors.Dark1)),
                ],
              ),
            );
          }
      );
    } else{
      return emptyScreen();
    }
  }



}