import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning Basic Layout',
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    ),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // Learning MainAxisAlignment
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // Learnin CrossAxisAlignment
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlueBox(),
        BlueBox(),
        BlueBox(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Learning Expanded
            Expanded(child: BlueBox(),),
            // Learning Flexible
            Flexible(
              fit: FlexFit.tight,
              flex: 10,
              child: BiggerBlueBox(),
            ),
            Flexible(
              fit: FlexFit.loose,
              flex: 10,
              child: BlueBox(),
            ),
            // Learning SizedBox
            SizedBox(
              width: 100,
              child: BiggerBlueBox(),
            ),
            BlueBox(),
            SizedBox(width: 170),
            BiggerBlueBox(),
            // Learning Spacer
            Spacer(flex: 10,),
            BlueBox(),
          ],
        ),
      ],
    );
  }
}

class BlueBox extends StatelessWidget {
  const BlueBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.purpleAccent,
        border: Border.all(),
      ),
    );
  }
}

class BiggerBlueBox extends StatelessWidget {
  const BiggerBlueBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        border: Border.all(),
      ),
    );
  }
}
