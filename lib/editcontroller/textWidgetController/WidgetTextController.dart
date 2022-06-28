
import 'package:flutter/material.dart';
import 'package:thoughts_creator/utils/AppColors.dart';


class WidgetTextController extends StatelessWidget{

  final IconData icons;
  final GestureTapCallback onPressed;
  final bool isIcon;
  final String iconPathString;
  // double iconSize=12.0;


  WidgetTextController({this.icons,this.iconPathString,@required this.onPressed, @required this.isIcon});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: onPressed,
          child: isIcon ? Icon(icons,color: AppColors.white,size: 24.0,)
              : new Image.asset(iconPathString,fit: BoxFit.cover,
          width: 24.0,height: 24.0,color: AppColors.white,),
      ),
    );
  }

}