
import 'package:flutter/material.dart';
import 'package:thoughts_creator/utils/AppColors.dart';

class WidgetRatioContainer extends StatelessWidget {

  final String textRatioLabel;
  final double heightRatio;
  final double widthRatio;
  final GestureTapCallback onPressed;

  WidgetRatioContainer({@required this.textRatioLabel,@required this.widthRatio,@required this.heightRatio,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Container(
                    height:heightRatio,width: widthRatio,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.white,width: 1.0
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: new Text(textRatioLabel,style: TextStyle(
                        color: AppColors.white,fontSize: 13.0
                    ),),
                  )
                ],
              ),
            )));
  }

}
