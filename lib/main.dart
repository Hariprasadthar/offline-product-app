import 'package:flutter/material.dart';

import 'homepge.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PMS",
      home: HomePage(),
    );
  }
}
