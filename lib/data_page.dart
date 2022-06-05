import 'package:flutter/material.dart';

class TextPage extends StatelessWidget {
  static const String routeName = '/test-page';
  TextPage({Key? key}) : super(key: key);
  void _test() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test App'),
      ),
      body: Center(
        child: Expanded(
          child: Column(
            children: [
              Text(
                'Hello World',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                  decorationStyle: TextDecorationStyle.dashed,
                ),
              ),
              TextButton(
                onPressed: _test,
                child: Text(
                  'Click me',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
