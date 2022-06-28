import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thoughts_creator/controller/CommonEditorController.dart';
import 'package:thoughts_creator/controller/RatioController.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/AppString.dart';

// ignore: camel_case_types
class widgetBackgroundImageContainer extends StatelessWidget {
  final GestureTapCallback onPressed;

  final Function(String) onBgImageChange;

  widgetBackgroundImageContainer({this.onPressed, this.onBgImageChange});

  final List<String> bgImageList = <String>[
    AppString.bgTemplateAssetPath + "img1.png",
    AppString.bgTemplateAssetPath + "img2.png",
    AppString.bgTemplateAssetPath + "img3.png",
    AppString.bgTemplateAssetPath + "img4.png",
    AppString.bgTemplateAssetPath + "img5.png",
    AppString.bgTemplateAssetPath + "img6.png",
    AppString.bgTemplateAssetPath + "img7.png",
    AppString.bgTemplateAssetPath + "img8.png",
  ];

  final List<String> bgTemplateList = <String>[
    AppString.bgTemplateAssetPath + "temp1.png",
    AppString.bgTemplateAssetPath + "temp2.png",
    AppString.bgTemplateAssetPath + "temp3.png",
    AppString.bgTemplateAssetPath + "temp4.png",
    AppString.bgTemplateAssetPath + "temp5.png",
    AppString.bgTemplateAssetPath + "temp6.png",
    AppString.bgTemplateAssetPath + "temp7.png",
    AppString.bgTemplateAssetPath + "temp8.png",
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CommonEditorController(),
      builder: (CommonEditorController commonEditorController) {
        return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: commonEditorController.isNoDataApi
                    ? 0
                    : commonEditorController.sizeRatioBgImage.img.length,
                itemBuilder: (context, index) {
                  print("size===" +
                      commonEditorController.sizeRatioBgImage.img
                          .toString());

                  if (commonEditorController.sizeRatioBgImage.img.length !=
                      null &&
                      commonEditorController.sizeRatioBgImage.img.length >
                          0) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            commonEditorController.replaceImage(null);
                            onBgImageChange(commonEditorController
                                .getBgImageResponse.data.path +
                                commonEditorController.ratioValueKeyThumb +
                                commonEditorController
                                    .sizeRatioBgImage.img[index].img);

                            if (commonEditorController.isNoDataApi) {
                              commonEditorController.updateImageBgPath(
                                  AppString.NoApiImageNetwork);
                            } else {
                              commonEditorController.updateImageBgPath(
                                  commonEditorController
                                      .getBgImageResponse.data.path +
                                      commonEditorController
                                          .ratioValueKeyThumb +
                                      commonEditorController
                                          .sizeRatioBgImage.img[index].img);
                            }
                          },
                          child: GetBuilder(
                            init: RatioController(),
                            builder: (RatioController ratioController) {
                              return AspectRatio(
                                aspectRatio: ratioController.ratioX /
                                    ratioController.ratioY,
                                child: Container(
                                  width: 60.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.white, width: 1.0),

                                  ),
                                  child:  FancyShimmerImage(
                                    imageUrl: commonEditorController
                                        .getBgImageResponse
                                        .data
                                        .path +
                                        commonEditorController
                                            .ratioValueKeyDisplay +
                                        commonEditorController
                                            .sizeRatioBgImage
                                            .img[index]
                                            .img
                                    ,
                                    shimmerBaseColor: AppColors.hintColor,
                                    shimmerHighlightColor: AppColors.hintColor,
                                    shimmerBackColor: AppColors.hintColor,
                                    errorWidget: null,

                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  } else {
                    print("hewloo ");
                    return new Center(
                      child: new Text(
                        "Recently not Available Images!",
                        style: TextStyle(
                            fontSize: 24.0, color: AppColors.white),
                      ),
                    );
                  }
                });
      },
    );
  }
}