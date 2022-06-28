import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thoughts_creator/controller/CommonEditorController.dart';
import 'package:thoughts_creator/controller/RatioController.dart';
import 'package:thoughts_creator/controller/SavedCollectionController.dart';
import 'package:thoughts_creator/editcontroller/ratioWidgetSelectContainer/WidgetRatioSelectController.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/AppCommonFunc.dart';
import 'package:thoughts_creator/utils/AppString.dart';
import 'package:thoughts_creator/utils/screen_util.dart';
import 'EditorScreenUI.dart';



class SelectRatioScreenUI extends StatefulWidget {


  @override
  _SelectRatioScreenUIState createState() => _SelectRatioScreenUIState();
}

class _SelectRatioScreenUIState extends State<SelectRatioScreenUI> {
  SavedCollectionController savedCollectionController =
  Get.put(SavedCollectionController());
  @override
  void initState() {
    // TODO: implement initState
    savedCollectionController.selectedList.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body:
      new Container(
        decoration: BoxDecoration(

            image:  DecorationImage(
              image: AssetImage("assets/images/back.jpg"),
                fit: BoxFit.cover,
            )),
          child:GetBuilder(
          init: CommonEditorController(),
          builder: (CommonEditorController commonController){
            return  new Column(
              children: [
                Expanded(
                  flex:1,
                  child: new Column(
                    children: [

                      Container(
                        margin:EdgeInsets.only(left:Constant.size20,right:Constant.size20,top:Constant.size15),
                        child: new Text("Click on any Social Media icon from below for which you want to create customize image post.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.white,fontSize: FontSize.s16,),
                        ),

                      ),

                      Expanded(
                        flex:1,
                        child: GetBuilder(
                            init: RatioController(),
                            builder: (RatioController ratioController,) {
                              return ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        //9:16
                                        Expanded(
                                          flex:1,
                                          child: WidgetRatioSelectController(
                                              arrayPos: 0,
                                              containerHeight: 210,
                                              containerWidth:115,
                                              containerBgColor: AppColors.primaryColor,
                                              iconColor: AppColors.white,
                                              ratioText: "9:16",
                                              imagePath:AppString.iconImagesPath+"ic_whatsapp.png",
                                              onPressed: () {
                                                ratioController
                                                    .updateSelectedRatioContainer(0);
                                                ratioController.updateRatioValue(9.0, 16.0);
                                                ratioController.setTextMatrixPointCenter(
                                                    ValueNotifier(Matrix4.identity())
                                                        .value);


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
                                                commonController.replaceImage(null);
                                                commonController.updateRatioValueKey("/ratio9_16/img/","/ratio9_16/thumb/");

                                                Get.to(() =>EditorScreenUI());

                                              }),
                                        ),
                                        //4:4
                                        Expanded(
                                          flex:1,
                                          child: Container(
                                            margin:EdgeInsets.only(top:Constant.size20),
                                            child: WidgetRatioSelectController(
                                                arrayPos: 1,
                                                containerHeight: 100,
                                                containerWidth: 95,
                                                imagePath:AppString.iconImagesPath+"ic_instagram.png",
                                                gradientColor: AppColors.instaBGGradiant,
                                                iconColor: AppColors.white,
                                                ratioText: "1:1",
                                                onPressed: () {
                                                  commonController.replaceImage(null);
                                                  ratioController
                                                      .updateSelectedRatioContainer(1);
                                                  ratioController.updateRatioValue(4.0, 4.0);
                                                  ratioController.setTextMatrixPointCenter(
                                                      ValueNotifier(Matrix4.identity())
                                                          .value);
                                                  commonController.updateRatioValueKey("/ratio4_4/img/","/ratio4_4/thumb/");

                                                  if(commonController.isNoDataApi){
                                                    ratioController
                                                        .updateSelectedRatioContainer(0);
                                                    ratioController.updateRatioValue(4.0, 4.0);
                                                    commonController.updateImageBgPath(AppString.NoApiImageNetwork);
                                                  }else{
                                                    commonController.updateBgImgRatioResponse(commonController.getBgImageResponse.data.size.ratio44);
                                                    commonController.updateImageBgPath(
                                                        commonController.getBgImageResponse.data.path+
                                                            commonController.ratioValueKeyThumb+
                                                            commonController.sizeRatioBgImage.img[0].img);
                                                  }







                                                  Get.to(() =>EditorScreenUI());
                                                }),
                                          ),
                                        ),
                                        //3:4
                                        Expanded(
                                          flex:1,
                                          child: Container(
                                            margin:EdgeInsets.only(top:Constant.size20),
                                            child: WidgetRatioSelectController(
                                                arrayPos: 2,
                                                containerHeight: 170,
                                                containerWidth: 100,
                                                containerBgColor: AppColors.twitterBGColor,
                                                iconColor: AppColors.white,
                                                ratioText: "3:4",
                                                imagePath:AppString.iconImagesPath+"ic_twitter.png",
                                                onPressed: () {
                                                  ratioController
                                                      .updateSelectedRatioContainer(2);
                                                  ratioController.updateRatioValue(3.0, 4.0);
                                                  ratioController.setTextMatrixPointCenter(
                                                      ValueNotifier(Matrix4.identity())
                                                          .value);
                                                  commonController.replaceImage(null);

                                                  commonController.updateRatioValueKey("/ratio3_4/img/","/ratio3_4/thumb/");


                                                  if(commonController.isNoDataApi){
                                                    ratioController
                                                        .updateSelectedRatioContainer(0);
                                                    ratioController.updateRatioValue(3.0, 4.0);
                                                    commonController.updateImageBgPath(AppString.NoApiImageNetwork);
                                                  }else{
                                                    commonController.updateBgImgRatioResponse(commonController.getBgImageResponse.data.size.ratio34);
                                                    commonController.updateImageBgPath(
                                                        commonController.getBgImageResponse.data.path+
                                                            commonController.ratioValueKeyThumb+
                                                            commonController.sizeRatioBgImage.img[0].img);
                                                  }



                                                  Get.to(() =>EditorScreenUI());
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding:  EdgeInsets.all(8.0),
                                    margin:EdgeInsets.only(top:Constant.size15),
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        //3:2
                                        Expanded(
                                          flex:1,
                                          child: WidgetRatioSelectController(
                                              arrayPos: 3,
                                              containerHeight: 120,
                                              containerWidth: 180,
                                              imagePath:AppString.iconImagesPath+"ic_facebook.png",
                                              containerBgColor: AppColors.facebookBGColor,
                                              iconColor: AppColors.white,
                                              ratioText: "3:2",

                                              onPressed: () {
                                                ratioController.updateSelectedRatioContainer(3);
                                                ratioController.updateRatioValue(3.0, 2.0);
                                                ratioController.setTextMatrixPointCenter(
                                                    ValueNotifier(Matrix4.identity()).value);
                                                commonController.replaceImage(null);

                                                commonController.updateRatioValueKey("/ratio3_2/img/","/ratio3_2/thumb/");



                                                if(commonController.isNoDataApi){
                                                  ratioController
                                                      .updateSelectedRatioContainer(0);
                                                  ratioController.updateRatioValue(3.0, 2.0);
                                                  commonController.updateImageBgPath(AppString.NoApiImageNetwork);
                                                }else{
                                                  commonController.updateBgImgRatioResponse(commonController.getBgImageResponse.data.size.ratio32);
                                                  commonController.updateImageBgPath(
                                                      commonController.getBgImageResponse.data.path+
                                                          commonController.ratioValueKeyThumb+
                                                          commonController.sizeRatioBgImage.img[0].img);
                                                }


                                                Get.to(() =>EditorScreenUI());
                                              }),
                                        ),
                                        //4:3
                                        Expanded(
                                          flex:1,
                                          child: WidgetRatioSelectController(
                                              arrayPos: 5,
                                              containerHeight: 110,
                                              containerWidth: 160,
                                              imagePath:AppString.iconImagesPath+"ic_snapchat.png",
                                              containerBgColor: AppColors.snapChatBGColor,
                                              iconColor: AppColors.black,
                                              ratioText: "4:3",
                                              onPressed: () {




                                                ratioController
                                                    .updateSelectedRatioContainer(5);
                                                ratioController.updateRatioValue(4.0, 3.0);
                                                ratioController.setTextMatrixPointCenter(
                                                    ValueNotifier(Matrix4.identity())
                                                        .value);
                                                commonController.replaceImage(null);

                                                commonController.updateRatioValueKey("/ratio4_3/img/","/ratio4_3/thumb/");


                                                if(commonController.isNoDataApi){
                                                  ratioController
                                                      .updateSelectedRatioContainer(0);
                                                  ratioController.updateRatioValue(4.0, 3.0);
                                                  commonController.updateImageBgPath(AppString.NoApiImageNetwork);
                                                }else{
                                                  commonController.updateBgImgRatioResponse(commonController.getBgImageResponse.data.size.ratio43);
                                                  commonController.updateImageBgPath(
                                                      commonController.getBgImageResponse.data.path+
                                                          commonController.ratioValueKeyThumb+
                                                          commonController.sizeRatioBgImage.img[0].img);



                                                }

                                                Get.to(() =>EditorScreenUI());

                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:EdgeInsets.only(left:Constant.size15,right: Constant.size15,top:Constant.size28),
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

/*
                                        WidgetButtonContainer(
                                          isIcon: true,
                                          imageName:AppString.iconImagesPath+"ic_saved_collection.png",
                                          textLabel: "Saved Collections",
                                          buttonHeight: Constant.size36,
                                          buttonWidth: MediaQuery.of(context).size.width/2.5,
                                          textSize: FontSize.s12,
                                          onPressed: () {
                                            Get.to(SavedCollectionScreenUI());
                                          },
                                        ),*/
                                      ],
                                    ),
                                  ),

                                ],
                              );
                            }),
                      ),

                    ],
                  ),
                ),

                Container(
                  child:AppCommonFunc.admobBannerAd(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }


}
