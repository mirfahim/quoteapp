import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thoughts_creator/controller/RatioController.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/screen_util.dart';

class WidgetRatioSelectController extends StatelessWidget {

  final GestureTapCallback onPressed;
  final double containerHeight;
  final double containerWidth;
  final int arrayPos;
  final String imagePath;
  final String ratioText;

  final Color containerBgColor;
  final Color iconColor;
  final Gradient gradientColor;

   WidgetRatioSelectController({this.onPressed,this.containerHeight,this.containerWidth,
     this.arrayPos,this.imagePath,this.ratioText,this.containerBgColor,this.iconColor,this.gradientColor});

   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder(
        init: RatioController(),
         builder: (RatioController ratioController,){
          return Container(

            child:  GestureDetector(
              onTap: onPressed,
              child: Material(
                borderRadius: BorderRadius.circular(2.0),
                elevation: 5.0,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                type: MaterialType.transparency,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: ratioController.arrayRatioSelector[arrayPos]==true
                        ? AppColors.greenColor: Colors.transparent,
                    width: 2),
                  ),

                  child: new Container(
                    margin: EdgeInsets.all(4),
                    height: containerHeight,
                    width: containerWidth,
                    decoration: BoxDecoration(
                      color: containerBgColor,
                       gradient: gradientColor,
                        border: Border.all(color: ratioController.arrayRatioSelector[arrayPos]==true
                            ? AppColors.greenColor: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(Constant.size6))
                    ),
                    child: Center(
                      child: Container(
                          child:new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              new Image.asset(imagePath,height:24.0,width:24.0,color: iconColor,),
                              Container(
                                  margin:EdgeInsets.only(top:Constant.size10),
                                  child: new Text(ratioText,style: TextStyle(color: iconColor),)),
                            ],
                          ),
                      ),
                    ),

                  ),
                ),
              ),
            ),

          );
     }

    );
  }



}

