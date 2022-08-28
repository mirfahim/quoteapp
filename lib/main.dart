import 'dart:io';

//import 'package:admob_flutter/admob_flutter.dart';
//import 'package:firebase_admob/firebase_admob.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thoughts_creator/ui/SplashScreenUI.dart';
import 'utils/AppString.dart';



void main() {
  runApp(MyApp());
 // FirebaseAdMob.instance.initialize(appId: getAppId());
}

int counter=0;
const int FinalAdCounter=3;



/*-------------------Ads Status Change-------------------------------------*/
// here , if you want  GoogleAds show in Food Delivery UI Application, you can easily change "isAdShow" flag value true.

bool isAdShow=true;




String getAppId() {
  if (Platform.isIOS) {
    return AppString.googleAdsAppIDIOS;
  } else if (Platform.isAndroid) {
   // return AppString.googleAdsAppIDAndroid;
   return  'ca-app-pub-2439453252928936~7050236967';


  }
  return null;
}



//Banner placementID
String getBannerAdUnitId() {
  if (Platform.isIOS) {
    return AppString.bannerAdsIOS;
  } else if (Platform.isAndroid) {
   // return AppString.bannerAdsAndroid;
    //
    //  return 'ca-app-pub-2439453252928936/7597031879';

    return  'ca-app-pub-2439453252928936/7597031879' ;

  }
  return null;
}



String getNativeAdUnitId() {
  if (Platform.isIOS) {
    return AppString.nativeAdsAppIDIOS;
  } else if (Platform.isAndroid) {
    // return AppString.nativeAdsAppIDAndroid;
    return "ca-app-pub-3940256099942544/2247696110";

  }
  return null;
}

bool isAdLoad = false;

void handleEvent(AdmobAdEvent event, Map<String, dynamic> args, String adType) {
  switch (event) {
    case AdmobAdEvent.loaded:
      isAdLoad = true;
      print('New Admob $adType Ad loaded!');
      break;
    case AdmobAdEvent.opened:
      isAdLoad = true;
      print('Admob $adType Ad opened!');
      break;
    case AdmobAdEvent.closed:
      isAdLoad = false;
      print('Admob $adType Ad closed!');
      break;
    case AdmobAdEvent.failedToLoad:
      isAdLoad = false;
      //print('Admob $adType failed to load. :(');
      print('Admob $adType Ad failed to load!');
      break;
    default:
  }
 }





//Interstitial placementID
String getInterstitialAdUnitId() {
  if (Platform.isIOS) {
    return AppString.interstitialAdsIOS;
  } else if (Platform.isAndroid) {
   return AppString.interstitialAdsAndroid;

  }
  return null;
}


// return 'ca-app-pub-3940256099942544/4411468910';
// MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//   keywords: <String>['flutterio', 'beautiful apps'],
//   contentUrl: 'https://flutter.io',
//
//   childDirected: false,
//   testDevices: <String>[], // Android emulators are considered test devices
// );




class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GetMaterialApp(
      title: 'Thoughts Of The Day',debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.muliTextTheme(textTheme).copyWith(
          bodyText2: GoogleFonts.muli(textStyle: textTheme.bodyText2)
        ),
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreenUI(),
    );
  }
}

