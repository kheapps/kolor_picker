import 'package:flutter/material.dart';

import 'kolor_slider.dart';

class RGBPicker extends StatefulWidget {
  const RGBPicker({
    Key? key,
    @required this.onColorChange,
    this.initColor = Colors.black,
  })  : assert(onColorChange != null),
        super(key: key);

  /// The initial color of the picker
  ///
  /// Default value [initColor] = [Colors.black]
  ///
  final Color initColor;

  /// Callback function [onColorChange]
  /// is called when users update one of the sliders value.
  ///
  final void Function(Color)? onColorChange;

  @override
  _RGBPickerState createState() => _RGBPickerState();
}

class _RGBPickerState extends State<RGBPicker> {
  int _r = 0, _g = 0, _b = 0;

  @override
  void initState() {
    _r = widget.initColor.red;
    _g = widget.initColor.green;
    _b = widget.initColor.blue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ? Preview selected color
          Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey[700]!, width: 1),
              color: Color.fromARGB(255, _r, _g, _b),
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
          ),
          SizedBox(height: 30),
          KolorSlider(
            initValue: _r,
            colors: [
              Color.fromARGB(255, 0, _g, _b),
              Color.fromARGB(255, 255, _g, _b)
            ],
            label: 'R',
            onChanged: (v) {
              _r = v;
              _updateColor();
            },
          ),
          KolorSlider(
            initValue: _g,
            colors: [
              Color.fromARGB(255, _r, 0, _b),
              Color.fromARGB(255, _r, 255, _b)
            ],
            label: 'G',
            onChanged: (v) {
              _g = v;
              _updateColor();
            },
          ),
          KolorSlider(
            initValue: _b,
            colors: [
              Color.fromARGB(255, _r, _g, 0),
              Color.fromARGB(255, _r, _g, 255)
            ],
            label: 'B',
            onChanged: (v) {
              _b = v;
              _updateColor();
            },
          )
        ],
      ),
    );
  }

  _updateColor() {
    setState(() {
      widget.onColorChange!(Color.fromARGB(255, _r, _g, _b));
    });
  }
}
