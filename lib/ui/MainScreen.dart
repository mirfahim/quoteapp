import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thoughts_creator/Helper/PreferenceHelper.dart';
import 'package:thoughts_creator/controller/CommonEditorController.dart';

import 'package:thoughts_creator/controller/SavedCollectionController.dart';

import 'package:thoughts_creator/ui/SelectRatioScreenUI.dart';

import 'package:thoughts_creator/ui/SavedCollectionScreenUI.dart';
import 'package:thoughts_creator/ui/PopularScreenUI.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/AppCommonFunc.dart';
import 'package:thoughts_creator/utils/AppString.dart';
import 'package:thoughts_creator/utils/screen_util.dart';



class MainScreenUI extends StatefulWidget {

   final bool isEditor;
   final bool isNoData;

  MainScreenUI(this.isEditor,this.isNoData);

  @override
  _MainScreenUIState createState() => _MainScreenUIState();
}

class _MainScreenUIState extends State<MainScreenUI> {
  PreferenceHelper preferenceHelper;
  SharedPreferences prefs;
   final commonController = Get.put(CommonEditorController());

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String title="Thoughts Of the Day";
  PageController pageController;
   String version="1.0.1";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // AppCommonFunc.adInterstitialAdshow();

    pageController=  PageController(
        initialPage: widget.isEditor ? 2 : commonController.selectedPageViewIndex,
        keepPage: true,
    );

    getSharedPreferenceObject();



  }
   Future<void> getSharedPreferenceObject() async {
     SharedPreferences.getInstance().then((SharedPreferences sp) {
       prefs = sp;
       preferenceHelper = new PreferenceHelper(prefs);
       // checkInternetConnection();

       if(widget.isEditor){
         pageChanged(2, commonController);
       }

       Future.delayed(new Duration(seconds:1),() async {

         if(commonController.isNoDataApi){
           print("mainif"+commonController.isNoDataApi.toString());
           commonController.updateBgImgRatioResponse(commonController.sizeRatioBgImage);
         }else{
           print("mainelse"+commonController.isNoDataApi.toString());
           commonController.updateBgImgRatioResponse(commonController.getBgImageResponse.data.size.ratio916);
         }

         commonController
             .replaceImageColorContainer(true);
         commonController
             .updateSelectedBottomContainer(0);
         packgeInfoData(commonController);

       });

     });
   }
   packgeInfoData(CommonEditorController commonEditorController){
     PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
       version = packageInfo.version;

       commonController.updateAppVersion(version);

     });
   }

   @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showExitFromEditor();
        return;
      },
      child: SafeArea(
          child: GetBuilder(
            init: CommonEditorController(),
            builder: (CommonEditorController commonEditorController,){
              return  Scaffold(
                key: _scaffoldKey,
                backgroundColor: AppColors.backgroundColor,
                drawer:  AppCommonFunc.appDrawer(context,_scaffoldKey,commonEditorController),
                appBar:  new AppBar(
                  centerTitle: true,
                  leading: InkWell(
                    onTap: () {
                      // Navigator.pop(context);
                      //Get.to(  SettingScreenUI());

                      _scaffoldKey.currentState.openDrawer();


                    },
                    child: new Container(
                      child: new Icon(
                        Icons.menu,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  title: new Text(
                    commonEditorController.appBarTitle,
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                  backgroundColor: AppColors.backgroundColor,

                  actions: [
                    GetBuilder(
                      init: SavedCollectionController(),
                      builder: (SavedCollectionController controller) {
                        return Container(
                          child:  controller.selectedList.length > 0 ? Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Row(
                                children: <Widget>[

                                  InkWell(
                                    onTap: (){
                                      if(!controller.isAllSelect){
                                        controller.selectedList.clear();
                                        for (int i = 0; i < controller.imgFiles.length; i++) {
                                          controller.imgFiles[i].isSelect=true;
                                          controller.selectedList.add(controller.imgFiles[i]);

                                        }
                                        controller.updateIsSelectDeselectAll(true);
                                      }else{
                                        for (int i = 0; i < controller.imgFiles.length; i++) {
                                          controller.imgFiles[i].isSelect=false;
                                          controller.selectedList.remove(controller.imgFiles[i]);
                                        }
                                        controller.updateIsSelectDeselectAll(false);
                                      }


                                    },
                                    child: Container(
                                        child: Icon(Icons.select_all)),
                                  ),

                                  SizedBox(width: 8.0,),

                                  InkWell(
                                    onTap: (){

                                      AwesomeDialog(
                                          context: context,

                                          dialogType: DialogType.QUESTION,
                                          animType: AnimType.BOTTOMSLIDE,
                                          headerAnimationLoop: true,
                                          title: 'Delete',
                                          desc:
                                          'Are you want to sure delete images ?',
                                          btnOkOnPress: () {
                                            for (int j = 0; j < controller.selectedList.length; j++) {
                                              for (int i = 0; i < controller.imgFiles.length; i++) {
                                                if(controller.imgFiles[i].fileSystemEntity==controller.selectedList[j].fileSystemEntity){
                                                  controller.imgFiles.remove(controller.selectedList[j]);
                                                  controller.selectedList[j].fileSystemEntity.deleteSync();
                                                }
                                              }

                                            }
                                            if(controller.selectedList.length>0){
                                              controller.selectedList.clear();
                                            }
                                            controller.updateMainImgFiles(controller.imgFiles);
                                            controller.updateSelectedFiles(controller.selectedList);

                                          },
                                          btnOkColor: Colors.red,
                                          btnCancelColor: Colors.green,
                                          btnCancelOnPress:(){
                                          })
                                        ..show();


                                    },
                                    child: Container(
                                        child: Icon(Icons.delete)),
                                  ),

                                ],
                              ),
                            ),
                          ) : new Container(),
                        );
                      },
                    )
                  ],
                ),
                body:  buildPageView(commonEditorController),
                bottomNavigationBar: BottomNavigationBar(
                    items:  <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home,color: AppColors.white,),
                          activeIcon: Icon(Icons.home,color: AppColors.primaryColor,),
                          label: 'Home',
                          backgroundColor: AppColors.black
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.collections,color: AppColors.white,),
                          activeIcon: Icon(Icons.collections,color: AppColors.primaryColor,),

                          label: 'Popular',
                          backgroundColor: AppColors.black
                      ),
                      BottomNavigationBarItem(

                        icon: Image.asset(
                          AppString.iconImagesPath + "ic_saved_collection.png",
                          height: Constant.size20,
                          width: Constant.size20,
                          color: AppColors.white,
                        ),
                        activeIcon:  Image.asset(
                          AppString.iconImagesPath + "ic_saved_collection.png",
                          height: Constant.size20,
                          width: Constant.size20,
                          color: AppColors.primaryColor,
                        ),
                        label: 'Saved',
                        backgroundColor: AppColors.black,
                      ),
                    ],
                    type: BottomNavigationBarType.shifting,
                    backgroundColor: AppColors.backgroundColor,

                    currentIndex: commonEditorController.selectedBottomMainIndex,
                    selectedItemColor: AppColors.primaryColor,
                    iconSize: 24,
                    onTap: (index){
                      _onItemTapped(index,commonEditorController);
                    },
                    elevation: 5
                ),
              );
            }
          )
      ),
    );
  }

  Widget buildPageView(CommonEditorController commonEditorController) {
    return PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),

      onPageChanged: (index) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        pageChanged(index,commonEditorController);
      },
      children: <Widget>[
        SelectRatioScreenUI(),
        PopularScreenUI(),
        SavedCollectionScreenUI(),

      ],
    );
  }

  void pageChanged(int index,CommonEditorController commonEditorController) {
    print("pageviewindex===="+index.toString());

    commonEditorController.updateBottomMainIndex(index);
    commonEditorController.updatePageViewIndex(index);
    changeTitle(index, commonEditorController);


  }
  void _onItemTapped(int index,CommonEditorController commonEditorController) {
    print("Bottomindex===="+index.toString());
    commonEditorController.updateBottomMainIndex(index);
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.ease);

  }

  Future<void> changeTitle(int index,CommonEditorController commonEditorController)  async {
    switch (index) {
      case 0:
        title = "Thoughts Of the Day";
        break;
      case 1:
        title = "Popular Collection";
        break;
      case 2:
        title = "Saved Collection";
        break;

    }
    commonEditorController.appBarTitle=title;
  }

   showExitFromEditor(){
     AwesomeDialog(
         context: context,
         dialogType: DialogType.QUESTION,
         animType: AnimType.BOTTOMSLIDE,
         headerAnimationLoop: true,
         title: 'Exit',
         desc: 'Are you sure you want to Exit from Editor ?',
         btnOkOnPress: () {
           SystemNavigator.pop();


         },
         btnOkColor: Colors.red,
         btnCancelColor: Colors.green,
         btnCancelOnPress:(){}
         )
       ..show();
   }


}
