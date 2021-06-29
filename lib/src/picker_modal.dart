library picker_modal;

import 'package:flutter/material.dart';
import 'rgb_picker.dart';

class PickerModal extends StatefulWidget {
  final Color baseColor;
  final Function(Color)? onColorPicked;

  const PickerModal({
    Key? key,
    this.baseColor = Colors.greenAccent,
    this.onColorPicked,
  }) : super(key: key);

  @override
  _PickerModalState createState() => _PickerModalState(this.baseColor);
}

class _PickerModalState extends State<PickerModal> {
  Color _currentColor;

  _PickerModalState(this._currentColor);

  Color get currentColor => _currentColor;

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    final media = MediaQuery.of(context);
    double h = media.size.height;
    double bottomMargin = media.viewPadding.bottom;
    return Container(
      height: h * 0.67,
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 0,
        bottom: bottomMargin,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            // ? Preview selected color
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: _currentColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
            ),
            RGBPicker(
              onColorChange: (color) {
                setState(() {
                  _currentColor = color;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
