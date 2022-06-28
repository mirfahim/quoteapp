import 'package:flutter/material.dart';
import 'package:thoughts_creator/utils/AppColors.dart';

import 'package:vector_math/vector_math_64.dart';

class ImgScreen extends StatefulWidget {
  @override
  _ImgScreenState createState() => _ImgScreenState();
}

class _ImgScreenState extends State<ImgScreen> {

 // double _x=0.0;
 // double _y=0.0;

  double _scale = 1.0;
  double _previousScale;
  var yOffset = 400.0;
  var xOffset = 50.0;
  var rotation = 0.0;
  var lastRotation = 0.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: AppColors.dividerColor,
          child: Stack(
            children: [
                  Positioned.fromRect(
                  rect: Rect.fromPoints( Offset(xOffset, yOffset),
                    Offset(xOffset+100.0, yOffset+200.0)),
                child: GestureDetector(


                  onScaleStart: (scaleDetails) {
                    _previousScale = _scale;
                    print(' scaleStarts = ${scaleDetails.focalPoint}');
                  },
                  onScaleUpdate: (scaleUpdates){
                    //ScaleUpdateDetails
                    rotation += lastRotation - scaleUpdates.rotation;
                    lastRotation = scaleUpdates.rotation;
                    print("lastRotation = $lastRotation");
                    print(' scaleUpdates = ${scaleUpdates.scale} rotation = ${scaleUpdates.rotation}');
                    setState(() => _scale = _previousScale * scaleUpdates.scale);
                  },
                  onScaleEnd: (scaleEndDetails) {
                    _previousScale = null;
                    print(' scaleEnds = ${scaleEndDetails.velocity}');
                  },
                  child:
                  Transform(
                    transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale))..rotateZ(rotation * 3.14/180.0),
                    alignment: FractionalOffset.center,
                    child: Container(

                      color: AppColors.black,
                    ),
                  )
                  ,
                )),
             /* Positioned(
                left: _x,
                top: _y,
                child: Draggable(


                  childWhenDragging: new Container(

                  ),
                  onDragEnd: (dragDetails) {

                    setState(() {
                      _x = dragDetails.offset.dx;
                      // if applicable, don't forget offsets like app/status bar
                      _y = dragDetails.offset.dy ;
                    });

                    print("tap down " + _x.toString() + ", " + _y.toString());
                  }, feedback: new Container(
                    height: 100,width: 100,
                    color: AppColors.black,
                  ),
                  child: new Container(
                    height: 100,width: 100,
                    color: AppColors.black,
                  ),
                ),
              ),*/
            ],

          ),
        ),
      ),
    );
  }
}


class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  double _x=50;
  double _y=100;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Positioned(
          left: _x,
          top: _y,
          child: Draggable(

            childWhenDragging: new Container(
              height: 100,width: 100,
              color: AppColors.black,
            ),
            onDragEnd: (dragDetails) {

              setState(() {
                _x = dragDetails.offset.dx;
                // if applicable, don't forget offsets like app/status bar
                _y = dragDetails.offset.dy - 120 - 20;
              });


            }, feedback: new Container(

            child: new Container(
              height: 100,width: 100,
              color: AppColors.black,
            ),
          ),
            child: new Container(
            height: 100,width: 100,
            color: AppColors.black,
          ),
          ),
        ),
      ),
    );
  }

  /*_onTapDown(TapDownDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    // or user the local position method to get the offset
    print(details.localPosition);
    print("tap down " + x.toString() + ", " + y.toString());
  }

  _onTapUp(TapUpDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    // or user the local position method to get the offset
    print(details.localPosition);
    print("tap up " + x.toString() + ", " + y.toString());
  }*/


}
