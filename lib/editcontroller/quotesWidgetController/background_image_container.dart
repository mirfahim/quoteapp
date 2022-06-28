import 'package:flutter/material.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/AppString.dart';
import 'package:thoughts_creator/utils/screen_util.dart';

// ignore: must_be_immutable
class BackGroundImage extends StatelessWidget {

  final GestureTapCallback onPressed;

  final Function(String) onBgImageChange;


  BackGroundImage({this.onPressed, this.onBgImageChange});


    // const ColorSwatch(0xFFFFFFFF, {500: Colors.white}),
    //  const ColorSwatch(0xFF000000, {500: Colors.black}),
  final List<String> bgImageList = <String>[
    AppString.bgTemplateAssetPath + "img1.png",
    AppString.bgTemplateAssetPath + "img2.png",
    AppString.bgTemplateAssetPath + "img3.png",
    AppString.bgTemplateAssetPath + "img4.png",
    AppString.bgTemplateAssetPath + "img5.png",
    AppString.bgTemplateAssetPath + "img6.png",
    AppString.bgTemplateAssetPath + "img7.png",
    AppString.bgTemplateAssetPath + "img8.png",
  ];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      height: MediaQuery.of(context).size.height/12.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: Constant.size4),
      /* child: GridView.builder(
        shrinkWrap: true,
          itemCount: fullMaterialColors.length,

          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: InkWell(
                onTap: (){
                  onColorChange(fullMaterialColors[index]);
                },
                child: Container(

                  child: Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      height: 28,width: 28,
                      decoration: BoxDecoration(
                          color: fullMaterialColors[index],border: Border.all(
                          color: AppColors.white
                      ),
                          shape: BoxShape.rectangle
                      ),
                    ),
                  ),
                ),
              ),
            );
          })
*/

      child: ListView.builder(
          itemCount: bgImageList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder:(context,index){
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: InkWell(
                onTap: (){
                  onBgImageChange(bgImageList[index]);
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      height: 50,width: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              bgImageList[index]),
                          fit: BoxFit.fill,
                        ),
                         border: Border.all(
                          color: AppColors.white
                      ),
                         // shape: BoxShape.circle
                      ),

                    ),
                  ),
                ),
              ),
            );
          }),

    );
  }

}
