# Flutter color picker package

A simple color picker package for your Flutter apps.

## Features

- Pick an RGB color.

## Usage

You can use [KolorPicker] as a normal widget, it is in fact a simple button.
You must give a callback function [onComplete] at least.
The button is by default a square containing an icon [Icons.colorize].
The button is customizable with [icon],[style],[width] and [height] parameters.
You can set an initial color with [initColor], by default it is [Colors.black].
The last picked color is saved and is automatically picked when you reopen the picker.

##### Example

```dart
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
        child: KolorPicker(onComplete: (c) => print("Picked color $c")),
      ),
    );
  }
}
```

A [BottomSheet] containing the color picker will be opened on [KolorPicker] button click.
The picked color is being returned thank to [onComplete] callback function.
