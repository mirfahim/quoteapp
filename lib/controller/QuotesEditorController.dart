import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thoughts_creator/Model/QuotesDataResponse.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/AppGradiantColor.dart';


class QuotesEditorController extends GetxController{

  int bottomChangedQuotesIndex=0;
  String appBarTitleQuotes="English";
  Color simpleColorBg = AppColors.black;
  Gradient gradientColorBg= AppGradiantColors.Gradiant1;
  int isColorTabSelected = 0;
  int isLangTabSelected=0;
  List<Datum> quoteData =[];
  List<Color> tmpColor = [];

  void updateBottomQuotesIndex(int bottomIndex) {
    bottomChangedQuotesIndex=bottomIndex;
    print("bottomChangedQuotesIndex "+bottomChangedQuotesIndex.toString());
    update();
  }

  void updateAppBarTitleQuotes(String title) {
    appBarTitleQuotes=title;
    print("appBarTitleQuotes "+appBarTitleQuotes.toString());
    update();
  }

 void updateColorBgQuotes(Color colorBG) {
   simpleColorBg=colorBG;

    print("hi");
    print("simpleColorBg "+ simpleColorBg.toString());
    update();
  }

void updateGradientColorBgQuotes(Gradient gradientColorBG) {
    gradientColorBg=gradientColorBG;
    print("gradientColorBg "+gradientColorBg.toString());
    update();
  }


  void updateQuotesColorTab(int isColorTabSel) {

    isColorTabSelected=isColorTabSel;

    print("isColorTabSelected="+isColorTabSelected.toString());
    update();
  }

  void updateQuotesLanguageTab(int isLangTabSel) {

    isLangTabSelected=isLangTabSel;

    print("isLangTabSelected="+isLangTabSelected.toString());
    update();
  }

 void updateQuotesDataResponse(List<Datum> quotesData) {

   quoteData  = quotesData;
  //  print("quoteData"+quoteData.toString());
    update();
  }

   void updateQuotesColorCategory(List<Color> colorData) {

     tmpColor  = colorData;
  //  print("tmpColor"+tmpColor.toString());
    update();
  }


}