import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
//import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:thoughts_creator/Helper/PreferenceHelper.dart';
import 'package:thoughts_creator/controller/CommonEditorController.dart';
import 'package:thoughts_creator/utils/screen_util.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import 'AppColors.dart';
import 'AppString.dart';

class AppCommonFunc {

// static AdmobInterstitial interstitialAd1;
 //static InterstitialAd interstitialAd;
  static PreferenceHelper preferenceHelper;
  static SharedPreferences prefs;
  static NativeAdmobController _nativeAdController = NativeAdmobController();




  static Widget admobBannerAd(BuildContext context){
    return isAdShow ?
    Container(
      child: AdmobBanner(
        adUnitId: getBannerAdUnitId(),
        adSize: AdmobBannerSize.FULL_BANNER,
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
         if (event == AdmobAdEvent.closed)
          // interstitialAd1..load();
         handleEvent(event, args, 'Banner');
        },
      ),
    )
    :  Container(
      child: Text("No Text"),
    );
  }



  // static  AdmobInterstitial  myInterstitial1() {
  //
  //    return AdmobInterstitial(
  //      adUnitId: getInterstitialAdUnitId(),
  //      listener: (AdmobAdEvent event, Map<String, dynamic> args) async {
  //        if (event == AdmobAdEvent.failedToLoad) {
  //          print("InterstitialAd FailedToLoad");
  //          interstitialAd1..load();
  //        } else if (event == AdmobAdEvent.closed) {
  //          print("InterstitialAd closed");
  //          interstitialAd1 = myInterstitial1()..load();
  //        }
  //        else if(event==AdmobAdEvent.loaded)
  //        {
  //          print("InterstitialAd Loaded");
  //          interstitialAd1..load()..show();
  //        }
  //       else{
  //          handleEvent(event, args, 'Interstitial');
  //         // handleEvent(event, args, 'Interstitial');
  //        }
  //      },
  //    );
  //  }

  // static InterstitialAd  myInterstitial() {
  //    return InterstitialAd(
  //      adUnitId: getInterstitialAdUnitId(),
  //      targetingInfo: targetingInfo,
  //      listener: (MobileAdEvent event) {
  //        if (event == MobileAdEvent.failedToLoad) {
  //          print("InterstitialAd FailedToLoad");
  //          interstitialAd..load();
  //        } else if (event == MobileAdEvent.closed) {
  //          print("InterstitialAd closed");
  //          interstitialAd = myInterstitial()..load();
  //        }
  //        else if(event==MobileAdEvent.loaded)
  //        {
  //          print("InterstitialAd Loaded");
  //        }
  //      },
  //    );
  // //  }
  //  static void adInterstitialAdshow(){
  //   SharedPreferences.getInstance().then((SharedPreferences pr) {
  //     prefs = pr;
  //     preferenceHelper = new PreferenceHelper(prefs);
  //     if(isAdShow){
  //       print("before "+counter.toString());
  //       counter++;
  //       preferenceHelper.saveCounter(counter);
  //       print("after "+counter.toString());
  //       if (preferenceHelper.getCounter() == FinalAdCounter) {
  //         counter = 0;
  //         preferenceHelper.saveCounter(counter);
  //         interstitialAd = myInterstitial()..load();
  //         interstitialAd..load()..show();
  //       }
  //     }
  //   });
  // }




  static void launchSocialUrl(String url) async {

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  static  Future<void> share() async {
    await FlutterShare.share(
        title: AppString.appName,
        text: AppString.appShareDescription,
        linkUrl: Platform.isAndroid ?  AppString.shareAndRateLink : AppString.shareAndRateLinkIOS,
        chooserTitle: 'Example Chooser Title');
  }



 static Future<dynamic>  showDialog(BuildContext context) {
    return showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(AppString.msg_noInternetTitle),
            content: Text(AppString.msg_InternetConnection),
            actions: <Widget>[
              TextButton(
                onPressed: () {

                  Navigator.of(context).pop();
                },
                child: Text("Dismiss"),
              ),
            ],
          );
        });
  }


  static Widget appDrawer(BuildContext context,GlobalKey<ScaffoldState> _scaffoldKey,CommonEditorController commonEditorController){

    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColors.backgroundColor,
      child: Drawer(

        child: Container(
          color: AppColors.backgroundColor,

          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top:Constant.size10,left: Constant.size20),
                child: new Row(
                  children: [
                    InkWell(
                      onTap:(){
                        _scaffoldKey.currentState.openEndDrawer();
                      },
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Icon(Icons.arrow_back_ios,
                            color: AppColors.primaryColor,
                            size: Constant.size28,)
                      ),
                    ),
                    Expanded(
                      flex:1,
                      child: Center(
                        child: new Text("Settings",
                          style: TextStyle(color: AppColors.primaryColor,fontSize: FontSize.s20),
                        ),
                      ),
                    ),
                    SizedBox(width:20.0),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[

                      _createDrawerItem(context: context,icon: FontAwesomeIcons.googlePlay,
                          text: 'Rate Us',onTap: (){
                            StoreRedirect.redirect(
                                androidAppId: AppString.appId,
                                iOSAppId: AppString.appleAppID);
                          }),
                      Divider(height: 1.0,),
                      _createDrawerItem(context: context,icon: FontAwesomeIcons.share,
                          text: 'Share App',onTap: (){
                            share();
                          }),
                      Divider(height: 1.0,),
                      _createDrawerItem(context: context,
                          icon: FontAwesomeIcons.globeAfrica,
                          text: 'Website',
                          onTap: (){
                            launchSocialUrl(AppString.socialWebsiteRain);
                          }),
                      Divider(height: 1.0,),
                      _createDrawerItem(context: context,
                          icon: FontAwesomeIcons.whatsapp,
                          text: 'Whatsapp',
                          onTap: (){
                            launchSocialUrl(AppString.socialWhatsappRain);
                          }),

                      Divider(height: 1.0,),
                      _createDrawerItem(context: context,
                          icon: FontAwesomeIcons.facebookSquare,
                          text: 'Facebook',
                          onTap: (){
                            launchSocialUrl(AppString.socialFbRain);
                          }),

                      Divider(height: 1.0,),
                      _createDrawerItem(context: context,
                          icon: FontAwesomeIcons.twitter,
                          text: 'Twitter',
                          onTap: (){
                            launchSocialUrl(AppString.socialTwitterRain);
                          }),
                      Divider(height: 1.0,),
                      _createDrawerItem(context: context,
                          icon: FontAwesomeIcons.instagram,
                          text: 'Instagram',
                          onTap: (){

                            launchSocialUrl(AppString.socialInstaRain);
                          }),
                      Divider(height: 1.0,),
                      _createDrawerItem(context: context,
                          icon: FontAwesomeIcons.linkedin,
                          text: 'LinkedIn',
                          onTap: (){
                            launchSocialUrl(AppString.socialLinkedinRain);
                          }),
                      Divider(height: 1.0,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Version",
                            style: GoogleFonts.metrophobic(
                              fontSize: FontSize.s20,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),),
                          Padding(
                            padding: EdgeInsets.only(left:20.0),
                            child: Text(commonEditorController.appVersion,
                              style: GoogleFonts.metrophobic(
                                fontSize: FontSize.s20,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),),
                          )
                        ],
                      ),




                      isAdShow?  Container(
                        height: 200,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 20.0),
                        child: NativeAdmob(
                          // Your ad unit id
                          adUnitID: getNativeAdUnitId(),
                          numberAds: 3,
                          controller: _nativeAdController,
                          type: NativeAdmobType.banner,
                        ),
                      ):new Container()

                    ]),
              ),

            ],
          ),
        ),
      ),
    );
  }

  static Widget _createDrawerItem(
      {BuildContext context,IconData icon, String text, GestureTapCallback onTap}) {
    return Container(

      margin: EdgeInsets.only(top:Constant.size15,bottom: Constant.size4,left: Constant.size20),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,

            child: Row(
              children: <Widget>[
                Icon(icon,size: 24,color: AppColors.primaryColor,),
                Padding(
                  padding: EdgeInsets.only(left:20.0),
                  child: Text(text,
                    style: GoogleFonts.metrophobic(
                    fontSize: FontSize.s20,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),),
                )
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top:Constant.size10,bottom: Constant.size10),
            width: MediaQuery.of(context).size.width,
            height: 1.0,
            color: AppColors.bgColor,
          ),
        ],
      ),
    );

  }


  static Widget defaultErrorWidget(BuildContext context,double height,double width){
    return Container(
      width: width,
      height: height,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error, color: Colors.red),
          Text('Error loading Image')
        ],
      ),
    );
  }



}