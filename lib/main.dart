import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const platform = MethodChannel('com.example/my_channel');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter & Kotlin Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: _callNativeFunctions,
            child: Text('Call Native Method'),
          ),
        ),
      ),
    );
  }

  // Function to call multiple native methods
  Future<void> _callNativeFunctions() async {
    try {
      // Call the first native function
      final int intResult = await platform.invokeMethod('getNativeInteger');
      print('Integer from native: $intResult');

      // Call the second native function
      final String stringResult =
          await platform.invokeMethod('getNativeString');
      print('String from native: $stringResult');

      // Call the third native function
      final bool boolResult = await platform.invokeMethod('getNativeBoolean');
      print('Boolean from native: $boolResult');
    } on PlatformException catch (e) {
      print("Failed to get result from native: '${e.message}'.");
    }
  }
}
