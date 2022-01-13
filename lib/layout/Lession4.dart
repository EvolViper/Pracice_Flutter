import 'package:flutter/material.dart';

class Counter extends StatefulWidget{
  const Counter({Key? key}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter>{
  int _counter = 0;

  void _increment(){
    setState(() {
      // This call to setState tells the Flutter framework
      // that something has changed in this State, which
      // causes it to rerun the build method below so that
      // the display can reflect the updated values. If you
      // change _counter without calling setState(), then
      // the build method won't be called again, and so
      // nothing would appear to happen.
      // (Dịch đoạn trên để biến công dụng của setState())
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
            onPressed: _increment,
            child: const Text('Increment'),
        ),
        const SizedBox(width: 16),
        Text('Count: $_counter'),
      ],
    );
  }
}

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Learning layout",
      home: Scaffold(
        body: Center(
          child: Counter(),
        ),
      ),
    )
  );
}