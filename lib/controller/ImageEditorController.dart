import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

class ImageEditorController extends GetxController{

  double selImgOpacity=0.90;
  double imageBrightness=0.0;
  double imageSaturation=0.0;
  double imageHUE=0.0;


  ColorFilter  colorFilterImage = ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.darken);
  Matrix4  imageFlip=Matrix4Transform().matrix4;
  String imageSliderType="Brightness";
  bool isFilterImgDisplay=true;


  void imageOpacityChange(double imgOpacity) {
    selImgOpacity=imgOpacity;
    print("selImgOpacity "+imgOpacity.toString());
    update();
  }

 void updateBrightnessChange(double imgbrightness) {
   imageBrightness=imgbrightness;

    print("imgbrightness "+imgbrightness.toString());
    update();
  }
  void updatSaturationChange(double imgSaturation) {
    imageSaturation=imgSaturation;
    print("imgSaturation "+imgSaturation.toString());
    update();
  }
  void updateHueChange(double imgHue) {
    imageHUE=imgHue;
    print("imageHUE "+imageHUE.toString());
    update();
  }

  void checkImgFilterDispay(bool imgFilterDisp) {
    isFilterImgDisplay=imgFilterDisp;
    print("isFilterImgDisplay====== "+isFilterImgDisplay.toString());
    update();
  }


   void imageSliderTypeChange(String imgSliderType) {
     imageSliderType=imgSliderType;
    print("imageSliderType "+imgSliderType.toString());
    update();
  }



  void setImageFilter(ColorFilter selectImgFilter) {

    print("setImageFilter");
    colorFilterImage=selectImgFilter;
    update();
  }

  void updateImageFlip(Matrix4 imgFlip) {
    print("Font Weight ");
    if(imgFlip==Matrix4Transform().matrix4){
      imageFlip = Matrix4Transform().flipHorizontally().matrix4;
    }else{
      imageFlip = Matrix4Transform().matrix4;
    }
    update();
  }





}