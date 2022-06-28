import 'package:flutter/material.dart';
import 'package:thoughts_creator/utils/AppColors.dart';

class WidgetTextSizeSliderContainer extends StatelessWidget {

  final double valueSize;

  final Function(double) onChangeValueSize;

  WidgetTextSizeSliderContainer({@required this.valueSize,@required this.onChangeValueSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Row(
        children: [

          Expanded(
            flex: 1,
            child: Container(
                child:  Slider(
                  min: 8.0,
                  max: 30.0,
                  activeColor: AppColors.white,
                  inactiveColor: AppColors.black,
                  value: valueSize,
                  onChanged: (value) {
                    onChangeValueSize(value);
                  },
                )),
          ),
          Text(
            valueSize.toStringAsFixed(1),
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}

