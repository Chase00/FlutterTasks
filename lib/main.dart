import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple,
    accentColor: Colors.deepPurple,
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
  String input = "";

  @override
  void initState() {
    tasks.add("Cook Dinner");
    tasks.add("Fold laundry");
    tasks.add("Finish unfinished projects");
    tasks.add("Do jumping jacks");
    tasks.add("Complete Flutter solo project");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task List"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.star), onPressed: _pushStarred),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(borderRadius:
                BorderRadius.circular(8)),
                title: Text("Add Task"),
                content: TextField(
                  onChanged: (String value) {
                    input = value;
                  },
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        tasks.add(input);
                      });
                      Navigator.of(context).pop();
                    },
                  child: Text("Add"))
                ],
              );
            }
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(tasks[index]),
            child: Card(
              elevation: 3,
              margin: EdgeInsets.all(6),
              shape: RoundedRectangleBorder(borderRadius:
              BorderRadius.circular(8)),
              child: ListTile(
                title: Text(tasks[index]),
                  leading: Icon(
                    Icons.event_note,
                    color: Colors.white30,
                  ),
                trailing: IconButton(
                  icon: Icon(Icons.star_border),
                  color: Colors.deepPurple[300],
                  iconSize: 30,
                  onPressed: () {
                    setState(() {
                      saved.add(tasks[index]);
                      tasks.removeAt(index);
                    });
                  },
                ),
              )
            ),
          onDismissed: (direction) {
            setState(() {
              tasks.removeAt(index);
              saved.add(tasks[index]);
              // ^ Doesn't work half the time
            });
            }
          );
        },
      )
    );
  }
  void _pushStarred() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = saved.map(
                (text) {
              return ListTile(
                leading: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                title: Text(text),
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
              title: Text('Completed Tasks'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
}}