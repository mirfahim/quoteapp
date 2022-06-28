import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thoughts_creator/Helper/PreferenceHelper.dart';
import 'package:thoughts_creator/controller/BackgroundImgController.dart';
import 'package:thoughts_creator/controller/CommonEditorController.dart';
import 'package:thoughts_creator/ui/IntroScreenUI.dart';
import 'package:thoughts_creator/ui/MainScreen.dart';
import 'package:thoughts_creator/utils/AppString.dart';

class SplashScreenUI extends StatefulWidget {
  @override
  _SplashScreenUIState createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {

  PreferenceHelper preferenceHelper;
  SharedPreferences prefs;
  final BackgroundImgController bgImgController = Get.put(BackgroundImgController());
  final CommonEditorController commonController = Get.put(CommonEditorController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetConnection();


  }
  checkInternetConnection()async {
    var notConnection = await (Connectivity().checkConnectivity());
    if (notConnection == ConnectivityResult.none) {
      _showDialog();
    } else {
      getSharedPreferenceObject();
    }
  }

  Future<void> getSharedPreferenceObject() async {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      prefs = sp;
      preferenceHelper = new PreferenceHelper(prefs);
      // checkInternetConnection();

      bgImgController.apiLogin();
      Future.delayed(new Duration(seconds:4),() async {
        print("new user======"+preferenceHelper.getIsUserNew().toString());
        if (preferenceHelper.getIsUserNew()) {

          Get.off(() => IntroScreenUI());
        } else {

          if(commonController.isNoDataApi){
            Get.off(() => MainScreenUI(false,true));
          }else{
            Get.off(() => MainScreenUI(false,false));
          }



        }

      });

    });
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
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppString.imagesAssetPath+"splash1.jpg"),
              fit: BoxFit.cover
            )
          ),
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppString.imagesAssetPath+'applogo1.png',
                width: 220.0,height:220.0,),

            ],
          )),
        )
    );
  }

}
