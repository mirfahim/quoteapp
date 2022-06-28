import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:thoughts_creator/controller/TextEditorController.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/screen_util.dart';

import 'WidgetFontColorContainer.dart';
import 'WidgetFontFamilyContainer.dart';



// ignore: camel_case_types
class widgetColorFontPalate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(40.0),
              topRight: const Radius.circular(40.0))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder(
                init: TextEditorController(),
                builder: (TextEditorController textEditingController){
                  return Container(
                    height: Constant.size180,
                    child: new Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: Container(

                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex:1,
                                  child: InkWell(
                                    onTap:(){
                                      textEditingController.updateColorFontTab(true);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(color: textEditingController.isColorTabSelected?
                                                 AppColors.primaryColor
                                                : AppColors.textDisableColor,width:2,),

                                            borderRadius: new BorderRadius.only(
                                                bottomLeft: const Radius.circular(20.0),
                                                topLeft: const Radius.circular(20.0))


                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Center(
                                            child: new Text("Color",
                                              style: TextStyle(color: textEditingController.isColorTabSelected? AppColors.white : AppColors.white),
                                            ),
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex:1,
                                  child: InkWell(
                                    onTap: (){
                                      textEditingController.updateColorFontTab(false);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: textEditingController.isColorTabSelected?
                                               AppColors.textDisableColor
                                              : AppColors.primaryColor, width:2,),
                                          borderRadius: new BorderRadius.only(
                                              bottomRight: const Radius.circular(15.0),
                                              topRight: const Radius.circular(15.0))
                                      ),

                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Center(
                                          child: new Text("Font Style",
                                            style: TextStyle(color: textEditingController.isColorTabSelected ? AppColors.white : AppColors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ),
                        ),

                        Container(
                          child:GetBuilder(
                              init: TextEditorController(),
                              builder: (TextEditorController textEditorController) {
                                return textEditorController.isColorTabSelected ?
                                  WidgetFontColorContainer(
                                  onColorChange: (color) {
                                    textEditorController.updateTextColor(color);
                                    textEditorController.changeCommonTextStyle(textEditorController);
                                  },
                                  ):new Container(child: WidgetFontFamilyContainer(onTextStyleChange: (textStyle){
                                    textEditorController.setFontFamily(textStyle);
                                    textEditorController.changeCommonTextStyle(textEditorController);
                                  },),
                                );
                              }),
                        ),

                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }




}
