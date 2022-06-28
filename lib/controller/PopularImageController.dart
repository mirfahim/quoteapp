import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thoughts_creator/Model/PopularImageResponse.dart';
import 'package:thoughts_creator/Services/RequestApi.dart';
import 'package:thoughts_creator/utils/ApiUtils.dart';
import 'package:thoughts_creator/utils/AppColors.dart';


class PopularImageController extends GetxController {


  var isLoading = true.obs;
  final box = GetStorage();

  List<Src> list = [];
  String imgNetworkPath = '';

  @override
  void onInit() {


    super.onInit();
  }

  void apiCallPopularTamplate() async {
    isLoading(true);
    Future.delayed(
        Duration(microseconds: 5),
            () {
          RequestApi request = RequestApi(url: ApiUtils.Popular_Templet, body: {
          });

          request.post().then((value) {
            print("Response Popular collection "+value.body.toString());
            PopularImageResponse popularImageResponse  = PopularImageResponse.fromJson(json.decode(value.body));

            if(popularImageResponse.status==true){

              if(popularImageResponse.data!=null){
                list.clear();
                isLoading(false);
                imgNetworkPath = popularImageResponse.data.path;
                list.addAll(popularImageResponse.data.src);

                // Get.off(HomeView());

              }else{
                isLoading(false);
                if(!Get.isSnackbarOpen){
                  Get.snackbar("Error", "No Data Found",backgroundColor: AppColors.yellow,
                      snackPosition:SnackPosition.BOTTOM,maxWidth: Get.width,icon: new Icon(Icons.clear));
                }
              }

            }else{

              isLoading(false);
              if(!Get.isSnackbarOpen){
                Get.snackbar("Error", "Something went wrong",backgroundColor: AppColors.yellow,
                    snackPosition:SnackPosition.BOTTOM,maxWidth: Get.width,icon: new Icon(Icons.clear));
              }
            }
          }).catchError((onError) {

            isLoading(false);
            print("Error"+onError.toString());
          });
        });


  }

  @override
  void onClose() {

    super.onClose();
  }
}