import 'dart:io';

import 'package:get/get.dart';
import 'package:thoughts_creator/Model/GetBgImageResponse.dart';

class CommonEditorController extends GetxController{

  bool isShowSubEditContainer = false; //for subEditController hide/show
  File imgFileFromGallery;
  bool isShowImage=true;
  bool isShowFloatingBtn=true;
  bool isNoDataApi=true;
  int subEditContainerType=0;
  String  imageBgPath="assets/images/tamplate_one.jpg";
  List<bool> arrayBottomSelector = [true,false,false,false,false,false,false,false];
  String appVersion="1.0.5";
  GetBgImageResponse  getBgImageResponse;
  Ratio sizeRatioBgImage;
  String ratioValueKeyDisplay="/ratio9_16/img/";
  String ratioValueKeyThumb="/ratio9_16/thumb/";
  int selectedBottomMainIndex=0;
  int selectedPageViewIndex=0;
  String appBarTitle="Thoughts Of the Day";


  void showSubEditContainer(bool value,[int subEditorContainerType]) {
    isShowSubEditContainer = value;
    subEditContainerType = subEditorContainerType;
    update();
  }

  void replaceImage(File imgFile) {
    imgFileFromGallery = imgFile;
    update();
  }

 void updateImageBgPath(String imgBgPath) {
   imageBgPath = imgBgPath;
    update();
  }

  void replaceImageColorContainer(bool isImage) {
    isShowImage = isImage;
    update();
  }

 void updateFloatingBtnContainer(bool isFloatingBtn) {
   isShowFloatingBtn = isFloatingBtn;
    update();
  }


  void updateSelectedBottomContainer(int posArray) {
    for (int i = 0; i < arrayBottomSelector.length; i++) {
      arrayBottomSelector[i]=false;
    }
    arrayBottomSelector[posArray]=true;
    update();
  }


  void updateBgImgResponse(GetBgImageResponse response) {
    getBgImageResponse = response;
    update();
  }

void updateBgImgRatioResponse(Ratio ratio) {
//  print("ratio======="+ratio.img.toString());
  sizeRatioBgImage = ratio;
  //print("sizeRatioBgImage"+sizeRatioBgImage.toString());
    update();
  }


void updateRatioValueKey(String ratioValDisplay,String ratioValThumb) {

  ratioValueKeyDisplay = ratioValDisplay;
  ratioValueKeyThumb = ratioValThumb;
    update();
  }

    void updateBottomMainIndex(int index){
      selectedBottomMainIndex=index;
      update();
    }

void updatePageViewIndex(int index){
  selectedPageViewIndex=index;
      update();
    }


void updateAppBarTitle(String title){
  appBarTitle=title;
      update();
    }


void updateAppVersion(String title){
  appVersion=title;
  print("appVersion==="+appVersion.toString());
      update();
    }
  void updateIsNoDataApi(bool value) {
    isNoDataApi = value;

    update();
  }


}