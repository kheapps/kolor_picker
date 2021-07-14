import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kolor_picker/kolor_picker.dart';
import 'package:kolor_picker/src/kolor_slider.dart';
import 'package:kolor_picker/src/picker_modal.dart';
import 'package:kolor_picker/src/rgb_picker.dart';

void main() {
  testWidgets(
    'Kolor picker button test',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: KolorPicker(onColorPicked: (c) {}),
            ),
          ),
        ),
      );

      print("Test presence button");
      final kolorBtn = find.widgetWithIcon(OutlinedButton, Icons.colorize);
      expect(kolorBtn, findsOneWidget);
    },
  );

  testWidgets(
    'Kolor picker modal test',
    (WidgetTester tester) async {
      const initColor = 0xff030507;
      const modifiedColor = 0xff7f0507;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: PickerModal(
                onColorPicked: (c) {},
                initColor: Color(initColor),
              ),
            ),
          ),
        ),
      );

      print("Test presence picker");
      expect(find.byType(RGBPicker), findsOneWidget);

      print("Test presence sliders");
      final sliders = find.byType(KolorSlider);
      expect(sliders, findsNWidgets(4));

      print("Test presence texts");
      final texts = find.byType(Text);
      expect(texts, findsNWidgets(10));

      print("Test value initColor");
      expect(find.text('#${initColor.toRadixString(16)}'), findsOneWidget);

      final redValue = (texts.at(2).evaluate().first.widget as Text).data;
      final greenValue = (texts.at(4).evaluate().first.widget as Text).data;
      final blueValue = (texts.at(6).evaluate().first.widget as Text).data;
      final alphaValue = (texts.at(8).evaluate().first.widget as Text).data;
      print("Test red value");
      expect(redValue, "3");
      print("Test green value");
      expect(greenValue, "5");
      print("Test blue value");
      expect(blueValue, "7");
      print("Test alpha value");
      expect(alphaValue, "255");

      final redSlider = find
          .descendant(
            of: find.byType(KolorSlider),
            matching: find.byType(GestureDetector),
          )
          .at(0);

      await tester.tapAt(tester.getCenter(redSlider).translate(5, 0));
      await tester.pump(Duration(seconds: 1));

      print("Test tap at center of slider changes color");
      final redText =
          (find.byType(Text).at(2).evaluate().first.widget as Text).data;
      expect(redText, "127");
      expect(find.text("#${modifiedColor.toRadixString(16)}"), findsOneWidget);
    },
  );
}
