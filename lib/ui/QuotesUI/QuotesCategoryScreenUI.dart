import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thoughts_creator/Model/QuotesDataResponse.dart';
import 'package:thoughts_creator/controller/QuotesEditorController.dart';
import 'package:thoughts_creator/controller/TextEditorController.dart';
import 'package:thoughts_creator/ui/QuotesUI/QuotesDetailScreenUI.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/AppCommonFunc.dart';
import 'package:thoughts_creator/utils/AppString.dart';
import 'package:thoughts_creator/utils/screen_util.dart';


class QuotesCategoryScreenUI extends StatefulWidget {

  @override
  _QuotesCategoryScreenUIState createState() => _QuotesCategoryScreenUIState();
}

class _QuotesCategoryScreenUIState extends State<QuotesCategoryScreenUI> {
  final textController = Get.put(TextEditorController());
  final quotesEditController = Get.put(QuotesEditorController());

  /*List<Datum> quoteData = new List();

  */
  List<Color> tmpColor = [];
  List<ColorSwatch> bgColorQuotes = <ColorSwatch>[
    Colors.red,
    Colors.pink,
    Colors.pinkAccent,
    Colors.purple,
    Colors.purpleAccent,
    Colors.deepPurple,
    Colors.deepPurpleAccent,
    Colors.indigo,
    Colors.indigoAccent,
    Colors.blue,
    Colors.blueAccent,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.cyan,
    Colors.cyanAccent,
  ];

  String title = "English";

 /* static PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
*/


  Future<void> changeTitle(
      int index, QuotesEditorController quotesEditorController) async {

    switch (index) {
      case 0:
        title = "English";
        break;
      case 1:
        title = "हिंदी";
        break;
      case 2:
        title = "বাংলা";
        break;
    }
    quotesEditorController.updateAppBarTitleQuotes(title);
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData(0,quotesEditController);
    //AppCommonFunc.adInterstitialAdshow();
  }

 void loadData(int type,QuotesEditorController quotesEditorController) async {
   quotesEditController.tmpColor.clear();
   quotesEditController.quoteData.clear();

    String data="";

      if(type==0){
        print("0");
        tmpColor.clear();
        quotesEditController.tmpColor.clear();
        quotesEditController.quoteData.clear();
        data=await DefaultAssetBundle.of(context)
            .loadString("assets/json/english_thoughts.json");

      }else if(type==1){
        print("1");
        tmpColor.clear();
        quotesEditController.tmpColor.clear();
        quotesEditController.quoteData.clear();
        data=await DefaultAssetBundle.of(context)
            .loadString("assets/json/hindi_thoughts.json");


      }else{
        print("2");
        tmpColor.clear();
        quotesEditController.tmpColor.clear();
        quotesEditController.quoteData.clear();
        data=await DefaultAssetBundle.of(context)
            .loadString("assets/json/gujarati_thoughts.json");

      }
    Map valueMap = jsonDecode(data);
    QuotesDataResponse quotesDataResponse =
    QuotesDataResponse.fromJson(valueMap);
    //final json = jsonDecode(data);
    //print(" "+data.toString());

    quotesEditController.updateQuotesDataResponse(quotesDataResponse.data);

    for (int i = 0; i < quotesEditController.quoteData.length; i++) {
      for (int j = 0; j < bgColorQuotes.length; j++) {
        tmpColor.add(bgColorQuotes[j]);

        quotesEditController.updateQuotesColorCategory(tmpColor);
      }
    }



  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: QuotesEditorController(),
        builder: (QuotesEditorController quotesEditorController){
      return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: new AppBar(
            centerTitle:true,
            leading:  InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: new Container(

                child: new Icon(
                  Icons.arrow_back,
                  color: AppColors.primaryColor,
                ),
              ),
            ) ,
            title: new Text(title,
              style: TextStyle(color: AppColors.primaryColor),
            ),
            backgroundColor: AppColors.backgroundColor,

          ),
          body:
          Column(
            children: [

              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 24.0,right: 24.0,top: 18.0,bottom: 18.0),
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
                            bottomTapped(0,quotesEditorController);
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
                                    "English",
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
                            bottomTapped(1,quotesEditorController);
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
                                  "हिंदी",
                                  style: TextStyle(
                                      color: quotesEditorController
                                          .isColorTabSelected ==
                                          1
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
                            quotesEditorController.updateQuotesColorTab(2);
                            bottomTapped(2,quotesEditorController);
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
                                  "বাংলা",
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

              Expanded(
                  flex: 1,
                  child: englishData(quotesEditorController)),

              AppCommonFunc.admobBannerAd(context),

            ],
          ) ,


      );
    });
  }


  void bottomTapped(int index,QuotesEditorController quotesEditorController) {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    quotesEditorController.updateBottomQuotesIndex(index);
    changeTitle(index, quotesEditorController);
    /*pageController.animateToPage(index,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
*/
      if(quotesEditorController.bottomChangedQuotesIndex==0){
        loadData(0,quotesEditorController);
      }else if(quotesEditorController.bottomChangedQuotesIndex==1){
        loadData(1,quotesEditorController);
      }else if(quotesEditorController.bottomChangedQuotesIndex==2){
        loadData(2,quotesEditorController);
      }else{
        loadData(0,quotesEditorController);
      }
  }


  Widget englishData(QuotesEditorController quotesEditorController){
    return new Container(
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: quotesEditorController.quoteData.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1.2),
            itemBuilder: (BuildContext context, int index) {
             return quotesCategoryData(index,quotesEditorController);

            }));
  }


  Widget quotesCategoryData(int index,QuotesEditorController quotesEditorController){
    return  Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: () {



          Get.to(() =>QuotesDetailScreenUI(
              quotesEditorController.quoteData[index].item, quotesEditorController.quoteData[index].name
              ,color: AppColors.primaryColor));
        },
        child: Stack(
         children: [



           Container(
             padding:EdgeInsets.all(10),
             child: Container(
               padding:EdgeInsets.all(5),
               width: MediaQuery.of(context).size.width,
               decoration: BoxDecoration(
                 color: tmpColor[index],


               ),
               child:new Container(
                 alignment: Alignment.center,

                 child: new Text(
                   quotesEditorController.quoteData[index].name,//quoteData[index].name
                   style: GoogleFonts.muli(
                       textStyle: TextStyle(
                           color: Colors.white,
                           fontSize: FontSize.s18,
                           fontWeight: FontWeight.bold)),
                 ),
               ),

               // constraints: BoxConstraints(maxWidth:MediaQuery.of(context).size.width),
             ),
           ),

           Positioned(
             left:20, top: -5,
             child: Container(

               alignment: FractionalOffset.centerLeft,
               child: Image.asset(
                 AppString.imagesAssetPath + "ic_quote1-white.png",
                 color: Colors.white,
                 height: 40.0,
                 width: 40.0,
               ),
             ),
           ),




         ],
        ),


       /* Material(
          elevation: 12.0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          type: MaterialType.transparency,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: Container(
            color: tmpColor[index],
            child: Stack(
              children: [
                Container(
                    alignment: Alignment.bottomRight,
                    margin:
                    EdgeInsets.only(right: 1.0, bottom: 1.0),
                    child: Image.asset(
                      AppString.imagesAssetPath + "ic_coma.png",
                      color: Colors.transparent.withOpacity(0.2),
                      height: 60.0,
                      width: 60.0,
                    )),
                new Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 14.0, top: 16.0),
                  child: new Text(
                    quoteData[index].name,//quoteData[index].name
                    style: GoogleFonts.daysOne(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.s20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),*/
      ),
    );
  }

}
