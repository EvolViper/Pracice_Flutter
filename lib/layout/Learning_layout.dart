import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning Layout And Widget',
      home: SafeArea(
          child: MyScaffold()
      ),
    ),
  );
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({required this.title, Key? key}): super(key:key);

  // Fields in a widget subclass are always marked "final".
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      // Row is a horizontal, linear layout.
      child: Row(
        // <Widget> is the type of items in the list.
        children: [
          const IconButton(
              onPressed: null, // null to disable the button
              tooltip: 'Navigation menu',
              icon: Icon(Icons.menu),
          ),
          Expanded(
              child: title
          ),
          const IconButton(
              tooltip: 'Search',
              onPressed: null,
              icon: Icon(Icons.search),
          ),
        ],
      ),
    );
  }

}

class MyScaffold extends StatelessWidget{
  const MyScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    return Material(
      // Column is a vertical, linear layou.
      child: Column(
        children: [
          MyAppBar(
              title: Text('Learning Layout(introduction of widget)',
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline6
              ),
          ),
          const Expanded(
            child: Center(
              child: Text('Hello, Firstime learning flutter widget and layout'),
            ),
          ),
        ],
      ),
    );
  }
}