import 'package:connectivity/connectivity.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thoughts_creator/Helper/PreferenceHelper.dart';
import 'package:thoughts_creator/controller/PopularImageController.dart';
import 'package:thoughts_creator/controller/SavedCollectionController.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/AppCommonFunc.dart';
import 'package:thoughts_creator/utils/AppString.dart';
import 'package:thoughts_creator/ui/SliderPreviewImageUI.dart';
import 'package:thoughts_creator/Model/PopularImageResponse.dart';

class PopularScreenUI extends StatefulWidget {
  @override
  _PopularScreenUIState createState() => _PopularScreenUIState();
}

class _PopularScreenUIState extends State<PopularScreenUI> {
  PreferenceHelper preferenceHelper;
  SharedPreferences prefs;
  final PopularImageController popularImageController =
      Get.put(PopularImageController());
  SavedCollectionController savedCollectionController =
  Get.put(SavedCollectionController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    savedCollectionController.selectedList.clear();
    checkInternetConnection();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PopularImageController(),
      builder: (PopularImageController controller) {

        print("popular===="+controller.list.length.toString());
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,

          body: new Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Obx(
                    () => controller.isLoading.value
                        ? Center(child: new CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor)))
                        : Container(
                            child: controller.list != null &&
                                    controller.list.length > 0
                                ? StaggeredGridView.countBuilder(
                                    crossAxisCount: 4,
                                    itemCount: controller.list.length,
                                    shrinkWrap: true,
                                    reverse: false,
                                    itemBuilder: (BuildContext context,
                                            int index) =>
                                        new Container(
                                            child: sliverGridWidget(
                                                context, index, controller)),
                                    staggeredTileBuilder: (int index) =>
                                        new StaggeredTile.count(
                                            2, index.isEven ? 2 : 3),
                                    mainAxisSpacing: 8.0,
                                    crossAxisSpacing: 8.0,
                                  )
                                : new Center(
                                    child: new Text(
                                      "Collection is empty!",
                                      style: TextStyle(
                                          fontSize: 24.0,
                                          color: AppColors.primaryColor),
                                    ),
                                  ),
                          ),
                  )),
              AppCommonFunc.admobBannerAd(context),
            ],
          ),
        );
      },
    );
  }
  checkInternetConnection() async {
    var notConnection = await (Connectivity().checkConnectivity());
    if (notConnection == ConnectivityResult.none) {
      _showDialog();
    } else {
    popularImageController.
    apiCallPopularTamplate();

    }
  }

  Widget sliverGridWidget(
      BuildContext context, index, PopularImageController controller) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: AppColors.primaryColor)),
          child: Material(
              borderRadius: BorderRadius.circular(3.0),
              elevation: 5.0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              type: MaterialType.transparency,
              child: InkWell(
                  child: Hero(
                      tag: index, // staticData[index].images,
                      child: FancyShimmerImage(
                        imageUrl: controller.imgNetworkPath +
                            "/" +
                            controller.list[index].img,
                        shimmerBaseColor: AppColors.hintColor,
                        shimmerHighlightColor: AppColors.hintColor,
                        shimmerBackColor: AppColors.hintColor,
                        errorWidget: null,
                      )),
                  onTap: () {
                    //
                    List<Src> tmpFilesArray = [];
                    for (int i = 0; i < controller.list.length; i++) {
                      tmpFilesArray.add(controller.list[i]);
                    }


                    Get.to(() => SliderPreviewImageUI([],tmpFilesArray,index,true,
                      imgPath: controller.imgNetworkPath,));

                  })),
        ),
      ),
    );
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
}
