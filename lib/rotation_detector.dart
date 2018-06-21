/*
*
* Copyright 2018 Diogo Nunes
* 
* Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
* 
*/

library rotation_detector;

import 'package:flutter/material.dart';
import 'dart:math';

class RotationDetector extends StatefulWidget {
  final double width;
  final double height;
  final Widget child;

  RotationDetector({this.child, this.width, this.height});

  @override
  _RotationDetectorState createState() => new _RotationDetectorState();
}

class _RotationDetectorState extends State<RotationDetector> {
  double angle = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onPanUpdate: onPanUpdate,
      child: Transform.rotate(
        angle: angle,
        child: widget.child,
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails pan) {
    RenderBox box = context.findRenderObject();
    var localOffset = box.globalToLocal(pan.globalPosition);

    var x = localOffset.dx - box.size.width / 2;
    var y = localOffset.dy - box.size.height / 2;
    var dx = x + pan.delta.dx;
    var dy = y + pan.delta.dy;

    var deltaAngle = atan2(dy, dx) - atan2(y, x);

    setState(() => angle += deltaAngle);
  }
}
