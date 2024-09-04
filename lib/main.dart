import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:methodechannel/data/post.dart';
import 'package:methodechannel/widgets/custome_list.dart';

void main() {
  runApp(MyApp2());
}

class MyApp2 extends StatefulWidget {
  const MyApp2({super.key});

  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  static const platform = MethodChannel('com.example/my_channel');
  String _data = 'Fetching data...';

  List<Post> _posts = [];
  String _error = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchApiData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter & Kotlin Example'),
        ),
        // body: Center(
        //   child: SingleChildScrollView(
        //     padding: EdgeInsets.all(16.0),
        //     child: Text(
        //       _data,
        //       style: TextStyle(fontSize: 16),
        //     ),
        //   ),
        // ),
        body: _error.isNotEmpty
            ? Center(child: Text(_error))
            : ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final post = _posts[index];
                  return CustomListItem(post: post);
                },
              ),
      ),
    );
  }

  Future<void> _fetchApiData() async {
    try {
      final String result = await platform.invokeMethod('fetchApiData');
      final List<dynamic> data = json.decode(result);

      setState(() {
        _posts = data.map((item) => Post.fromJson(item)).toList();
      });
    } on PlatformException catch (e) {
      setState(() {
        _error = 'Failed to fetch data: ${e.message}';
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to parse data: ${e.toString()}';
      });
    }
  }

//   Future<void> _fetchApiData() async {
//     try {
//       final String result = await platform.invokeMethod('fetchApiData');
//       setState(() {
//         _data = result;
//       });
//     } on PlatformException catch (e) {
//       setState(() {
//         _data = 'Failed to fetch data: ${e.message}';
//       });
//     }
//   }
// }
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
