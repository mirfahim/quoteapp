import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RatioController extends GetxController{

  double ratioX = 9; //for mainImage container ratioX
  double ratioY = 16; //for mainImage container ratioY
  AlignmentGeometry alignmentGeometry= Alignment.center;
  final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
  List<bool> arrayRatioSelector = [true,false,false,false,false,false];

  void updateRatioValue(double valRatioX, double valRatioY) {
    ratioX = valRatioX;
    ratioY = valRatioY;
    update();
  }


  void setTextPositionCenter() {
  //  print(" ALIG");
    alignmentGeometry = Alignment.center;

    update();
  }

  void setTextMatrixPointCenter(var m) {
   // print(" setTextMatrixPointCenter ");
    notifier.value = m;

    update();
  }


  void updateSelectedRatioContainer(int posArray) {
    for (int i = 0; i < arrayRatioSelector.length; i++) {
      arrayRatioSelector[i]=false;
    }
    arrayRatioSelector[posArray]=true;
    update();
  }




}