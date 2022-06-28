import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:thoughts_creator/controller/CommonEditorController.dart';
import 'package:thoughts_creator/controller/QuotesEditorController.dart';
import 'package:thoughts_creator/editcontroller/quotesWidgetController/background_image_container.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/AppString.dart';
import 'package:thoughts_creator/utils/screen_util.dart';

import 'WidgetBackgroundImageContainer.dart';
import 'WidgetQuotesColorContainer.dart';
import 'WidgetQuotesGradiantContainer.dart';

// ignore: camel_case_types
class widgetGradiantColorPalate extends StatelessWidget {
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
                init: QuotesEditorController(),
                builder: (QuotesEditorController quotesEditorController) {
                  return Container(
                    height: Constant.size260,
                    child: new Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Container(
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      quotesEditorController
                                          .updateQuotesColorTab(0);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(

                                            border: Border.all(color: quotesEditorController
                                                .isColorTabSelected == 0
                                                ? AppColors.primaryColor
                                                : AppColors.textDisableColor,width:2,),
                                            borderRadius: new BorderRadius.only(
                                                topLeft: const Radius.circular(15.0),
                                                bottomLeft: const Radius.circular(15.0),
                                                bottomRight: const Radius.circular(0.0),
                                                topRight: const Radius.circular(0.0))
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Center(
                                            child: new Text(
                                              "Color",
                                              style: TextStyle(
                                                  color: quotesEditorController.isColorTabSelected == 0
                                                      ? AppColors.primaryColor
                                                      : AppColors.textDisableColor),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),

                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      quotesEditorController
                                          .updateQuotesColorTab(1);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          /*color: quotesEditorController
                                                      .isColorTabSelected == 1
                                              ? AppColors.primaryDarkColor
                                              : AppColors.primaryColor,*/

                                          border: Border.all(color: quotesEditorController
                                              .isColorTabSelected == 1
                                              ? AppColors.primaryColor
                                              : AppColors.textDisableColor,width:2,),

                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Center(
                                          child: new Text(
                                            "Gradient ",
                                            style: TextStyle(
                                                color: quotesEditorController
                                                            .isColorTabSelected == 1
                                                    ? AppColors.primaryColor
                                                    : AppColors.textDisableColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      // quotesEditorController
                                      //     .updateQuotesColorTab(1);
                                      quotesEditorController.updateQuotesColorTab(2);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: quotesEditorController
                                              .isColorTabSelected == 2
                                              ? AppColors.primaryColor
                                              : AppColors.textDisableColor,width:2,),
                                          borderRadius: new BorderRadius.only(
                                              topLeft: const Radius.circular(0.0),
                                              bottomLeft: const Radius.circular(0.0),
                                              bottomRight: const Radius.circular(15.0),
                                              topRight: const Radius.circular(15.0))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Center(
                                          child: new Text(
                                            "Background ",
                                            style: TextStyle(
                                                color: quotesEditorController.isColorTabSelected == 2
                                                    ? AppColors.primaryColor
                                                    : AppColors.textDisableColor),
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
                          child: GetBuilder(
                            init: CommonEditorController(),
                            builder: (
                              CommonEditorController commonController,
                            ) {
                              return Container(
                                child: GetBuilder(
                                  init: QuotesEditorController(),
                                  builder: (QuotesEditorController
                                      quotesEditorController) {
                                    return Container(
                                      child: quotesEditorController.isColorTabSelected == 0
                                          ? WidgetQuotesColorContainer(
                                              onColorChange: (color) {
                                                commonController.replaceImageColorContainer(false);
                                                quotesEditorController.updateColorBgQuotes(color);
                                              },
                                            )
                                          : quotesEditorController.isColorTabSelected == 1
                                              ? new Container(
                                                  child: WidgetQuotesGradiantContainer(
                                                    onColorChange: (color) {
                                                      commonController.replaceImageColorContainer(false);
                                                      quotesEditorController.updateGradientColorBgQuotes(color);
                                                    },
                                                  ),
                                                )
                                              :
                                      new Container(
                                        child: BackGroundImage(
                                          onBgImageChange: (color) {

                                          },
                                        ),
                                      )
                                      // new Container(
                                      //             child: new Container(
                                      //                 height: 80.0,
                                      //                 child:  Container(
                                      //                     child: widgetBackgroundImageContainer(
                                      //                           onBgImageChange: (val) {
                                      //                             commonController.replaceImageColorContainer(true);
                                      //                             if(commonController.isNoDataApi){
                                      //                               commonController.updateImageBgPath(AppString.NoApiImageNetwork);
                                      //                             }else{
                                      //                               commonController.updateImageBgPath(val);
                                      //
                                      //                             }
                                      //
                                      //
                                      //
                                      //                           },
                                      //                         )
                                      //                     )),
                                      //           ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
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
