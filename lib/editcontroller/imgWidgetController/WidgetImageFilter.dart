import 'package:flutter/material.dart';
import 'package:thoughts_creator/utils/ColorFilterGenerator.dart';

class WidgetImageFilter extends StatelessWidget {

  final double brightness;
  final double saturation;
  final double hue;
  final Widget child;


  WidgetImageFilter({this.brightness, this.saturation, this.hue, this.child});


  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
        colorFilter: ColorFilter.matrix(
            ColorFilterGenerator.brightnessAdjustMatrix(
              value: brightness,
            )
        ),
        child: ColorFiltered(
            colorFilter: ColorFilter.matrix(
                ColorFilterGenerator.saturationAdjustMatrix(
                  value: saturation,
                )
            ),
            child: ColorFiltered(
              colorFilter: ColorFilter.matrix(
                  ColorFilterGenerator.hueAdjustMatrix(
                    value: hue,
                  )
              ),
              child: child,
            )
        )
    );
  }
}
