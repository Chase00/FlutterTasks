import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple,
    accentColor: Colors.blueAccent,
  ),
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List tasks = List();
  List saved = List();

  @override
  void initState() {
    tasks.add("Task");
    tasks.add("Task1");
    tasks.add("Task2");
    tasks.add("Task3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task List"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.star), onPressed: _pushSaved),
        ],
      ),
      body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (BuildContext content, int index) {
            return Card(
                elevation: 20,
                child: ListTile(
                  leading: Icon(
                    Icons.star_border,
                    size: 30,
                    color: Colors.white30,
                  ),
                  trailing: Icon(
                    Icons.delete,
                    size: 30,
                    color: Colors.grey,
                  ),
                  title: Text(tasks[index]),
//                  onTap: () {
//                    Navigator.push(context, MaterialPageRoute(
//                        builder: (context) => ClassInfo(classInfo: course.getCode(index),)));
//                  },
                )
            );
          }),
    );
  }
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = saved.map(
                (tasks) {
              return ListTile(
                title: Text(
                  tasks,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('Priority Tasks'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}