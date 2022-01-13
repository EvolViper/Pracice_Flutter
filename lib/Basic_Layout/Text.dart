import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main(){
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.lightBlue,
      title: 'Text Widget',
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    )
  );
}

class MyWidget extends StatelessWidget{
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Hey!',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Great Vibes',
            color: Colors.purpleAccent,
          ),
        ),
        Spacer(flex: 2,),
        Text(
          'Hey!',
          style: TextStyle(
              fontSize: 50,
              fontFamily: 'Roboto',
              color: Colors.green,
          ),
        ),
        Spacer(flex: 2,),
        Text(
          'Hey!',
          style: TextStyle(
              fontSize: 80,
              fontFamily: 'Futura',
              color: Colors.pink,
          ),
        ),
      ],
    );
  }

}