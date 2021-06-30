library kolor_picker;

import 'package:flutter/material.dart';

import 'src/picker_modal.dart';

class KolorPicker extends StatelessWidget {
  const KolorPicker({
    Key? key,
    this.title,
    this.initColor = Colors.black,
    this.style,
    @required this.onComplete,
  })  : assert(onComplete != null),
        super(key: key);

  final String? title;
  final Color initColor;
  final ButtonStyle? style;
  final void Function(Color)? onComplete;

  static const ButtonStyle _defaultStyle = ButtonStyle();

  @override
  Widget build(BuildContext context) {
    Color _pickedColor = initColor;
    return ElevatedButton(
      child: Text(title ?? 'Open'),
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
    );
  }

  _onComplete() {
    print("modal closed");
  }

  _onError(e, stackTrace) {
    print("error" + e + " | " + stackTrace);
  }
}
