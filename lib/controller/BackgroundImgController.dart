import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thoughts_creator/Model/GetBgImageResponse.dart';
import 'package:thoughts_creator/Services/RequestApi.dart';
import 'package:thoughts_creator/utils/ApiUtils.dart';
import 'package:thoughts_creator/utils/AppColors.dart';

import 'CommonEditorController.dart';

class BackgroundImgController extends GetxController {
  TextEditingController emailTextController;
  final CommonEditorController commonEditorController = Get.put(CommonEditorController());

  var isLoading=true.obs;
  final box = GetStorage();

  @override
  void onInit() {
    emailTextController = TextEditingController();

    super.onInit();
  }

  void apiLogin() async {
    print("heyyy===========================apiLogin");
    print("read switch=="+box.read('switch', ).toString());
   isLoading(true);
    Future.delayed(
        Duration(microseconds: 0),
            () {
              RequestApi request = RequestApi(url: ApiUtils.Thoughts_IMG,

                  body: {
              }
              );
              request.post().then((value) {
                print("doneeeeeee"+value.statusCode.toString());
                print("doneeeeeee"+value.body.toString());

                if(value.statusCode!=200){
                  print("heyyy===========================");

                  commonEditorController.updateIsNoDataApi(true);

                }else{
                  commonEditorController.updateIsNoDataApi(false);
                  print("hellooooo===========================");
                }

                GetBgImageResponse getBgImageResponse =
                GetBgImageResponse.fromJson(json.decode(value.body));

                if(getBgImageResponse.status==true){
                  if(getBgImageResponse.data!=null){
                    isLoading(false);
                    commonEditorController.updateBgImgResponse(getBgImageResponse);


                   commonEditorController.updateBgImgRatioResponse(commonEditorController.getBgImageResponse.data.size.ratio916);

                    print("aaaaaaaaaaaaaaaaaa"+getBgImageResponse.data.size.ratio32.img[0].img.toString());
                    print("aaaaaaaaaaaaaaaaaa"+commonEditorController.getBgImageResponse.data.path.toString());


                   // Get.off(HomeView());

                  }else{
                    if(!Get.isSnackbarOpen){
                      Get.snackbar("Error", "No Data Found",backgroundColor: AppColors.yellow,
                          snackPosition:SnackPosition.BOTTOM,maxWidth: Get.width,icon: new Icon(Icons.clear));
                    }
                  }

                }else{
                  if(!Get.isSnackbarOpen){
                    Get.snackbar("Error", "Something went wrong",backgroundColor: AppColors.yellow,
                        snackPosition:SnackPosition.BOTTOM,maxWidth: Get.width,icon: new Icon(Icons.clear));
                  }
                }
              }).catchError((onError) {


                print("Error"+onError.toString());
              });
            });


  }

  @override
  void onClose() {
    emailTextController?.dispose();
    super.onClose();
  }
}