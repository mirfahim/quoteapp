import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:thoughts_creator/controller/CommonEditorController.dart';
import 'package:thoughts_creator/controller/ImageEditorController.dart';
import 'package:thoughts_creator/controller/QuotesEditorController.dart';
import 'package:thoughts_creator/controller/RatioController.dart';
import 'package:thoughts_creator/controller/TextEditorController.dart';
import 'package:thoughts_creator/editcontroller/imgWidgetController/WidgetBrightnessSliderContainer.dart';
import 'package:thoughts_creator/editcontroller/imgWidgetController/WidgetImageFilter.dart';
import 'package:thoughts_creator/editcontroller/imgWidgetController/WidgetImageFilterController.dart';
import 'package:thoughts_creator/editcontroller/quotesWidgetController/widgetGradiantColorPalate.dart';
import 'package:thoughts_creator/editcontroller/textWidgetController/WidgetBottomMainContainer.dart';

import 'package:thoughts_creator/editcontroller/textWidgetController/WidgetRatioContainer.dart';
import 'package:thoughts_creator/editcontroller/textWidgetController/WidgetTextController.dart';
import 'package:thoughts_creator/editcontroller/textWidgetController/WidgetTextRotateSliderContainer.dart';
import 'package:thoughts_creator/editcontroller/textWidgetController/widgetColorFontPalate.dart';
import 'package:thoughts_creator/ui/QuotesUI/QuotesCategoryScreenUI.dart';
import 'dart:ui' as ui;
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/AppCommonFunc.dart';

import 'package:thoughts_creator/utils/AppString.dart';
import 'package:thoughts_creator/utils/screen_util.dart';

import 'DownloadImageScreenUI.dart';
import 'QuotesUI/QuotesAddScreenUI.dart';

class EditorScreenUI extends StatefulWidget {
  @override
  _EditorScreenUIState createState() => _EditorScreenUIState();
}

class _EditorScreenUIState extends State<EditorScreenUI> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  final globalKey = new GlobalKey();
  final globalRepaintKey = new GlobalKey();
  final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());

 // double _scale = 1.0;
  //double _previousScale = 1.0;
  final ratioController1 = Get.put(RatioController());
  final commonController = Get.put(CommonEditorController());
  Matrix4 matrix = Matrix4.identity();
  @override
  void initState() {
    // TODO: implement initState
    checkInternetConnection();
    super.initState();
 //   AppCommonFunc.adInterstitialAdshow();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: (){
          showExitFromEditor(commonController,ratioController1);
          return;
        },
        child: GetBuilder(
          init: CommonEditorController(),
          builder: (CommonEditorController commonController) {
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: AppColors.backgroundColor,
            appBar: new AppBar(
              centerTitle: true,
              leading: InkWell(
                onTap: () {
                  //showExitFromEditor(commonController,ratioController1);
                  commonController.showSubEditContainer(false);
                  //Navigator.pop(context);
                },
                child: new Container(
                  child: new Icon(
                    Icons.arrow_back,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              actions: [
                InkWell(
                  onTap: () {
                    showExitFromEditor(commonController,ratioController1);
                    return;
                    //Navigator.pop(context);
                  },
                  child: new Container(
                    child: new Icon(
                      Icons.home,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],

              backgroundColor: AppColors.backgroundColor,
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Column(
                    children: [


                      Expanded(
                        flex: 1,
                        child:  GestureDetector(
                          onTap: () {
                             commonController.showSubEditContainer(false);
                             commonController.updateFloatingBtnContainer(true);
                          },
                          child: Center(
                            child: GetBuilder(
                                init: RatioController(),
                                builder: (RatioController ratioController) {
                                  return Stack(
                                    children: [
                                      commonController.isShowImage?
                                      imageEditContainer(ratioController)
                                          :gradientColorEditContainer(ratioController),
                                      //quotesTextContainer(ratioController),
                                    ],
                                  );
                                }),
                          ),
                        ),
                      ),
                      mainBottomContainer(),
                    ],
                  ),
                  subBottomContainer(),
                ],
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

            floatingActionButton:commonController.isShowFloatingBtn?
            Container(
              margin: EdgeInsets.only(bottom: Constant.size80),
              child: FloatingActionButton(
                // isExtended: true,
                child: Image.asset(AppString.iconImagesPath+"ic_download.png",
                    height: 24.0,
                    width:24.0
                ),
                backgroundColor: Colors.green,
                onPressed: () {
                  _captureAndSharePng();
                },
              ),
            )
                :new Container(),


          );
          }
        ),
      ),
    );
  }

  Widget widgetSubContainerFunction(CommonEditorController commonController) {
    switch (commonController.subEditContainerType) {
      case AppString.TYPE_RATIO:
        return mainRatioContainer(commonController);
        break;
      case AppString.TYPE_TEXT:
        return mainTextContainer();
        break;
      case AppString.TYPE_IMAGE:
        return Container(
          child:mainImageContainer(),
        );
        break;
     case AppString.TYPE_GRADIENT_COLOR:
        return widgetGradiantColorPalate();
        break;
     case AppString.SUB_TYPE_COLOR:
        return GetBuilder(
            init: TextEditorController(),
            builder: (TextEditorController textEditorController) {
              return widgetColorFontPalate();
            });
        break;


      default:
        return Container();
    }
  }

  Widget subBottomContainer() {
    return GetBuilder(
      init: CommonEditorController(),
      builder: (CommonEditorController commonController) {
        return Align(
          alignment: AlignmentDirectional.bottomEnd,
          child: Visibility(
            visible: commonController.isShowSubEditContainer,
            child: FadeInUp(
              preferences:
                  AnimationPreferences(duration: Duration(milliseconds: 1)),
              child: new Container(
                width: MediaQuery.of(context).size.width,
                height: commonController.subEditContainerType==AppString.TYPE_RATIO?
                Constant.size150:Constant.size130,
                decoration: BoxDecoration(
                  color: AppColors.bottomBGColor,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(4.0),
                      topRight: const Radius.circular(4.0)),
                ),
                child: commonController.subEditContainerType==AppString.TYPE_RATIO?
                widgetSubContainerFunction(commonController): widgetSubContainerFunction(commonController),
              ),
            ),
          ),
        );
      },
    );
  }

  ImageEditorController imageEditorController = Get.put(ImageEditorController());
  Widget mainBottomContainer() {
    return GetBuilder(
        init: CommonEditorController(),
        builder: (CommonEditorController commonController) {
          return Material(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)), elevation: 5.0, clipBehavior: Clip.antiAliasWithSaveLayer, type: MaterialType.transparency,
            child: Stack(
              children: [
                new Container(
                  height: Constant.size80, color: AppColors.backgroundColor,
                  child: ListView(
                    scrollDirection: Axis.horizontal, shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: new Container(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            WidgetBottomMainContainer(
                                isicon: false,
                                textLabel: "Gallery",
                                imgPath: AppString.iconImagesPath+"ic_gallery.png",
                                  arrayPos: 0,
                                onPressed: () {
                                  getImage(context, commonController);
                                  commonController
                                      .updateSelectedBottomContainer(0);
                                  commonController.updateFloatingBtnContainer(true);

                                }),
                            WidgetBottomMainContainer(
                                isicon: false,
                                textLabel: "Ratio",
                                arrayPos: 1,
                              imgPath: AppString.iconImagesPath+"ic_ratio.png",
                                onPressed: () {
                                  commonController.showSubEditContainer(
                                      true, AppString.TYPE_RATIO);
                                  commonController
                                      .updateSelectedBottomContainer(1);

                                  commonController.updateFloatingBtnContainer(false);
                                }),
                            WidgetBottomMainContainer(
                                isicon: false,
                                textLabel: "Text Add",
                                arrayPos: 2,
                                imgPath: AppString.iconImagesPath+"ic_text_edit.png",
                                onPressed: () {
                                  Get.to(() => QuotesAddScreenUI(""));
                                  commonController
                                      .updateSelectedBottomContainer(2);
                                }),
                              GetBuilder(
                                init:QuotesEditorController() ,
                                  builder: (QuotesEditorController quotesEditorController){
                                return  WidgetBottomMainContainer(
                                    isicon: false,
                                    textLabel: "Quotes",
                                    arrayPos: 3,
                                    imgPath:AppString.iconImagesPath+"ic_quotes.png" ,
                                    onPressed: () {
                                      quotesEditorController
                                          .updateQuotesColorTab(0);

                                      Get.to(() => QuotesCategoryScreenUI());
                                      commonController
                                          .updateSelectedBottomContainer(3);
                                    });

                              }),
                            WidgetBottomMainContainer(
                                isicon: false,
                                textLabel: "Text",
                                arrayPos: 4,
                               imgPath: AppString.iconImagesPath+"ic_text_font.png",
                                onPressed: () {
                                  commonController.showSubEditContainer(
                                      true, AppString.TYPE_TEXT);
                                  commonController
                                      .updateSelectedBottomContainer(4);
                                  commonController.updateFloatingBtnContainer(false);
                                }),
                            WidgetBottomMainContainer(
                                isicon: false,
                                textLabel: "Text Color",
                                arrayPos: 5,
                               imgPath: AppString.iconImagesPath+"ic_text_color.png",
                                onPressed: () {
                                  commonController.showSubEditContainer(
                                      true, AppString.SUB_TYPE_COLOR);
                                  commonController
                                      .updateSelectedBottomContainer(5);
                                  commonController.updateFloatingBtnContainer(false);
                                }),
                              commonController.isShowImage?
                            GetBuilder(
                              init: ImageEditorController(),
                              builder: (ImageEditorController imageController){
                                return  WidgetBottomMainContainer(
                                    isicon: false,
                                    textLabel: "Filter",
                                    arrayPos: 6,
                                    imgPath: AppString.iconImagesPath+"ic_filter.png",
                                    onPressed: () {
                                      if(commonController.isShowImage){
                                        print("hi imahge");
                                        imageEditorController.checkImgFilterDispay(true);
                                        //  Get.find<ImageEditorController>().checkImgFilterDispay(true);

                                      }else{
                                        print("hello==not img");
                                        imageEditorController.checkImgFilterDispay(false);
                                        // Get.find<ImageEditorController>().checkImgFilterDispay(false);

                                      }

                                      commonController.showSubEditContainer(
                                          true, AppString.TYPE_IMAGE);
                                      commonController
                                          .updateSelectedBottomContainer(6);
                                      commonController.updateFloatingBtnContainer(false);



                                    });
                              },

                            ):new Container(),
                            GetBuilder(

                              init: QuotesEditorController(),
                              builder: (QuotesEditorController quotesEditorController) {
                                return WidgetBottomMainContainer(
                                    isicon: false,
                                    textLabel: "Background",
                                    arrayPos: 7,
                                    imgPath: AppString.iconImagesPath+'ic_background.png',
                                    onPressed: () {
                                      quotesEditorController.updateQuotesColorTab(0);
                                      commonController.showSubEditContainer(
                                          true, AppString.TYPE_GRADIENT_COLOR);
                                      commonController
                                          .updateSelectedBottomContainer(7);
                                      commonController.updateFloatingBtnContainer(false);
                                    });
                              },

                            ),


                        /*    WidgetBottomMainContainer(
                                textLabel: "Background",
                                icons: FontAwesomeIcons.fastBackward,
                                onPressed: () {
                                   commonController.showSubEditContainer(
                                      true, AppString.SUB_TYPE_BACKGROUND);
                                }),*/


                          ],
                        ),
                      ),
                    ),
                  ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget imageEditContainer(RatioController ratioController) {
    return Center(
      child: AspectRatio(
        aspectRatio: ratioController.ratioX / ratioController.ratioY,
        child: Padding(

          padding: const EdgeInsets.all(8.0),
          child: GetBuilder(
            init: CommonEditorController(),
            builder: (CommonEditorController controller) {
              return RepaintBoundary(
                key: globalRepaintKey,
                child:Stack(
                  children: [
                    Material(

                        borderRadius: BorderRadius.circular(10.0),
                        elevation: 5.0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        type: MaterialType.transparency,
                        child: GetBuilder(
                          init: ImageEditorController(),
                          builder: (ImageEditorController imageEditorController) {
                            return new Container(
                              child: controller.imgFileFromGallery == null
                                  ? Transform(
                                alignment: Alignment.center,
                                transform: imageEditorController.imageFlip,
                                child: Center(
                                  child: WidgetImageFilter(
                                    brightness: imageEditorController.imageBrightness,
                                    hue: imageEditorController.imageSaturation,
                                    saturation: imageEditorController.imageHUE,
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          colorFilter: imageEditorController
                                              .colorFilterImage,
                                          image:controller.isNoDataApi?new AssetImage(
                                            AppString.imagesAssetPath+"1.png",
                                          ): NetworkImage(
                                            controller.imageBgPath,
                                          ),
                                        ),
                                      ),

                                    ),
                                  ),
                                ),
                              )
                             : Transform(
                                alignment: Alignment.center,
                                transform: imageEditorController.imageFlip,
                                child: WidgetImageFilter(
                                  brightness: imageEditorController.imageBrightness,
                                  hue: imageEditorController.imageSaturation,
                                  saturation: imageEditorController.imageHUE,
                                  child: InteractiveViewer(
                                    boundaryMargin: EdgeInsets.all(20.0),
                                    minScale: 0.50,
                                    maxScale:4 ,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: new DecorationImage(
                                          fit: BoxFit.cover,
                                          colorFilter: imageEditorController
                                              .colorFilterImage,
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
                          },
                        )),
                    quotesTextContainer(ratioController),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget gradientColorEditContainer(RatioController ratioController) {
    return Center(
      child: AspectRatio(
        aspectRatio: ratioController.ratioX / ratioController.ratioY,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder(
            init: CommonEditorController(),
            builder: (CommonEditorController controller) {
              return RepaintBoundary(
                key: globalRepaintKey,
                child:Stack(
                  children: [
                    Material(

                        borderRadius: BorderRadius.circular(10.0),
                        elevation: 5.0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        type: MaterialType.transparency,
                        child: GetBuilder(
                          init: QuotesEditorController(),
                          builder: (QuotesEditorController quotesEditorController) {
                            return new Container(
                              child:quotesEditorController.isColorTabSelected==0?
                              new Container(
                                color: quotesEditorController.simpleColorBg,
                              )
                                  : new Container(

                                decoration: BoxDecoration(
                                  gradient: quotesEditorController.gradientColorBg,
                                ),

                              ),
                            );
                          },
                        )),
                    quotesTextContainer(ratioController),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future getImage(
      BuildContext context, CommonEditorController controller) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      controller.replaceImage(File(pickedFile.path));
      controller
          .replaceImageColorContainer(true);
    } else {

      Fluttertoast.showToast(
          msg: "No image selected.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    /*  Get.to(ImagePickerDemo(getImageCallback: (file){

    },));*/

  }

  Widget mainRatioContainer(CommonEditorController commonController) {
    return GetBuilder(
        init: RatioController(),
        builder: (RatioController ratioController) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WidgetRatioContainer(
                textRatioLabel: AppString.ratio16_9,
                heightRatio: Constant.size48,
                widthRatio: Constant.size36,
                onPressed: () {
                  if (ratioController1.ratioX != 9.0 ||
                      ratioController1.ratioY != 16.0) {
                    ratioController1.setTextMatrixPointCenter(
                        ValueNotifier(Matrix4.identity()).value);

                    commonController.updateRatioValueKey("/ratio9_16/img/","/ratio9_16/thumb/");
                    ratioController.updateRatioValue(9.0, 16.0);

                    if(commonController.isNoDataApi){
                      ratioController
                          .updateSelectedRatioContainer(0);

                      commonController.updateImageBgPath(AppString.NoApiImageNetwork);
                    }else{
                      commonController.updateBgImgRatioResponse(commonController.getBgImageResponse.data.size.ratio916);
                      commonController.updateImageBgPath(
                          commonController.getBgImageResponse.data.path+
                              commonController.ratioValueKeyThumb+
                              commonController.sizeRatioBgImage.img[0].img);
                    }



                  }

                },
              ),
              WidgetRatioContainer(
                textRatioLabel: AppString.ratio4_4,
                heightRatio: Constant.size36,
                widthRatio: Constant.size36,
                onPressed: () {
                  if (ratioController1.ratioX != 4.0 ||
                      ratioController1.ratioY != 4.0) {
                    ratioController1.setTextMatrixPointCenter(
                        ValueNotifier(Matrix4.identity()).value);
                  }
                  ratioController.updateRatioValue(4.0, 4.0);
                  ratioController.setTextPositionCenter();

                  commonController.updateRatioValueKey("/ratio4_4/img/","/ratio4_4/thumb/");


                  if(commonController.isNoDataApi){
                    ratioController
                        .updateSelectedRatioContainer(0);

                    commonController.updateImageBgPath(AppString.NoApiImageNetwork);
                  }else{
                    commonController.updateBgImgRatioResponse(commonController.getBgImageResponse.data.size.ratio44);
                    commonController.updateImageBgPath(
                        commonController.getBgImageResponse.data.path+
                            commonController.ratioValueKeyThumb+
                            commonController.sizeRatioBgImage.img[0].img);
                  }

                },
              ),
              WidgetRatioContainer(
                textRatioLabel: AppString.ratio3_2,
                heightRatio: Constant.size28,
                widthRatio: Constant.size48,
                onPressed: () {
                  if (ratioController1.ratioX != 3.0 ||
                      ratioController1.ratioY != 2.0) {
                    ratioController1.setTextMatrixPointCenter(
                        ValueNotifier(Matrix4.identity()).value);
                  }
                  ratioController.updateRatioValue(3.0, 2.0);
                  ratioController.setTextPositionCenter();

                  commonController.updateRatioValueKey("/ratio3_2/img/","/ratio3_2/thumb/");

                  // ratioController1.setTextPositionCenter();

                  if(commonController.isNoDataApi){
                    ratioController
                        .updateSelectedRatioContainer(0);

                    commonController.updateImageBgPath(AppString.NoApiImageNetwork);
                  }else{
                    commonController.updateBgImgRatioResponse(commonController.getBgImageResponse.data.size.ratio32);
                    commonController.updateImageBgPath(
                        commonController.getBgImageResponse.data.path+
                            commonController.ratioValueKeyThumb+
                            commonController.sizeRatioBgImage.img[0].img);
                  }
                },
              ),
              WidgetRatioContainer(
                textRatioLabel: AppString.ratio3_4,
                heightRatio: Constant.size32,
                widthRatio: Constant.size28,
                onPressed: () {
                  if (ratioController1.ratioX != 3.0 ||
                      ratioController1.ratioY != 4.0) {
                    ratioController1.setTextMatrixPointCenter(
                        ValueNotifier(Matrix4.identity()).value);
                  }

                  ratioController.updateRatioValue(3.0, 4.0);

                  commonController.updateRatioValueKey("/ratio3_4/img/","/ratio3_4/thumb/");
                  ratioController.setTextPositionCenter();

                  if(commonController.isNoDataApi){
                    ratioController
                        .updateSelectedRatioContainer(0);

                    commonController.updateImageBgPath(AppString.NoApiImageNetwork);
                  }else{
                    commonController.updateBgImgRatioResponse(commonController.getBgImageResponse.data.size.ratio34);
                    commonController.updateImageBgPath(
                        commonController.getBgImageResponse.data.path+
                            commonController.ratioValueKeyThumb+
                            commonController.sizeRatioBgImage.img[0].img);

                  }
                },
              ),
              WidgetRatioContainer(
                textRatioLabel: AppString.ratio4_3,
                heightRatio: Constant.size28,
                widthRatio: Constant.size32,
                onPressed: () {
                  if (ratioController1.ratioX != 4.0 ||
                      ratioController1.ratioY != 3.0) {
                    ratioController1.setTextMatrixPointCenter(
                        ValueNotifier(Matrix4.identity()).value);
                  }
                  ratioController.updateRatioValue(4.0, 3.0);

                  commonController.updateRatioValueKey("/ratio4_3/img/","/ratio4_3/thumb/");
                  ratioController.setTextPositionCenter();


                  if(commonController.isNoDataApi){
                    ratioController.updateSelectedRatioContainer(0);

                    commonController.updateImageBgPath(AppString.NoApiImageNetwork);
                  }else{
                    commonController.updateBgImgRatioResponse(commonController.getBgImageResponse.data.size.ratio43);
                    commonController.updateImageBgPath(
                        commonController.getBgImageResponse.data.path+
                            commonController.ratioValueKeyThumb+
                            commonController.sizeRatioBgImage.img[0].img);

                  }


                },
              ),
             /* WidgetRatioContainer(
                textRatioLabel: AppString.ratio16_9,
                heightRatio: Constant.size36,
                widthRatio: Constant.size48,
                onPressed: () {
                  if (ratioController1.ratioX != 16.0 ||
                      ratioController1.ratioY != 9.0) {
                    ratioController1.setTextMatrixPointCenter(
                        ValueNotifier(Matrix4.identity()).value);
                  }

                  ratioController.updateRatioValue(16.0, 9.0);
                  ratioController.setTextPositionCenter();
                },
              ),*/
            ],
          );
        });
  }

  Widget mainTextContainer() {
    return GetBuilder(
        init: TextEditorController(),
        builder: (TextEditorController textEditorController) {
          return Container(margin: EdgeInsets.only(left: 4.0,right:4.0),
            child: Column(
              children: [
                Container(margin: EdgeInsets.only(top: 15.0,),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(margin: EdgeInsets.only( left: 4.0),
                        child:   new Row(
                          children: [
                            WidgetTextController(
                              icons: Icons.title,
                              isIcon: true,
                              onPressed: () {
                                textEditorController
                                    .updateTextAlign(TextAlign.center);
                                textEditorController
                                    .updateTextFontItalic(FontStyle.italic);
                                textEditorController
                                    .updateTextFontWeight(FontWeight.bold);
                                textEditorController.updateTextUnderline(
                                    TextDecoration.underline);
                                textEditorController.changeCommonTextStyle(
                                    textEditorController);
                              },
                            ),
                            WidgetTextController(
                              icons: Icons.format_bold,
                              isIcon: true,
                              onPressed: () {
                                textEditorController.updateTextFontWeight(
                                    textEditorController.textFontWeight);
                                textEditorController.changeCommonTextStyle(
                                    textEditorController);
                              },
                            ),
                            WidgetTextController(
                              icons: Icons.format_italic,
                              isIcon: true,
                              onPressed: () {
                                textEditorController.updateTextFontItalic(
                                    textEditorController.textFontStyle);
                                textEditorController.changeCommonTextStyle(
                                    textEditorController);
                              },
                            ),
                            WidgetTextController(
                              icons: Icons.format_underline,
                              isIcon: true,
                              onPressed: () {
                                textEditorController.updateTextUnderline(
                                    textEditorController.textDecoration);
                                textEditorController.changeCommonTextStyle(
                                    textEditorController);
                              },
                            ),
                          ],
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 4.0),
                        child:  new Row(
                          children: [
                            WidgetTextController(
                              isIcon: false,
                              iconPathString: AppString.iconImagesPath +
                                  'ic_text_size_dec.png',
                              onPressed: () {
                                textEditorController.updateTextSize(
                                    textEditorController.textSize, false);
                                textEditorController.changeCommonTextStyle(
                                    textEditorController);
                              },
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            WidgetTextController(
                              isIcon: false,
                              iconPathString: AppString.iconImagesPath +
                                  'ic_text_size_inc.png',
                              onPressed: () {
                                textEditorController.updateTextSize(
                                    textEditorController.textSize, true);
                                textEditorController.changeCommonTextStyle(
                                    textEditorController);
                              },
                            ),
                          ],
                        )
                      ),

                      Container(
                        margin: EdgeInsets.only( left: 4.0),
                        child:   new Row(
                          children: [
                            WidgetTextController(
                              isIcon: true,
                              icons: Icons.format_align_left,
                              onPressed: () {
                                textEditorController
                                    .updateTextAlign(TextAlign.left);
                              },
                            ),
                            WidgetTextController(
                              isIcon: true,
                              icons: Icons.format_align_center,
                              onPressed: () {
                                textEditorController
                                    .updateTextAlign(TextAlign.center);
                              },
                            ),
                            WidgetTextController(
                              isIcon: true,
                              icons: Icons.format_align_right,
                              onPressed: () {
                                textEditorController
                                    .updateTextAlign(TextAlign.right);
                              },
                            ),
                            WidgetTextController(
                              isIcon: true,
                              icons: Icons.format_align_justify,
                              onPressed: () {
                                textEditorController
                                    .updateTextAlign(TextAlign.justify);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 15.0,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only( left: 8.0),
                        child: new Column(
                          children: [

                            new Row(
                              children: [
                                WidgetTextController(
                                  iconPathString: AppString.iconImagesPath +
                                      'ic_line_space_dec.png',
                                  isIcon: false,
                                  onPressed: () {
                                    textEditorController.updateLineSpacingValue(
                                        textEditorController.textLineSpacing,
                                        false);
                                    textEditorController.changeCommonTextStyle(
                                        textEditorController);
                                  },
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                WidgetTextController(
                                  iconPathString: AppString.iconImagesPath +
                                      'ic_line_space_inc.png',
                                  isIcon: false,
                                  onPressed: () {
                                    textEditorController.updateLineSpacingValue(
                                        textEditorController.textLineSpacing, true);
                                    textEditorController.changeCommonTextStyle(
                                        textEditorController);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 1.0, left: 4.0),
                        child: new Column(
                          children: [

                            new Row(
                              children: [
                                WidgetTextController(
                                  isIcon: false,
                                  iconPathString: AppString.iconImagesPath +
                                      'ic_latter_space_dec.png',
                                  onPressed: () {
                                    textEditorController.updateLetterSpacingValue(
                                        textEditorController.textLetterSpacing,
                                        false);
                                    textEditorController.changeCommonTextStyle(
                                        textEditorController);
                                  },
                                ),

                                WidgetTextController(
                                  isIcon: false,
                                  iconPathString: AppString.iconImagesPath +
                                      'ic_latter_space_inc.png',
                                  onPressed: () {
                                    textEditorController.updateLetterSpacingValue(
                                        textEditorController.textLetterSpacing,
                                        true);
                                    textEditorController.changeCommonTextStyle(
                                        textEditorController);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex:1,
                        child: Container(

                          margin: EdgeInsets.only(left: 28.0),
                          child: new Row(
                            children: [
                              WidgetTextController(
                                icons: Icons.rotate_right,
                                isIcon: true,
                                onPressed: () {},
                              ),
                              Expanded(
                                flex: 1,
                                child: WidgetTextRotateSliderContainer(
                                    valueSize: textEditorController.rotateValue,
                                    onChangeValueSize: (val) {
                                      textEditorController.updateRotateValue(val);
                                    }),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget mainImageContainer() {

    return GetBuilder(
        init: ImageEditorController(),
        builder: (ImageEditorController imageEditorController) {
          //print("imageEditorController>> "+imageEditorController.isFilterImgDisplay.toString());
         /* if(commonController.isShowImage){
            imageEditorController.checkImgFilterDispay(true);
          }else
            {
              imageEditorController.checkImgFilterDispay(false);
            }*/
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                padding: EdgeInsets.all(4.0),
                margin: EdgeInsets.only(top: 8.0, left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WidgetTextController(
                      icons: Icons.flip,
                      isIcon: true,
                      onPressed: () {
                        imageEditorController.updateImageFlip(imageEditorController.imageFlip);
                        imageEditorController.checkImgFilterDispay(false);
                      },
                    ),
                    WidgetTextController(
                      icons:Icons.filter,
                      isIcon: true,
                      onPressed: () {
                        imageEditorController.checkImgFilterDispay(true);


                      },
                    ),


                    WidgetTextController(
                      icons:Icons.wb_sunny,
                      isIcon: true,
                      onPressed: () {
                        imageEditorController.imageSliderTypeChange(AppString.txtBrightness);
                        imageEditorController.checkImgFilterDispay(false);
                      },
                    ),
                    WidgetTextController(
                      icons: Icons.adjust,
                      isIcon: true,
                      onPressed: () {
                        imageEditorController.imageSliderTypeChange(AppString.txtSaturation);
                        imageEditorController.checkImgFilterDispay(false);

                      },
                    ),
                    WidgetTextController(
                      icons: Icons.card_giftcard,
                      isIcon: true,
                      onPressed: () {
                        imageEditorController.imageSliderTypeChange(AppString.txtHUE);
                        imageEditorController.checkImgFilterDispay(false);

                      },
                    ),


                    WidgetTextController(
                      icons:Icons.undo,
                      isIcon: true,
                      onPressed: () {
                        imageEditorController.imageSliderTypeChange(AppString.txtBrightness);
                        imageEditorController.updateBrightnessChange(0.0);
                        imageEditorController.updatSaturationChange(0.0);
                        imageEditorController.updateHueChange(0.0);
                        imageEditorController.setImageFilter(ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.darken));

                      },
                    ),


                  ],
                ),
              ),

              imageEditorController.isFilterImgDisplay==true?new Container(

              ):

              Container(
                margin:EdgeInsets.only(top: Constant.size8,bottom: Constant.size2),
                  child: new Text(imageEditorController.imageSliderType,
                    style: TextStyle(color: AppColors.white,fontSize: FontSize.s18),
                  )
              ),

              imageEditorController.isFilterImgDisplay==true?

              WidgetImageFilterController(
                onImageFilterChange: (val) {
                  imageEditorController.setImageFilter(val);
                },
              ) :
              WidgetBrightnessSliderContainer(
                valueSize: imageEditorController.imageSliderType==AppString.txtBrightness?
                imageEditorController.imageBrightness:
                imageEditorController.imageSliderType==AppString.txtSaturation?
                imageEditorController.imageSaturation: imageEditorController.imageHUE,

                imageTypeSlider: imageEditorController.imageSliderType,

                  onChangeValueSize: (val) {
                    if(imageEditorController.imageSliderType==AppString.txtBrightness){
                      imageEditorController.updateBrightnessChange(val);
                    }else if(imageEditorController.imageSliderType==AppString.txtSaturation){
                      imageEditorController.updatSaturationChange(val);
                    }else if(imageEditorController.imageSliderType==AppString.txtHUE){
                      imageEditorController.updateHueChange(val);
                    }
                  },)

            ],
          );
        });
  }


  Widget quotesTextContainer(RatioController ratioController) {
    return Container(
      child: MatrixGestureDetector(
        onMatrixUpdate: (m, tm, sm, rm) {
          ratioController.setTextMatrixPointCenter(m);
        },
        child: AnimatedBuilder(
          animation: ratioController.notifier,
          builder: (ctx, child) {
            return Transform(
              transform: ratioController.notifier.value,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                        //decoration: FlutterLogoDecoration(),
                        padding: EdgeInsets.all(32),
                        alignment: Alignment(0, -0.5),
                        child: GetBuilder(
                          init: TextEditorController(),
                          builder: (TextEditorController textEditorController) {
                            return Transform.rotate(
                              angle: textEditorController.rotateValue,
                              child: Align(
                                alignment: ratioController.alignmentGeometry,
                                child: InkWell(
                                  onDoubleTap: (){
                                    Get.to(() =>QuotesAddScreenUI(textEditorController.quoteText));
                                  },
                                  child: Container(
                                    child: AutoSizeText(
                                      textEditorController.quoteText,
                                      maxLines:16,
                                      textAlign: textEditorController.textAlign,
                                      style: textEditorController.textStyleFont,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _captureAndSharePng() async {
    try {

      RenderRepaintBoundary boundary = globalRepaintKey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 2.0);

      var pictureRecorder = ui.PictureRecorder();
      var canvas = Canvas(pictureRecorder, Rect.fromLTWH(0,0, image.width.toDouble(), image.height.toDouble()));
      var paint = Paint();
      paint.isAntiAlias = true;
      var src = Rect.fromLTWH(
          0.0, 0.0, image.width.toDouble(), image.height.toDouble());
      var dst =
      Rect.fromLTWH(0.0, 0.0, image.width.toDouble(), image.height.toDouble());
      canvas.drawImageRect(image,src,dst,paint);


      ByteData bd = await rootBundle.load("assets/images/logo1.png");
      final Uint8List bytes = Uint8List.view(bd.buffer);
      final ui.Codec codec = await ui.instantiateImageCodec(bytes, targetHeight: 80, targetWidth: 80);
      ui.Image imageWateremark = (await codec.getNextFrame()).image;
      canvas.drawImage(imageWateremark, Offset(image.width.toDouble()-(imageWateremark.width.toDouble()+18),
          image.height.toDouble()-(imageWateremark.height.toDouble()+18)), Paint());
      var pic = pictureRecorder.endRecording();

      var imageFinal = await pic.toImage(image.width, image.height);

      Future.delayed(new Duration(milliseconds: 1),() async {
        ByteData byteData = await imageFinal.toByteData(format: ImageByteFormat.png);
        Uint8List pngBytes = byteData.buffer.asUint8List();
       /* final tempDir = await getTemporaryDirectory();
        print("tmpDir: " + tempDir.toString());
        final file = await new File('${tempDir.path}/image.png').create();
        print("tmpDir1: " + file.toString());
        await file.writeAsBytes(pngBytes);*/

        Get.to(() =>DownloadImageScreenUI(pngBytes));
      });

      //ShareExtend.share(tempDir.path + "/image.png", "image");
      //FlutterShareFile.shareImage(tempDir.path, 'image.png');

    } catch (e) {
      print(e.toString());
    }
  }


  showExitFromEditor(CommonEditorController commonController,RatioController ratioController){
    AwesomeDialog(
        context: context,
       dialogType: DialogType.QUESTION,
        animType: AnimType.BOTTOMSLIDE,
        headerAnimationLoop: true,
        title: 'Exit',
        desc:
        'Are you sure you want to Exit from Editor ?',
        btnOkOnPress: () {
          commonController
              .replaceImageColorContainer(true);
          commonController
              .updateSelectedBottomContainer(0);
          commonController.updateRatioValueKey("/ratio9_16/img/","/ratio9_16/thumb/");
          commonController.showSubEditContainer(
              false, );

          if(commonController.isNoDataApi){
            ratioController
                .updateSelectedRatioContainer(0);
            ratioController.updateRatioValue(9.0, 16.0);

            commonController.updateImageBgPath(AppString.NoApiImageNetwork);
          }else{
            commonController.updateBgImgRatioResponse(commonController.getBgImageResponse.data.size.ratio916);
            commonController.updateImageBgPath(
                commonController.getBgImageResponse.data.path+
                    commonController.ratioValueKeyThumb+
                    commonController.sizeRatioBgImage.img[0].img);
          }

         Navigator.of(context).pop();

//s
        },
        btnOkColor: Colors.red,
        btnCancelColor: Colors.green,
        btnCancelOnPress:(){
        })
      ..show();
  }



  checkInternetConnection()async {
    var notConnection = await (Connectivity().checkConnectivity());
    if (notConnection == ConnectivityResult.none) {
      _showDialog();
    }
  }

  _showDialog() {
    return showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(AppString.msg_noInternetTitle),
            content: Text(AppString.msg_InternetConnection),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  checkInternetConnection();
                  Navigator.of(context).pop();
                },
                child: Text("Dismiss"),
              ),
            ],
          );
        });
  }
}
