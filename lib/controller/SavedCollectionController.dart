import 'package:get/get.dart';
import 'package:thoughts_creator/Model/ImgClass.dart';

class SavedCollectionController extends GetxController{

  List<ImgClass> imgFiles = [];
  List<ImgClass> selectedList = [];
  bool isAllSelect=false;


  void updateMainImgFiles(List<ImgClass> imgFiles1){
    imgFiles= imgFiles1;
    print("Hello");
    update();
  }

  void updateSelectedFiles(List<ImgClass> selectedList1){
    selectedList= selectedList1;
    update();
  }

  void updateIsSelectDeselectAll(bool isSelect){
    isAllSelect= isSelect;
    update();
  }

}