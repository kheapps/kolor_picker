import 'package:flutter/material.dart';

import 'package:kolor_picker/kolor_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                fontFamily: 'Rubik',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
              bodyText2: TextStyle(
                fontFamily: 'Rubik',
                color: Colors.blueGrey,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
                fontSize: 15,
              ),
            ),
      ),
      home: MyHomePage(title: 'kolor_picker example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: KolorPicker(
          onComplete: (c) => print("Picked color $c"),
          // useAppTextTheme: true,
        ),
      ),
    );
  }
}
