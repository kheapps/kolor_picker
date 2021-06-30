library picker_modal;

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'rgb_picker.dart';

class PickerModal extends StatelessWidget {
  const PickerModal({
    Key? key,
    this.initColor = Colors.black,
    @required this.onColorPicked,
  })  : assert(onColorPicked != null),
        super(key: key);

  /// The initial color of the picker
  ///
  /// Default value [initColor] = [Colors.black]
  ///
  final Color initColor;

  /// Callback function [onColorPicked]
  /// is called when users click on the
  /// button to confirm their choice.
  ///
  final void Function(Color)? onColorPicked;

  @override
  Widget build(BuildContext context) {
    Color _currentColor = initColor;
    final bottomMargin = MediaQuery.of(context).viewPadding.bottom;
    return Container(
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
                color: Colors.black38,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            Expanded(
              child: RGBPicker(
                initColor: _currentColor,
                onColorChange: (color) {
                  _currentColor = color;
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: OutlinedButton(
                onPressed: () => onColorPicked!(_currentColor),
                child: Text('Ok'),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
