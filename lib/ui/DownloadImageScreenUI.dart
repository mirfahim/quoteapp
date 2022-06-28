import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_share/social_share.dart';
import 'package:thoughts_creator/controller/RatioController.dart';
import 'package:thoughts_creator/ui/MainScreen.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/AppCommonFunc.dart';
import 'package:thoughts_creator/utils/AppString.dart';
import 'package:thoughts_creator/utils/screen_util.dart';

class DownloadImageScreenUI extends StatefulWidget {
  final Uint8List byteImage;

  DownloadImageScreenUI(this.byteImage);

  @override
  _DownloadImageScreenUIState createState() => _DownloadImageScreenUIState();
}

class _DownloadImageScreenUIState extends State<DownloadImageScreenUI> {
  String byteImages;
  GlobalKey globalKey = new GlobalKey();
  String albumName ='ThoughtsCreator';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // AppCommonFunc.adInterstitialAdshow();
    print("byteImage" + widget.byteImage.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Preview",style: TextStyle(
          color: AppColors.primaryColor
        ),),
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
      body: new Column(
        children: [
          Expanded(
            flex:1,
            child: new Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [

                    Expanded(
                      flex:1,
                      child: Container(
                        margin:EdgeInsets.only(top:Constant.size20,),
                        child: Center(
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            elevation: 5.0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            type: MaterialType.transparency,
                            child:GetBuilder(
                              init: RatioController(),
                              builder: (RatioController ratioController){
                                return  AspectRatio(
                                  aspectRatio: ratioController.ratioX / ratioController.ratioY,
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Stack(
                                      children: [
                                        RepaintBoundary(
                                          key: globalKey,
                                          child: Container(

                                              child: Image.memory(widget.byteImage,fit: BoxFit.cover,

                                              )),
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),


                    new Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child:Container(
                            padding: EdgeInsets.only(top: Constant.size15,left: Constant.size15,right: Constant.size15),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap:(){
                                    requestPermission(Permission.storage);
                                  },
                                  child: Container(

                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        shape: BoxShape.circle
                                    ),
                                    child: Container(
                                        margin: EdgeInsets.all(15.0),
                                        child: new Image.asset(AppString.iconImagesPath+"ic_download.png",
                                          height: Constant.size18,
                                          width: Constant.size18,
                                          color: AppColors.black,
                                        )

                                    ),
                                  ),
                                ),
                                SizedBox(width:Constant.size24),

                                InkWell(
                                  onTap:(){
                                    _sharePng(AppString.SHARE_TYPE_ALL);
                                  },
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        shape: BoxShape.circle
                                    ),
                                    child: Container(
                                        margin: EdgeInsets.all(15.0),
                                        child: new Image.asset(
                                          AppString.iconImagesPath+"ic_share.png",
                                          height: Constant.size18,
                                          width: Constant.size18,
                                          color: AppColors.black,
                                        )
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          AppCommonFunc.admobBannerAd(context),

        ],
      ),
    );
  }
  var timeStamp =  DateTime.now().millisecondsSinceEpoch;

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();

    if(status==PermissionStatus.granted){
      _captureAndSharePng();
    }else if(status==PermissionStatus.denied){
      requestPermission(Permission.storage);
    }else if(status==PermissionStatus.permanentlyDenied){
      requestPermission(Permission.storage);
    }

  }

  Future<void> _captureAndSharePng() async {

    try {
      RenderRepaintBoundary boundary =
      globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 2.0);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      if(Platform.isAndroid){
        Directory directory = Directory("/storage/emulated/0/ThoughtsOfTheDay/");
        if (!directory.existsSync()) {
          Directory("/storage/emulated/0/ThoughtsOfTheDay/").create(recursive: false)
              .then((Directory directory) {
            print('Path of New Dir: '+directory.path);
          });
        }

        final  file = new File(directory.path+"$timeStamp.png");
        await file.writeAsBytes(pngBytes);
      }else if(Platform.isIOS){

        Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
        String appDocumentsPath = appDocumentsDirectory.path; // 2
        String filePath = '$appDocumentsPath'+'/'+'$timeStamp.png'; // 3
        final  file  = new File(filePath);
        await file.writeAsBytes(pngBytes);


      }

      //print("T: "+file.path);
      Fluttertoast.showToast(
          msg: "Image Saved",
          backgroundColor: Colors.green,
          // fontSize: 25
          // gravity: ToastGravity.TOP,
          textColor: Colors.white
      );


      Get.offAll(()=>MainScreenUI(true,false));
    } catch (e) {
      print(e.toString());
    }
  }




  Future<void> _sharePng(int type) async {

    try {
      RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 2.0);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      print("tmpDir: " + tempDir.toString());
      final file = await new File('${tempDir.path}/image.png').create();
      print("tmpDir1: " + file.toString());
      await file.writeAsBytes(pngBytes);

      //ShareExtend.share(tempDir.path + "/image.png", "image");
      String path = tempDir.path + "/image.png";
     // final bytes = Io.File(file.path).readAsBytesSync();

   //   SocialShare.shareOptions("Hello World",imagePath: path);
      if(type==AppString.SHARE_TYPE_FB){
        SocialShare.shareFacebookStory(path,null,null,null);
      }else if(type==AppString.SHARE_TYPE_INSTAGRAM){
        SocialShare.shareInstagramStory(path,);
      }else if(type==AppString.SHARE_TYPE_WP){
        SocialShare.shareOptions('image',
            imagePath: path);
      }else{
        SocialShare.shareOptions('image',
          imagePath: path);
      }



    } catch (e) {
      print(e.toString());
    }
  }

 /* void _saveNetworkImage(var image) async {


    GallerySaver.saveImage(image.path, albumName: albumName)
        .then((bool success) {

          Fluttertoast.showToast(
            msg: "Image Saved",
            backgroundColor: Colors.green,
            // fontSize: 25
            // gravity: ToastGravity.TOP,
            textColor: Colors.white
          );

    });

  }*/
}
