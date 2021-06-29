library kolor_picker;

import 'package:flutter/material.dart';

import 'src/picker_modal.dart';

class KolorPicker extends StatelessWidget {
  final String title;
  final ButtonStyle? style;
  final Function(Color)? onComplete;

  static const ButtonStyle _defaultStyle = ButtonStyle();

  const KolorPicker({
    Key? key,
    this.title = '',
    this.style = _defaultStyle,
    this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: (title != '') ? Text(title) : Text("Open"),
        style: style,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            enableDrag: true,
            builder: (ctx) => PickerModal(
              onColorPicked: _onColorPicked,
            ),
          )
            ..onError((e, stackTrace) => _onError(e, stackTrace))
            ..whenComplete(() => _onComplete());
        },
      ),
    );
  }

  _onColorPicked(Color c) {
    print("chosen color : " + c.toString());
  }

  _onComplete() {
    print("modal closed");
  }

  _onError(e, stackTrace) {
    print("error" + e + " | " + stackTrace);
  }
}
