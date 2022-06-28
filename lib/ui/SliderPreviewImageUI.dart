import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_share/social_share.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/AppCommonFunc.dart';
import 'package:thoughts_creator/utils/AppString.dart';
import 'package:thoughts_creator/utils/screen_util.dart';
import 'package:thoughts_creator/Model/PopularImageResponse.dart';
import 'package:path_provider/path_provider.dart';


// ignore: must_be_immutable
class SliderPreviewImageUI extends StatefulWidget {
  final List<FileSystemEntity> _files;
  final List<Src> _popularImgList;


  String imgPath;
  bool isPopular;
  int index;

  SliderPreviewImageUI(this._files,this._popularImgList, this.index,this.isPopular,{this.imgPath});

  @override
  _SliderPreviewImageUIState createState() => _SliderPreviewImageUIState();
}

class _SliderPreviewImageUIState extends State<SliderPreviewImageUI> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //AppCommonFunc.adInterstitialAdshow();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: new AppBar(
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: new Container(
              child: new Icon(
                Icons.arrow_back,
                color: AppColors.primaryColor,
              ),
            ),
          ),

          backgroundColor: AppColors.backgroundColor,
        ),
        body:new Column(
          children: [
            Expanded(
              flex:1,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Hero(
                            tag: widget.index,
                            child: Container(
                              child: CarouselSlider(
                                  items: widget.isPopular ? widget._popularImgList.map((item) =>
                                      Material(
                                        borderRadius: BorderRadius.circular(10.0),
                                        elevation: 5.0,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        type: MaterialType.transparency,
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Center(
                                            child: InkWell(
                                              onTap: (){
                                                Get.to(() =>DetailScreen(null,widget.imgPath+ "/" + item.img, widget.index,true));
                                                },
                                              child: Container(

                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(width: 1.5,style: BorderStyle.solid,
                                                        color: AppColors.primaryColor),
                                                  ),
                                                  child: Image.network(widget.imgPath +
                                                      "/" +
                                                      item.img,scale: 1.0,
                                                    errorBuilder:
                                                          (BuildContext context, Object exception, StackTrace stackTrace) {
                                                       return AppCommonFunc.defaultErrorWidget(context,300.0,300.0);
                                                      },
                                                  )
                                                /*  child: FancyShimmerImage(
                                                    imageUrl: widget.imgPath +
                                                        "/" +
                                                        item.img,
                                                    shimmerBaseColor: AppColors.hintColor,
                                                    shimmerHighlightColor: AppColors.hintColor,
                                                    shimmerBackColor: AppColors.hintColor,
                                                    errorWidget: null,
                                                  )*/
                                              ),
                                            ),
                                          ),
                                        ),
                                      )).toList()
                                      :
                                      widget._files.map((item) =>
                                      Material(
                                        borderRadius: BorderRadius.circular(10.0),
                                        elevation: 5.0,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        type: MaterialType.transparency,
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Center(
                                            child: InkWell(
                                              onTap: (){
                                                Get.to(() => DetailScreen(item,"",widget.index,false));
                                              },
                                              child: Container(

                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(width: 1.5,style: BorderStyle.solid,
                                                        color: AppColors.primaryColor),
                                                  ),

                                                  child: Image.file(item,scale: 1.0,)),
                                            ),
                                          ),
                                        ),
                                      )).toList(),
                                  options: CarouselOptions(
                                    height: MediaQuery.of(context).size.height,
                                    aspectRatio: 16/9,
                                    viewportFraction: 0.8,
                                    initialPage: widget.index,
                                    enableInfiniteScroll: false,
                                    reverse: false,
                                    autoPlay: false,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                    onPageChanged: (i, reason) {
                                      widget.index =i;
                                    },

                                  )
                              ),
                            ),
                          )

                      ),
                    ),
                    Padding(
                      padding:EdgeInsets.only(bottom: Constant.size20,top:Constant.size10),
                      child: InkWell(
                        onTap:() async {

                         // print("ID $widget.index "+widget._files[widget.index].path);
                          if(!widget.isPopular){
                            SocialShare.shareOptions('image',
                                imagePath: widget._files[widget.index].path);
                          }else{
                            var filename='temp.png';

                            final response = await http.get(widget.imgPath+"/"+widget._popularImgList[widget.index].img);

                            final documentDirectory = await getApplicationDocumentsDirectory();

                            final file = File(documentDirectory.path+"/"+filename);

                            file.writeAsBytesSync(response.bodyBytes);

                            SocialShare.shareOptions('image',
                                imagePath: file.path);
                          }




                        },
                        child: Container(

                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle
                          ),
                          child: Container(
                              margin: EdgeInsets.all(18.0),
                              child: new Image.asset(AppString.iconImagesPath+"ic_share.png",
                                height: Constant.size24,
                                width: Constant.size24,
                                color: AppColors.black,
                              )

                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            AppCommonFunc.admobBannerAd(context),
          ],
        )
      ),
    );
  }
}






class DetailScreen extends StatefulWidget {
  final FileSystemEntity _files;
  final String _imgPath;

  final int index;
  final bool isPopular;

  DetailScreen(this._files,this._imgPath, this.index, this.isPopular,);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // AppCommonFunc.adInterstitialAdshow();
  }

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

        backgroundColor: AppColors.backgroundColor,

      ),
      body: new Column(
        children: [
          Expanded(
            flex:1,
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Hero(
                    tag: widget.index,
                    child: Container(
                        margin:EdgeInsets.only(bottom: Constant.size20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1.5,style: BorderStyle.solid,
                                color: AppColors.primaryColor)
                        ),

                        child:
                        widget.isPopular?
                        Image.network(widget._imgPath,scale: 1.0,
                          errorBuilder:
                              (BuildContext context, Object exception, StackTrace stackTrace) {
                            return AppCommonFunc.defaultErrorWidget(context,300.0,300.0);
                          },
                        )
                        :
                        Image.file(widget._files, scale: 1.0,),
                    )
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          AppCommonFunc.admobBannerAd(context),
        ],
      ),
    );
  }
}
