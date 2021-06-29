library kolor_slider;

import 'package:flutter/material.dart';

class KolorSlider extends StatefulWidget {
  /// Custom slider for color picking
  /// with a gradient background to preview color changes
  ///

  KolorSlider({
    Key? key,
    this.width = 250,
    this.height = 13,
    this.min = 0,
    this.max = 255,
    this.indicatorColor = Colors.white,
    @required this.colors,
    @required this.onChanged,
  })  : assert(onChanged != null),
        assert(colors != null && colors.length >= 2),
        assert(min <= max),
        super(key: key);

  /// The [width] of the slider
  ///
  /// Default value = 250
  final double width;

  /// The [height] of the slider
  ///
  /// Default value = 16
  ///
  /// The indicator will be sized following this value,
  /// it's size will be : [height] * 1.5
  ///
  final double height;

  /// Minimum value of the slider
  ///
  /// Default value = 0
  ///
  final int min;

  /// Maximum value of the slider
  ///
  /// Default value = 255
  ///
  final int max;

  /// Colors list that will compose the background gradient
  ///
  /// This parameter can't be null and must be composed of two colors at least.
  ///
  final List<Color>? colors;

  /// Color of the slider indicator
  ///
  /// This value can be null, the default value will be [Colors.white]
  ///
  final Color indicatorColor;

  /// Called during a drag when the user is selecting a new value for the slider
  /// by dragging.
  ///
  /// The slider passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the slider with the new
  /// value.
  ///
  ///This callback function is required.
  ///
  final Function(int)? onChanged;

  @override
  _KolorSliderState createState() => _KolorSliderState();
}

class _KolorSliderState extends State<KolorSlider> {
  double _colorSliderPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    final w = widget.width;
    final h = widget.height;
    final indicatorRadius = (h * 1.5) / 2;

    return Container(
      margin: EdgeInsets.all(15),
      height: h * 2,
      width: w + indicatorRadius * 2,
      alignment: Alignment.center,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragStart: (DragStartDetails details) {
          _colorChangeHandler(details.localPosition.dx - indicatorRadius / 2);
        },
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          _colorChangeHandler(details.localPosition.dx - indicatorRadius / 2);
        },
        onTapDown: (TapDownDetails details) {
          _colorChangeHandler(details.localPosition.dx - indicatorRadius / 2);
        },
        child: Center(
          // ? SLIDER
          child: Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueGrey[700]!,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(h / 2),
              gradient: LinearGradient(colors: widget.colors!),
            ),
            child: CustomPaint(
              painter: _SliderIndicatorPainter(
                _colorSliderPosition,
                indicatorRadius,
                widget.indicatorColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _colorChangeHandler(double position) {
    //handle out of bounds positions
    if (position > widget.width) {
      position = widget.width;
    }
    if (position < 0) {
      position = 0;
    }
    _colorSliderPosition = position;
    // 0 -> min
    // width -> max
    // pos -> value = (pos*(max-min) / width) + min
    int value =
        (position * (widget.max - widget.min) ~/ widget.width) + widget.min;
    widget.onChanged!(value);
  }
}

// ? SLIDER INDICATOR
class _SliderIndicatorPainter extends CustomPainter {
  _SliderIndicatorPainter(this.position, this.radius, this.color);

  final double position;
  final double radius;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // * Background border
    double y = size.height / 2;
    canvas.drawCircle(
      Offset(position, y),
      radius,
      Paint()..color = Colors.blueGrey[700]!,
    );
    // * Indicator front circle
    canvas.drawCircle(
      Offset(position, y),
      radius * 0.9,
      Paint()..color = this.color,
    );
  }

  @override
  bool shouldRepaint(_SliderIndicatorPainter old) {
    return true;
  }
}


  // Some parts of this widget code is from : https://medium.com/@mhstoller.it/how-i-made-a-custom-color-picker-slider-using-flutter-and-dart-e2350ec693a1