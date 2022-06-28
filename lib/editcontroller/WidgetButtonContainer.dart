import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/AppString.dart';
import 'package:thoughts_creator/utils/screen_util.dart';

// ignore: must_be_immutable
class WidgetButtonContainer extends StatelessWidget {

  final String textLabel;

  final bool isIcon;
  final String imageName;
  final double buttonHeight;
  final double buttonWidth;

  final double textSize;
  final VoidCallback onPressed;

  WidgetButtonContainer({@required this.isIcon,@required this.textLabel,
    this.imageName,this.buttonHeight,this.buttonWidth,@required this.textSize,@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(

        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppString.imagesAssetPath+"ic_button_bg_medium.png"),
            fit: BoxFit.cover
          )
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isIcon ? Container(
              margin: const EdgeInsets.all(8.0),
              padding: EdgeInsets.only(right:Constant.size4),
              child: new Image.asset(imageName,
                height: 18.0,
                width: 18.0,
                color: AppColors.black,
              ),
            ) :new Container(),
            Center(
              child: new Text(textLabel,style: GoogleFonts.muli(
                fontSize: textSize,color: AppColors.black
                ,fontWeight: FontWeight.bold,
              ),),
            ),
          ],
        ),

      ),
    );
  }
}
