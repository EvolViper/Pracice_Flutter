import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{
  const MyButton({Key?key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print("MyButton was tapped!");
      },
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightBlue,
        ),
        child: const Center(
          child: Text('Engage'),
        ),
      ),
    );
  }

}

void main(){
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyButton(),
        ),
      ),
    )
  );
}