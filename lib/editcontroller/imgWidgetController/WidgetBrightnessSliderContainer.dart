import 'package:flutter/material.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/AppString.dart';

// ignore: must_be_immutable
class WidgetBrightnessSliderContainer extends StatelessWidget {

  final double valueSize;

  final Function(double,) onChangeValueSize;
   String imageTypeSlider=AppString.txtBrightness;

  WidgetBrightnessSliderContainer({@required this.valueSize,@required this.imageTypeSlider,@required this.onChangeValueSize});

    double minVal;
    double maxVal;



  @override
  Widget build(BuildContext context) {
    if(imageTypeSlider==AppString.txtBrightness){
      minVal=-0.5;
      maxVal=1.4;
    }else if(imageTypeSlider==AppString.txtSaturation){
      minVal=-1.0;
      maxVal=1.0;
    }else if(imageTypeSlider==AppString.txtHUE){
      minVal=-1.0;
      maxVal=1.0;
    }
    return Container(
      child: new Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
                child:  Slider(
                  min: minVal,
                  max: maxVal,
                  activeColor: AppColors.white,
                  inactiveColor: AppColors.hintColor,
                  value: valueSize,
                  onChanged: (value,) {
                    onChangeValueSize(value);
                  },
                )),
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Visibility(
              visible: false,
              child: Text(
                valueSize.toStringAsFixed(0),
                style: TextStyle(fontSize: 18,color: AppColors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

