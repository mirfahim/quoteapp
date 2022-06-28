import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thoughts_creator/controller/CommonEditorController.dart';
import 'package:thoughts_creator/utils/AppColors.dart';

class WidgetBottomMainContainer extends StatelessWidget {

  final IconData icons;
  final bool isicon;
  final String imgPath;
  final GestureTapCallback onPressed;
  final String textLabel;
  final int arrayPos;


  WidgetBottomMainContainer({this.icons,@required this.textLabel,
    @required this.isicon, this.imgPath, @required this.onPressed,@required this.arrayPos});


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CommonEditorController(),

      builder: (CommonEditorController commonController){
        return Container(
          child:  InkWell(
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isicon ?  new Icon(
                      icons,
                      size: 34.0,
                      color: AppColors.white,
                    ) : new Image.asset(imgPath,width: 24.0,height: 24.0,
                      color:commonController.arrayBottomSelector[arrayPos]==true?
                      AppColors.primaryColor:AppColors.white),
                    Padding(
                      padding: const EdgeInsets.only(top:2.0),
                      child: new Text(textLabel,style: TextStyle(color: AppColors.white
                          ,fontSize: 12.0),),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
