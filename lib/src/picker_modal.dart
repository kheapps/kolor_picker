library picker_modal;

import 'package:flutter/material.dart';
import 'rgb_picker.dart';

class PickerModal extends StatelessWidget {
  const PickerModal({
    Key? key,
    this.initColor = Colors.black,
    this.useAppTextTheme = false,
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
  Widget build(BuildContext context) {
    Color _currentColor = initColor;
    final bottomMargin = MediaQuery.of(context).viewPadding.bottom;
    return Container(
      height: 900,
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 0,
        bottom: bottomMargin,
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 50,
            height: 5,
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          Expanded(
            child: RGBPicker(
              useAppTextTheme: useAppTextTheme,
              initColor: initColor,
              onColorChange: (color) {
                _currentColor = color;
              },
            ),
          ),
          SizedBox(height: 20),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: OutlinedButton(
              onPressed: () => onColorPicked!(_currentColor),
              child: Text('Ok'),
            ),
          ),
        ],
      ),
    );
  }
}
