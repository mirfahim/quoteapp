import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thoughts_creator/controller/TextEditorController.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/AppCommonFunc.dart';
import 'package:thoughts_creator/utils/AppString.dart';
import 'package:thoughts_creator/utils/screen_util.dart';
import 'dart:math' as math;


// ignore: must_be_immutable
class QuotesDetailScreenUI extends StatefulWidget {

  final List<dynamic> quotesData;
  final String catName;
   Color color = AppColors.primaryColor;

  QuotesDetailScreenUI(this.quotesData,this.catName,{this.color});
  @override
  _QuotesDetailScreenUIState createState() => _QuotesDetailScreenUIState();
}

class _QuotesDetailScreenUIState extends State<QuotesDetailScreenUI> {
  @override
  Widget build(BuildContext context) {
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
        title: new Text('Quotes',
          style: TextStyle(color: AppColors.primaryColor),
        ),
        backgroundColor: AppColors.backgroundColor,

      ),
      body: new Container(
        child: new Column(
          children: [
            Container(
                child: Expanded(
                  flex:1,
                  child: ListView.builder(
                      itemCount: widget.quotesData.length,
                      itemBuilder: (context, index) {
                        return widgetQuotesItems(index,widget.quotesData);
                      }),
                )),
            AppCommonFunc.admobBannerAd(context),
          ],
        ),
      ),
    );
  }

  Widget widgetQuotesItems1(int index,List<dynamic> quotesList) {
    return Container(
      margin: EdgeInsets.all(6.0),
      child: GetBuilder(builder: (TextEditorController textEditorController){
        return InkWell(
          onTap: (){

            textEditorController.updateQuotesText(quotesList[index]);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: Container(
            height: 150,
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
          borderRadius: BorderRadius.circular(10),
          boxShadow:[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2),

            ),

              ],
            ) ,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child:Container(
                  child: Stack(children: <Widget>[
                    Positioned(
                        top:-20, left:-50,
                        child:Container(
                            height:250,
                            width:250,
                            decoration:BoxDecoration(
                                shape:BoxShape.circle,
                                color:Colors.orange.withOpacity(0.5)
                            )
                        )
                    ),

                    Positioned(
                        left:-80,top:-50,
                        child:Container(
                            height:180,
                            width:180,
                            decoration:BoxDecoration(
                                shape:BoxShape.circle,
                                color:Colors.redAccent.withOpacity(0.5)
                            )
                        )
                    ),

                    Positioned(
                      child: Container(
                          alignment: Alignment.center,
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(quotesList[index],
                              maxLines: 8,
                              style: TextStyle(
                                color:Colors.white, fontSize:20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                      ),
                    )
                  ],)
              ),
            ),
          ),
        );



      }),
    );
  }


  Widget widgetQuotesItems(int index,List<dynamic> quotesList) {
    return Container(
      margin: EdgeInsets.all(6.0),
      child: GetBuilder(builder: (TextEditorController textEditorController){
        return Stack(
          children: [
            Container(
              padding:EdgeInsets.all(10),
              child: InkWell(
                onTap: (){

                  textEditorController.updateQuotesText(quotesList[index]);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Container(

                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    //  color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: widget.color,width: 1.0)

                  ) ,
                  child:  Container(
                      margin: EdgeInsets.only(top:Constant.size6,bottom: Constant.size6),
                      alignment: Alignment.center,
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(quotesList[index],
                          maxLines: 8,
                          style: TextStyle(
                            color:Colors.white, fontSize:18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                  ),
                ),
              ),
            ),
            Positioned(
              left:55, top: -3,
              child: Transform(
                transform: Matrix4.rotationY(math.pi),
                child: Container(

                  alignment: FractionalOffset.centerLeft,
                  child: Image.asset(
                    AppString.imagesAssetPath + "ic_quote2.png",
                    color: widget.color,
                    height: 30.0,
                    width: 30.0,
                  ),
                ),
              ),
            ),
            Positioned(
              right:2, bottom: -3,
              child: Transform(
                transform: Matrix4.rotationY(math.pi),
                child: Container(

                  alignment: FractionalOffset.centerLeft,
                  child: Image.asset(
                    AppString.imagesAssetPath + "ic_quote1.png",
                    color: widget.color,
                    height: 30.0,
                    width: 30.0,
                  ),
                ),
              ),
            ),
          ],
        );

      }),
    );
  }
}
