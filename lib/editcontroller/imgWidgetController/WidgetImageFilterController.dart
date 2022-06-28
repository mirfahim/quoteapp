
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thoughts_creator/controller/CommonEditorController.dart';

import 'package:thoughts_creator/utils/AppColors.dart';



// ignore: must_be_immutable
class WidgetImageFilterController extends StatelessWidget{


  final GestureTapCallback onPressed;

  final Function(ColorFilter) onImageFilterChange;

  WidgetImageFilterController({this.onPressed,this.onImageFilterChange});


  List<ColorFilter> colorFilterList =  <ColorFilter>[


  ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.darken),
  ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
  ColorFilter.mode(Colors.greenAccent.withOpacity(0.5), BlendMode.darken),
  ColorFilter.mode(Colors.brown.withOpacity(0.5), BlendMode.darken),
  ColorFilter.mode(Colors.red.withOpacity(0.5), BlendMode.darken),
  ColorFilter.mode(Colors.green.withOpacity(0.5), BlendMode.darken),
  ColorFilter.mode(Colors.teal.withOpacity(0.5), BlendMode.darken),
  ColorFilter.mode(Colors.deepOrangeAccent.withOpacity(0.5), BlendMode.darken),
  ColorFilter.mode(Colors.purple.withOpacity(0.5), BlendMode.darken),
  ColorFilter.mode(Colors.pink.withOpacity(0.5), BlendMode.darken),
  ColorFilter.mode(Colors.cyan.withOpacity(0.5), BlendMode.darken),
  ColorFilter.mode(Colors.deepPurpleAccent.withOpacity(0.5), BlendMode.darken),
  ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.darken),
  ColorFilter.mode(Colors.yellow.withOpacity(0.5), BlendMode.darken),
  ColorFilter.mode(Colors.blue.withOpacity(0.5), BlendMode.darken),
  ColorFilter.mode(Colors.tealAccent.withOpacity(0.5), BlendMode.darken),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder(
      init: CommonEditorController(),
      builder:
      (CommonEditorController controller){
        return Container(
          height:80.0,
          width:MediaQuery.of(context).size.width,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: colorFilterList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white, width: 1.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: (){
                          onImageFilterChange(colorFilterList[index]);
                        },
                        child:  controller.imgFileFromGallery==null?Container(
                          height: 40.0,
                          width: 55.0,
                          decoration: BoxDecoration(
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              colorFilter:colorFilterList[index],
                              image: new NetworkImage(
                                controller.imageBgPath,
                              ),
                            ),
                          ),
                        )
                         :Container(
                          height: 50.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            image: new DecorationImage(
                              fit: BoxFit.cover,
                              colorFilter:colorFilterList[index],
                              image: new FileImage(
                                controller.imgFileFromGallery,
                              ),
                            ),
                          ),
                        ),

                      ),
                    ),
                  ),
                );
              }
          ),
        );
      },

    );
  }

}