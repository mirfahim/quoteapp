import 'package:flutter/material.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/AppGradiantColor.dart';
import 'package:thoughts_creator/utils/screen_util.dart';

// ignore: must_be_immutable
class WidgetQuotesGradiantContainer extends StatelessWidget {

  final GestureTapCallback onPressed;

  final Function(Gradient) onColorChange;


  WidgetQuotesGradiantContainer({this.onPressed,this.onColorChange});

  List<Gradient> fullMaterialColors = const <Gradient>[

    AppGradiantColors.Gradiant1,
    AppGradiantColors.Gradiant2,
    AppGradiantColors.Gradiant3,
    AppGradiantColors.Gradiant4,
    AppGradiantColors.Gradiant5,
    AppGradiantColors.Gradiant6,
    AppGradiantColors.Gradiant7,
    AppGradiantColors.Gradiant8,
    AppGradiantColors.Gradiant9,
    AppGradiantColors.Gradiant10,
    AppGradiantColors.Gradiant11,
    AppGradiantColors.Gradiant12,
    AppGradiantColors.Gradiant13,
    AppGradiantColors.Gradiant14,
    AppGradiantColors.Gradiant15,
    AppGradiantColors.Gradiant16,
    AppGradiantColors.Gradiant17,
    AppGradiantColors.Gradiant18,
    AppGradiantColors.Gradiant19,
    AppGradiantColors.Gradiant20,
    AppGradiantColors.Gradiant21,
    AppGradiantColors.Gradiant22,
    AppGradiantColors.Gradiant23,
    AppGradiantColors.Gradiant24,
    AppGradiantColors.Gradiant25,
    AppGradiantColors.Gradiant26,
    AppGradiantColors.Gradiant27,
    AppGradiantColors.Gradiant28,
    AppGradiantColors.Gradiant29,
    AppGradiantColors.Gradiant30,
    AppGradiantColors.Gradiant31,
    AppGradiantColors.Gradiant32,
    AppGradiantColors.Gradiant33,
    AppGradiantColors.Gradiant34,
    AppGradiantColors.Gradiant35,
    AppGradiantColors.Gradiant36,
    AppGradiantColors.Gradiant37,
    AppGradiantColors.Gradiant38,
    AppGradiantColors.Gradiant39,
    AppGradiantColors.Gradiant40,
    AppGradiantColors.Gradiant41,
    AppGradiantColors.Gradiant42,
    AppGradiantColors.Gradiant43,
    AppGradiantColors.Gradiant44,
    AppGradiantColors.Gradiant45,
    AppGradiantColors.Gradiant45,
    AppGradiantColors.Gradiant46,
    AppGradiantColors.Gradiant47,
    AppGradiantColors.Gradiant48,
    AppGradiantColors.Gradiant49,
    AppGradiantColors.Gradiant50,
    AppGradiantColors.Gradiant51,
    AppGradiantColors.Gradiant52,
    AppGradiantColors.Gradiant53,
    AppGradiantColors.Gradiant54,
    AppGradiantColors.Gradiant55,
    AppGradiantColors.Gradiant56,
    AppGradiantColors.Gradiant57,
    AppGradiantColors.Gradiant58,
    AppGradiantColors.Gradiant59,
    AppGradiantColors.Gradiant60,
    AppGradiantColors.Gradiant61,
    AppGradiantColors.Gradiant62,
    AppGradiantColors.Gradiant63,
    AppGradiantColors.Gradiant64,
    AppGradiantColors.Gradiant65,
    AppGradiantColors.Gradiant66,
    AppGradiantColors.Gradiant67,
    AppGradiantColors.Gradiant68,
    AppGradiantColors.Gradiant69,
    AppGradiantColors.Gradiant70,


  ];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
        height: MediaQuery.of(context).size.height/12.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: Constant.size4),
      /*  child: GridView.builder(
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
                    height: 28,width: 28,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.white),
                        gradient:fullMaterialColors[index],
                       // color: fullMaterialColors[index],
                        shape: BoxShape.rectangle
                    ),
                  ),
                ),
              );
            })*/



        child: ListView.builder(
    itemCount: fullMaterialColors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder:(context,index){
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: InkWell(
              onTap: (){
                onColorChange(fullMaterialColors[index]);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0,top:10.0),
                child: Container(
                  height: 10,width: 28,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white),
                      gradient:fullMaterialColors[index],
                      // color: fullMaterialColors[index],

                  ),
                ),
              ),
            ),
          );
        }),
    );
  }

}









