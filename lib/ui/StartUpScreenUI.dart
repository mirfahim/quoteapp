
import 'dart:async';
//import 'package:admob_flutter/admob_flutter.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:thoughts_creator/Helper/PreferenceHelper.dart';
import 'package:thoughts_creator/controller/BackgroundImgController.dart';
import 'package:thoughts_creator/editcontroller/WidgetButtonContainer.dart';
import 'package:thoughts_creator/ui/MainScreen.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/AppCommonFunc.dart';
import 'package:thoughts_creator/utils/AppString.dart';
import 'package:thoughts_creator/utils/screen_util.dart';

import '../main.dart';
class StartUpScreenUI extends StatefulWidget {
  @override
  _StartUpScreenUIState createState() => _StartUpScreenUIState();
}


class _StartUpScreenUIState extends State<StartUpScreenUI> {

  final BackgroundImgController bgImgController = Get.put(BackgroundImgController());
  PreferenceHelper preferenceHelper;
  SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetConnection();


  }


  Future<void> getSharedPreferenceObject() async {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      prefs = sp;
      preferenceHelper = new PreferenceHelper(prefs);
      // checkInternetConnection();

      bgImgController.apiLogin();

    });
  }

  checkInternetConnection()async {
    var notConnection = await (Connectivity().checkConnectivity());
    if (notConnection == ConnectivityResult.none) {
      _showDialog();
    } else {
      getSharedPreferenceObject();
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




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.backgroundColor,

          body: Container(

            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,

            child: Center(
                child: Column(
              children: [

                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: MediaQuery.of(context).size.height/2.2,
                //  // color: AppColors.primaryColor,
                //   child:  AdmobBanner(
                //       adUnitId: getBannerAdUnitId(),
                //       adSize:AdmobBannerSize.MEDIUM_RECTANGLE,
                //       listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                //         handleEvent(event, args, 'Banner');
                //       },
                //     )
                // ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  Container(
                    margin: EdgeInsets.only(top:Constant.size10),
                    child: WidgetButtonContainer(
                      isIcon: false,
                      textLabel: "START",
                      buttonHeight: Constant.size50,
                      buttonWidth: MediaQuery.of(context).size.width/2.8,
                      textSize: FontSize.s16,
                      onPressed: () {
                       // getSocket();
                         Get.to(() => MainScreenUI(false,false));
                      },
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left:Constant.size120,right:Constant.size110,top:Constant.size20),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap:(){
                            AppCommonFunc.share();
                          },
                          child: Icon(FontAwesomeIcons.shareSquare,color: AppColors.primaryColor,size: Constant.size40,)),
                      InkWell(
                          onTap:(){
                            StoreRedirect.redirect(
                                androidAppId: AppString.appId,
                                iOSAppId: '');
                          },
                          child: Icon(FontAwesomeIcons.googlePlay,color: AppColors.primaryColor,size: Constant.size40,)),
                    ],
                  ),
                ),

               Container(
                 margin: EdgeInsets.only(top:Constant.size20),
                 child: new Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Container(
                       margin: EdgeInsets.only(left:Constant.size10,right: Constant.size20),
                       color: AppColors.textDisableColor,
                       height: 1,
                       width:50.0,
                     ),
                     Container(child: new Text("Our Social Media",style: GoogleFonts.saira(fontSize: 16.0,color: AppColors.textDisableColor),)),
                     Container(
                       margin: EdgeInsets.only(left:Constant.size20,right: Constant.size10),
                       color: AppColors.textDisableColor,
                       height: 1,
                       width:50.0,
                     ),
                   ],
                 ),
               ),
                Container(
                  margin: EdgeInsets.only(left:Constant.size72,right:Constant.size72,top:Constant.size20),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap:(){
                            AppCommonFunc.launchSocialUrl(AppString.socialFbRain);
                          },
                          child: Icon(FontAwesomeIcons.facebookSquare,color: AppColors.primaryColor,size: Constant.size40,)),
                      InkWell(
                          onTap:(){
                            AppCommonFunc.launchSocialUrl(AppString.socialLinkedinRain);
                          },
                          child: Icon(FontAwesomeIcons.linkedin,color: AppColors.primaryColor,size: Constant.size40,)),
                      InkWell(
                          onTap: (){
                            AppCommonFunc.launchSocialUrl(AppString.socialTwitterRain);
                          },
                          child: Icon(FontAwesomeIcons.twitter,color: AppColors.primaryColor,size: Constant.size40,)),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left:Constant.size72,right:Constant.size72,top:Constant.size40),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap:(){
                            AppCommonFunc.launchSocialUrl(AppString.socialWebsiteRain);
                          },
                          child: Icon(FontAwesomeIcons.globeAfrica,color: AppColors.primaryColor,size: Constant.size40,)),
                      InkWell(
                          onTap: (){
                            AppCommonFunc.launchSocialUrl(AppString.socialWhatsappRain);
                          },
                          child: Icon(FontAwesomeIcons.whatsapp,color: AppColors.primaryColor,size: Constant.size40,)),
                      InkWell(
                          onTap:(){
                            AppCommonFunc.launchSocialUrl(AppString.socialInstaRain);
                          },
                          child: Icon(FontAwesomeIcons.instagram,color: AppColors.primaryColor,size: Constant.size40,)),
                    ],
                  ),
                ),
              ],
            )),
          )
      ),
    );
  }




  @override
  void dispose() {

    super.dispose();
  }


}
