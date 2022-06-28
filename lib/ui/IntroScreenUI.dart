
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thoughts_creator/Helper/PreferenceHelper.dart';
import 'package:thoughts_creator/controller/BackgroundImgController.dart';
import 'package:thoughts_creator/controller/CommonEditorController.dart';
import 'package:thoughts_creator/ui/MainScreen.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/AppString.dart';
import 'package:thoughts_creator/utils/screen_util.dart';


class IntroScreenUI extends StatefulWidget {
  @override
  _IntroScreenUIState createState() => _IntroScreenUIState();
}

class _IntroScreenUIState extends State<IntroScreenUI> {

  PreferenceHelper preferenceHelper;
  SharedPreferences prefs;
  final introKey = GlobalKey<IntroductionScreenState>();
  final BackgroundImgController bgImgController = Get.put(BackgroundImgController());
  PageDecoration pageDecoration;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pageDecoration= PageDecoration(
      titleTextStyle: GoogleFonts.metrophobic(fontSize: Constant.size28, fontWeight: FontWeight.w700,color: AppColors.white),
      bodyTextStyle: GoogleFonts.metrophobic(fontSize: Constant.size16,color: AppColors.primaryColor),
      descriptionPadding: EdgeInsets.fromLTRB(Constant.size16, Constant.size16, Constant.size16, Constant.size16),
      pageColor:AppColors.backgroundColor,
      imagePadding: EdgeInsets.zero,
    );
    getSharedPreferenceObject();
  }


  Future<void> getSharedPreferenceObject() async {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      prefs = sp;
      preferenceHelper = new PreferenceHelper(prefs);
      bgImgController.apiLogin();
   //checkInternetConnection();
     /* pageDecoration= PageDecoration(
        titleTextStyle: GoogleFonts.metrophobic(fontSize: Constant.size28, fontWeight: FontWeight.w700,color: AppColors.white),
        bodyTextStyle: GoogleFonts.metrophobic(fontSize: Constant.size16,color: AppColors.primaryColor),
        descriptionPadding: EdgeInsets.fromLTRB(Constant.size16, Constant.size16, Constant.size16, Constant.size16),
        pageColor:AppColors.back0groundColor,
        imagePadding: EdgeInsets.zero,
      );*/

    });
  }



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GetBuilder(
        init: CommonEditorController(),
        builder: (CommonEditorController commonEditorController){
          return  Container(
            color:AppColors.backgroundColor,
            child: Column(
              children: [

                Expanded(
                  child: Container(
                    color:AppColors.backgroundColor,
                    child: IntroductionScreen(
                      key: introKey,
                      globalBackgroundColor: AppColors.backgroundColor,

                      pages: [
                        PageViewModel(
                          title: AppString.intro_title1,
                          body: AppString.intro_description1,
                          image: _buildImage('intro_img1'),
                          decoration: pageDecoration,
                        ),
                        PageViewModel(
                          title: AppString.intro_title2,
                          body: AppString.intro_description2,
                          image: _buildImage('intro_img2'),
                          decoration: pageDecoration,
                        ),
                        PageViewModel(
                          title: AppString.intro_title3,
                          body: AppString.intro_description3,
                          image: _buildImage('intro_img3'),
                          decoration: pageDecoration,
                        ),
                      ],
                      onDone: () => _onIntroEnd(context,preferenceHelper,commonEditorController),
                      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
                      showSkipButton: true,
                      skipFlex: 0,
                      nextFlex: 0,
                      skip:  Text(AppString.skip,
                        style: GoogleFonts.metrophobic(fontWeight: FontWeight.w600,color: AppColors.white),),
                      next:  Icon(Icons.arrow_forward,color: AppColors.white,),
                      done:  Text(AppString.done,
                          style: GoogleFonts.metrophobic(fontWeight: FontWeight.w600,color: AppColors.white)),
                      dotsDecorator:  DotsDecorator(
                        size: Size(Constant.size10, Constant.size10),
                        color: AppColors.white,
                        activeSize: Size(Constant.size24, Constant.size10),
                        activeColor: AppColors.primaryColor,
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(Constant.size24)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },

      ),
    );
  }
}



void _onIntroEnd(context,preferenceHelper,CommonEditorController commonEditorController) {
  preferenceHelper.saveIsUserNew(false);

  if(commonEditorController.isNoDataApi){
    Get.off(() => MainScreenUI(false,true));
  }else{
    Get.off(()=>MainScreenUI(false,false));
  }


}

Widget _buildImage(String assetName) {
  return Align(
    child: Container(
        margin: EdgeInsets.only(bottom: Constant.size20),
        child: Image.asset(AppString.imagesAssetPath+'$assetName.png', width: 350.0)),
    alignment: Alignment.bottomCenter,
  );
}

