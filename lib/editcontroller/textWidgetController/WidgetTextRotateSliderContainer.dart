import 'package:flutter/material.dart';
import 'package:thoughts_creator/utils/AppColors.dart';

class WidgetTextRotateSliderContainer extends StatelessWidget {

  final double valueSize;

  final Function(double) onChangeValueSize;

  WidgetTextRotateSliderContainer({@required this.valueSize,@required this.onChangeValueSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
                child:  Slider(
                  min: 0.0,
                  max: 7.0,
                  activeColor: AppColors.white,
                  inactiveColor: AppColors.hintColor,
                  value: valueSize,
                  onChanged: (value) {
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

