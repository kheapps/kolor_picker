library kolor_picker;

import 'dart:async';

import 'package:flutter/material.dart';

import 'src/picker_modal.dart';

class KolorPicker extends StatelessWidget {
  /// [KolorPicker] give you the possibility to pick a color RGB values.
  ///
  /// It gives you a button that trigger a [BottomSheet] modal in wich
  /// the user can choose a color. This color can be accessed thank to the
  /// [onColorPicked] callback function.
  ///

  KolorPicker({
    Key? key,
    this.width = 50,
    this.height = 50,
    this.initColor = Colors.black,
    this.icon,
    this.style,
    this.useAppTextTheme = false,
    @required this.onColorPicked,
    this.onComplete,
    this.onError,
  })  : assert(onColorPicked != null),
        super(key: key);

  /// Set the [width] of the button that trigger the picker.
  ///
  final double? width;

  /// Set the [height] of the button that trigger the picker.
  ///
  final double? height;

  /// The initial color that is selected
  ///
  /// Default value [Colors.black]
  ///
  final Color initColor;

  /// Set the [icon] of picker button.
  ///
  /// Default icon is [Icons.colorize].
  ///
  final Icon? icon;

  /// Customize the style of the button that trigger the picker.
  ///
  /// Passing a [style] is not required, a default one is already available.
  ///
  final ButtonStyle? style;

  /// If true the text will use your application custom [textTheme]
  ///
  /// The slider label ('R', 'G', 'B') will use [textTheme.bodyText1]
  ///
  /// The slider value and picked color hex value will use [textTheme.bodyText2]
  ///
  /// By default it is false, it will use a default textTheme.
  ///
  final bool useAppTextTheme;

  /// Callback function to return selected color
  ///
  /// The [onColorPicked] function must not be null
  ///
  /// Paramaters : [Color c]
  /// Return type : void
  ///
  final void Function(Color)? onColorPicked;

  /// Default [onComplete] of [showModalBottomSheet]
  ///
  final Future<void> Function()? onComplete;

  /// Default [onError] of [showModalBottomSheet]
  ///
  final FutureOr<dynamic> Function(Object, StackTrace)? onError;

  final _history = <Color>[];

  @override
  Widget build(BuildContext context) {
    Color _pickedColor = initColor;
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: ElevatedButton(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: icon ??
              Icon(
                Icons.colorize,
                size: 20,
              ),
        ),
        style: style,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            enableDrag: true,
            builder: (ctx) => Container(
              child: PickerModal(
                history: _history,
                useAppTextTheme: useAppTextTheme,
                onColorPicked: (c) {
                  onColorPicked!(c);
                  _pickedColor = c;
                  // * we keep only one occurence of a color
                  if (_history.contains(c)) _history.remove(c);
                  _history.add(c);
                  if (_history.length > 5) _history.removeAt(0);
                  // * Close the bottom sheet modal
                  Navigator.pop(context);
                },
                initColor: _pickedColor,
              ),
            ),
          )
            ..onError(onError ?? (e, stackTrace) {})
            ..whenComplete(onComplete ?? () {});
        },
      ),
    );
  }
}
