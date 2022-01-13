import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning Icon Widget',
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    ),
  );
}

class MyWidget extends StatelessWidget{
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/anh-troll-4.jpg',width: 100,),
        Spacer(flex: 1,),
        Image.network('https://raw.githubusercontent.com/flutter/website/master/examples/layout/sizing/images/pic1.jpg'),
      ],
    );
  }
}