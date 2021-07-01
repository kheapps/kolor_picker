library kolor_picker;

import 'package:flutter/material.dart';

import 'src/picker_modal.dart';

class KolorPicker extends StatelessWidget {
  /// [KolorPicker] give you the possibility to pick a color RGB values.
  ///
  /// It gives you a button that trigger a [BottomSheet] modal in wich
  /// the user can choose a color. This color can be accessed thank to the
  /// [onComplete] callback function.
  ///

  const KolorPicker({
    Key? key,
    this.width = 50,
    this.height = 50,
    this.initColor = Colors.black,
    this.icon,
    this.style,
    @required this.onComplete,
  })  : assert(onComplete != null),
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

  /// Callback function to return selected color
  ///
  /// The [onComplete] function must not be null
  ///
  /// Paramaters : [Color c]
  /// return type void
  ///
  final void Function(Color)? onComplete;

  static const ButtonStyle _defaultStyle = ButtonStyle();

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
        style: style ?? _defaultStyle,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            enableDrag: true,
            builder: (ctx) => Container(
              child: PickerModal(
                onColorPicked: (c) {
                  onComplete!(c);
                  _pickedColor = c;
                  Navigator.pop(context);
                },
                initColor: _pickedColor,
              ),
            ),
          )
            ..onError((e, stackTrace) => _onError(e, stackTrace))
            ..whenComplete(() => _onComplete());
        },
      ),
    );
  }

  _onComplete() {
    print("modal closed");
  }

  _onError(e, stackTrace) {
    print("error" + e + " | " + stackTrace);
  }
}
