import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thoughts_creator/Model/ImgClass.dart';
import 'package:thoughts_creator/controller/SavedCollectionController.dart';
import 'package:thoughts_creator/ui/SliderPreviewImageUI.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/AppCommonFunc.dart';


class SavedCollectionScreenUI extends StatefulWidget {



  @override
  _SavedCollectionScreenUIState createState() => _SavedCollectionScreenUIState();
}

class _SavedCollectionScreenUIState extends State<SavedCollectionScreenUI> {

  List<ImgClass> imgFiles = [];
  List<ImgClass> selectedList = [];
  List<FileSystemEntity> _files = [];
  bool isAllSelect=false;
  final SavedCollectionController savedCollectionController= Get.put(SavedCollectionController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission(Permission.storage);
   // AppCommonFunc.adInterstitialAdshow();
    // getDataFromDir();

  }
  Future<void> requestPermission(Permission permission) async {

    if(permission.isGranted != null){

      final status = await permission.request();
      if(status==PermissionStatus.granted){
        getDataFromDir();
      }else if(status==PermissionStatus.denied){
        requestPermission(Permission.storage);
      }else if(status==PermissionStatus.permanentlyDenied){
        requestPermission(Permission.storage);
      }
    }

  }


  getDataFromDir() async {

    if(Platform.isAndroid){
      Directory externalDirectory = new Directory("/storage/emulated/0/ThoughtsOfTheDay/");

      if(externalDirectory.existsSync()) {
        _files = externalDirectory.listSync(recursive: true, followLinks: false);
        for (FileSystemEntity entity in _files) {

          String path = entity.path;
          print("PATH " + path);
        }
      }else{
        //externalDirectory.create(recursive: true);

        var myDir = new Directory('/storage/emulated/0/ThoughtsOfTheDay/').create(recursive: true).then((Directory directory) {
          print('Path of New Dir: '+directory.path);
        });

        print("TEST"+myDir.toString());
      }
    }else if(Platform.isIOS){
      Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1

      if(appDocumentsDirectory.existsSync()) {
        _files = appDocumentsDirectory.listSync(recursive: true, followLinks: false);
        for (FileSystemEntity entity in _files) {

          String path = entity.path;
          print("PATH " + path);
        }
      }
    }


    for (int i = 0; i < _files.length; i++) {
      imgFiles.add(new ImgClass(_files[i],false));
    }
   savedCollectionController.updateMainImgFiles(imgFiles);

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SavedCollectionController(),
      builder: (SavedCollectionController controller) {
        return Scaffold(
          backgroundColor:AppColors.backgroundColor ,

            body: new Column(
              children: [
                Expanded(
                  flex:1,
                  child: Container(
                    child:  controller.imgFiles!=null && controller.imgFiles.length > 0 ?
                    StaggeredGridView.countBuilder(
                      crossAxisCount: 4,
                      itemCount: controller.imgFiles.length,
                      shrinkWrap: true,
                      reverse: false,
                      itemBuilder: (BuildContext context, int index) =>
                      new Container(
                          child: sliverGridWidget(context,index,controller)),
                      staggeredTileBuilder: (int index) =>
                      new StaggeredTile.count(2, index.isEven ? 2 : 3),
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    ):new Center(child: new Text("Collection is empty!",style: TextStyle(fontSize: 24.0,color: AppColors.primaryColor),),),


                  ),
                ),
                AppCommonFunc.admobBannerAd(context),
              ],
            ),
        );
      },

    );
  }
//

  Widget sliverGridWidget(BuildContext context,index,SavedCollectionController controller){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onLongPress: (){


          for (int i = 0; i < controller.imgFiles.length; i++) {
            if (index == i) {
              if (controller.imgFiles[i].isSelect) {
                controller.imgFiles[i].isSelect = false;
                controller.selectedList.remove(controller.imgFiles[index]);
                print("A ");
              } else {
                controller.imgFiles[i].isSelect = true;
                controller.selectedList.add(controller.imgFiles[index]);
                print("B ");
              }
            }
          }
          controller.updateMainImgFiles(controller.imgFiles);
          controller.updateSelectedFiles(controller.selectedList);

          print("length "+controller.selectedList.length.toString());

        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(width: controller.imgFiles[index].isSelect? 2 : 1.5,style: BorderStyle.solid,
                  color:controller.imgFiles[index].isSelect ? AppColors.redColor: AppColors.primaryColor)
          ),
          child: Material(
              borderRadius: BorderRadius.circular(3.0),

              elevation: 5.0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              type: MaterialType.transparency,
              child:InkWell(
                  child: Hero(
                    tag: index,// staticData[index].images,
                    child: new FadeInImage(
                      width: MediaQuery.of(context).size.width,
                      image: FileImage(controller.imgFiles[index].fileSystemEntity,scale: 1.0), // NetworkImage(staticData[index].images),
                      fit: BoxFit.cover,
                      placeholder: AssetImage(controller.imgFiles[index].fileSystemEntity.path),
                    ),
                  ),
                  onTap: (){
                    //
                    if(controller.selectedList.isEmpty){
                      List<FileSystemEntity> tmpFilesArray = [];
                      for (int i = 0; i < controller.imgFiles.length; i++) {
                        tmpFilesArray.add(controller.imgFiles[i].fileSystemEntity);
                      }

                      Get.to(() => SliderPreviewImageUI(tmpFilesArray,[],index,false,));
                    }
                  }
              )
          ),
        ),
      ),
    );
  }
}



