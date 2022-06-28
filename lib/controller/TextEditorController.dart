import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TextEditorController extends GetxController{

  String quoteText = "Double Tab to write Text";
  TextAlign textAlign = TextAlign.center;
  FontWeight textFontWeight=FontWeight.normal;
  Color textColor = Colors.white;
  TextStyle textStyleFont = GoogleFonts.oswald(textStyle: TextStyle(color: Colors.white, ));
  FontStyle textFontStyle = FontStyle.normal;
  TextDecoration textDecoration = TextDecoration.none;
  double textSize = 12.0;
  double rotateValue = 0.0;
  double textLetterSpacing = 0.0;
  double textLineSpacing = 1.0;
  AlignmentGeometry alignmentGeometry= Alignment.center;
  bool isColorTabSelected = true;



  void updateQuotesText(String quoteString) {
    quoteText=quoteString;
    update();
  }

  void updateTextAlign(TextAlign textAlignment) {
    print("ALIGN ");
    textAlign=textAlignment;
    update();
  }

 /* void updateTextFontWeight(FontWeight textFontWeight) {
    print("Font Weight ");
    textFontWeight=textFontWeight;
    update();
  }*/

  void updateTextColor(Color color) {

    textColor=color;
    update();
  }

  void updateTextStyle(TextStyle textStyleVal) {
    textStyleFont=textStyleVal;
    update();
  }

  void setFontFamily(TextStyle selectFontFamily) {
    textStyleFont=selectFontFamily;
    update();
  }

  void updateTextFontWeight(FontWeight txtFontWeight) {
    print("Font Weight ");
    if(txtFontWeight==FontWeight.bold){
      textFontWeight = FontWeight.normal;
    }else{
      textFontWeight = FontWeight.bold;
    }
    update();
  }

  void updateTextFontItalic(FontStyle txtFontStyle) {
    print("updateTextFontItalic "+txtFontStyle.toString());
     if(txtFontStyle==FontStyle.italic){
       textFontStyle = FontStyle.normal;
     }else{
       textFontStyle = FontStyle.italic;
     }
     update();
  }

  void updateTextUnderline(TextDecoration txtDecoration) {
    print("textDecoration "+textDecoration.toString());
    if(txtDecoration==TextDecoration.none){
      textDecoration = TextDecoration.underline;
    }else{
      textDecoration = TextDecoration.none;
    }
    update();
  }

  void updateTextSize(double txtSize,bool isIncrease) {
   // print("txtSize "+txtSize.toString());
    if(isIncrease){
      if(txtSize<72.0){
        txtSize++;
      }
    }else{
      if(txtSize>8.0){
        txtSize--;
      }
    }
    textSize=txtSize;
    update();
  }

  void updateRotateValue(double txtRotateValue) {
   // print("updateRotateValue "+txtRotateValue.toString());
    rotateValue=txtRotateValue;

    update();
  }

  void updateLetterSpacingValue(double txtLatterSpaceValue,bool isIncrease) {

    if(isIncrease){
      if(textLetterSpacing<8.0){
        txtLatterSpaceValue++;
      }
    }else{
      if(textLetterSpacing>0.0){
        txtLatterSpaceValue--;
      }
    }
    textLetterSpacing = txtLatterSpaceValue;
    update();
  }
  void updateLineSpacingValue(double txtLineSpaceValue,bool isIncrease) {
    double pointSpace=0.2;
    if(isIncrease){
      if(txtLineSpaceValue<8.0){
        var txtLineSpaceValue1=txtLineSpaceValue;
        txtLineSpaceValue=(txtLineSpaceValue1+pointSpace);

      }
    }else{
      if(txtLineSpaceValue>1.0){
        var txtLineSpaceValue1=txtLineSpaceValue;
        txtLineSpaceValue=(txtLineSpaceValue1-pointSpace);
      }
    }
    textLineSpacing = txtLineSpaceValue;
    update();
  }

  void updateColorFontTab(bool isColorTabSel) {
    isColorTabSelected  = isColorTabSel;
    update();
  }

  changeCommonTextStyle(TextEditorController textEditorController){
    TextStyle textStyle = textEditorController.textStyleFont;
    textEditorController.setFontFamily(textStyle.apply(decoration:textEditorController.textDecoration,
        color: textEditorController.textColor,fontStyle: textEditorController.textFontStyle
    ).copyWith(fontWeight: textEditorController.textFontWeight,fontSize: textEditorController.textSize,
        letterSpacing: textEditorController.textLetterSpacing,height: textEditorController.textLineSpacing));
  }


}