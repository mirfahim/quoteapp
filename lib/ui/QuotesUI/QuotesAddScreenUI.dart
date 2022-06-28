import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thoughts_creator/controller/TextEditorController.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/AppCommonFunc.dart';
import 'package:thoughts_creator/utils/screen_util.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';



// ignore: must_be_immutable
class QuotesAddScreenUI extends StatefulWidget {

  String quotesText;
  QuotesAddScreenUI(this.quotesText);


  @override
  _QuotesAddScreenUIState createState() => _QuotesAddScreenUIState();
}

class _QuotesAddScreenUIState extends State<QuotesAddScreenUI> {

  TextEditingController txtQuotesController=new TextEditingController(text: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    txtQuotesController.text=widget.quotesText;
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87.withOpacity(0.5),
        body: new Column(
          children: [
            Expanded(
              flex:1,
              child: new Container(
                child:  GetBuilder(
                  init: TextEditorController(),
                  builder: (TextEditorController textEditingController){
                    return new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Container(

                          margin:EdgeInsets.all(Constant.size10),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap:(){
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  child: new Icon(Icons.close,color: AppColors.redColor,size: Constant.size28,),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  txtQuotesController.text="";
                                },
                                child: Container(
                                  child: new Icon(Icons.delete,color: AppColors.white,size: Constant.size28,),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  textEditingController.updateQuotesText(txtQuotesController.text);
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  child: new Icon(Icons.check,color: AppColors.greenColor,size: Constant.size28,),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex:1,
                          child: Center(
                            child: Container(
                              alignment: Alignment.center,
                              margin:EdgeInsets.only(left:Constant.size8,right:Constant.size8),
                              child: Center(
                                child: TextFormField(
                                  controller: txtQuotesController,
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: AppColors.white,fontSize: FontSize.s20,fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 16,
                                  textAlign: TextAlign.center,
                                  decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                    hintText: "Enter Your Quotes",
                                    hintStyle: TextStyle(color: AppColors.white,fontSize: FontSize.s20,fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    );
                  },
                ),
              ),
            ),
            AppCommonFunc.admobBannerAd(context),
          ],
        ),
      ),
    );
  }
}
