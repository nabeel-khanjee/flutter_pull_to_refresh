import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var list;
  var random;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    random = Random();
    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      list = new List.generate(random.nextInt(10), (index) => "Item $index");
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Pull to refresh"),
      ),
      body: RefreshIndicator(
          key: refreshKey,
          child: ListView.builder(
              itemCount: list?.length,
              itemBuilder: (context, int index) => ListTile(
                    title: new Text(list[index]),
                  )),
          onRefresh: refreshList),
    );
  }
}
