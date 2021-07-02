import 'package:flutter/material.dart';

import 'kolor_slider.dart';

import 'styles.dart';

class RGBPicker extends StatefulWidget {
  const RGBPicker({
    Key? key,
    @required this.onColorChange,
    this.initColor = Colors.black,
    this.useAppTextTheme = false,
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

  /// If true the text will use your application custom [textTheme]
  ///
  /// The slider label ('R', 'G', 'B') will use [textTheme.bodyText1]
  ///
  /// The slider value and picked color hex value will use [textTheme.bodyText2]
  ///
  /// By default it is false, it will use a default textTheme.
  ///
  final bool useAppTextTheme;

  @override
  _RGBPickerState createState() => _RGBPickerState();
}

class _RGBPickerState extends State<RGBPicker> {
  int _r = 0, _g = 0, _b = 0, _a = 0;

  @override
  void initState() {
    _a = widget.initColor.alpha;
    _r = widget.initColor.red;
    _g = widget.initColor.green;
    _b = widget.initColor.blue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ? Preview selected color
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey[700]!, width: 1),
                color: Color.fromARGB(_a, _r, _g, _b),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
            ),
            Text(
              '#' + Color.fromARGB(_a, _r, _g, _b).value.toRadixString(16),
              style:
                  widget.useAppTextTheme ? textTheme.bodyText2 : valueTextStyle,
            ),
            SizedBox(height: 10),
            KolorSlider(
              initValue: _r,
              useAppTextTheme: widget.useAppTextTheme,
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
              useAppTextTheme: widget.useAppTextTheme,
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
              useAppTextTheme: widget.useAppTextTheme,
              colors: [
                Color.fromARGB(255, _r, _g, 0),
                Color.fromARGB(255, _r, _g, 255)
              ],
              label: 'B',
              onChanged: (v) {
                _b = v;
                _updateColor();
              },
            ),
            KolorSlider(
              initValue: _a,
              useAppTextTheme: widget.useAppTextTheme,
              colors: [
                Color.fromARGB(0, 0, 0, 0),
                Color.fromARGB(255, 0, 0, 0)
              ],
              label: 'A',
              onChanged: (v) {
                _a = v;
                _updateColor();
              },
            )
          ],
        ),
      ),
    );
  }

  _updateColor() {
    setState(() {
      widget.onColorChange!(Color.fromARGB(_a, _r, _g, _b));
    });
  }
}
