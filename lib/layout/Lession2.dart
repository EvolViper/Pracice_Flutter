import 'package:flutter/material.dart';

void main(){
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter learning Layout',
      home: TutorialHome(),
    ),
  );
}

class TutorialHome extends StatelessWidget {
  const TutorialHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Materials Components.
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
            tooltip: 'Navigation menu',
            onPressed: null,
            icon: Icon(Icons.menu)
        ),
        title: const Text('Learning Using Material Components'),
        actions: const [
          IconButton(
              tooltip: 'Search',
              onPressed: null,
              icon: Icon(Icons.search)
          ),
        ],
      ),
      // body is the majority of the screen
      body: const Center(
        child: Text('Hello, Im learning Layout'),
      ),
      floatingActionButton: const FloatingActionButton(
          tooltip: 'Add', // used by assistive technologies
          child: Icon(Icons.add),
          onPressed: null),
    );
  }

}