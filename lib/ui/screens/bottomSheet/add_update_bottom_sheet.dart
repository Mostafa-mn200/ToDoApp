import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:sizer/sizer.dart';

import '../../../business/homeComtroller/HomeComtroller.dart';
import '../../../conustant/my_colors.dart';

class AddUpdateBottomSheet extends StatefulWidget{
  var id;

  AddUpdateBottomSheet(this.id);

  @override
  State<StatefulWidget> createState() {
    return _AddUpdateBottomSheet();
  }
}

class _AddUpdateBottomSheet extends State<AddUpdateBottomSheet>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  final _formKey = GlobalKey<FormState>();
  final homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    if(widget.id!=null){
      final existingData= homeController.allData.firstWhere((element) => element['id']==widget.id);
      homeController.tittleController.text=existingData['title'];
      homeController.descController.text=existingData['desc'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2.h,left: 2.h,top: 1.h,bottom: 1.h),
      child: Form(
        key: _formKey,
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
                  if(_formKey.currentState!.validate()){
                  if(widget.id==null){
                    await homeController.addData();
                  }if(widget.id!=null){
                    await homeController.updateData(widget.id);
                  }
                  homeController.tittleController.clear();
                  homeController.descController.clear();
                  Navigator.of(context).pop();
                   }
                },
                child: Text(widget.id==null?"Add":"Update",
                  style:  TextStyle(fontSize: 12.sp,
                      fontFamily: 'lexend_bold',
                      fontWeight: FontWeight.w700,
                      color: Colors.white),),
              ),
            )
          ],
        ),
      ),

    );
  }

  Widget title (){
    return TextFormField(
      autovalidateMode:AutovalidateMode.onUserInteraction ,
      controller: homeController.tittleController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please Enter Title';
        }
        return null;
      },
      maxLines: 1,
      decoration: InputDecoration(
        errorBorder:  const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.red,style: BorderStyle.solid),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(style: BorderStyle.solid,color: Colors.white70,)
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.red,style: BorderStyle.solid),
        ) ,
        hintText: 'Title',
        hintStyle:  TextStyle(fontSize: 12.sp,
            fontWeight: FontWeight.w300,
            color: MyColors.Dark3),
      ),
      style:  TextStyle(fontSize: 12.sp,
          fontWeight: FontWeight.w300,
          color: MyColors.Dark3),
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }

  Widget desc (){
    return TextFormField(
      autovalidateMode:AutovalidateMode.onUserInteraction ,
      controller: homeController.descController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please Enter Description';
        }
        return null;
      },
      maxLines: 4,
      decoration: InputDecoration(
        errorBorder:  const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.red,style: BorderStyle.solid),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(style: BorderStyle.solid,color: Colors.white70,)
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.red,style: BorderStyle.solid),
        ) ,
        hintText: 'Description',
        hintStyle:  TextStyle(fontSize: 12.sp,
            fontWeight: FontWeight.w300,
            color: MyColors.Dark3),
      ),
      style:  TextStyle(fontSize: 12.sp,
          fontWeight: FontWeight.w300,
          color: MyColors.Dark3),
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }

}