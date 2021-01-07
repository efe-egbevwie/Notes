import 'package:flutter/material.dart';
import 'package:todolist/database/todo_item.dart';

import 'database/db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
        accentColor: Color.fromRGBO(209, 224, 224, 0.2),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ToDoItem> _todo = [];

  List<Widget> get _todoItems =>
      _todo.map((item) => toDoItemWidget(item)).toList();

  String _taskName = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  Widget toDoItemWidget(ToDoItem item) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Dismissible(
          onDismissed: (DismissDirection d) {
            DB.delete(ToDoItem.table, item);
            showSnackBar('Task Deleted');
            refreshToDoList();
          },
          key: Key(item.id.toString()),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme
                    .of(context)
                    .accentColor,
                shape: BoxShape.rectangle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0.0, 10))
                ]),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(item.name,
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            ),
          ),
        ));
  }

  void _addTodoDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add a new Task'),
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Task Name',
                    ),
                    onChanged: (value) {
                      _taskName = value;
                    },
                  )
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(onPressed: () => _saveTask(), child: Text('Add task')),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),
            ],
          );
        });
  }





  String validateTaskName(String taskName) {
    if (taskName.length < 1) {
      return 'Please enter a name for your task';
    }
    return null;
  }

  void refreshToDoList() async {
    List<Map<String, dynamic>> _currentTodoItems =
    await DB.query(ToDoItem.table);
    _todo = _currentTodoItems.map((item) => ToDoItem.fromMap(item)).toList();
    setState(() {});
  }

  @override
  void initState() {
    refreshToDoList();
    super.initState();
  }

  void _saveTask() async {
    showSnackBar('Task saved');
    Navigator.of(context).pop();
    ToDoItem item = ToDoItem(name: _taskName);
    await DB.insert(ToDoItem.table, item);
    setState(() {});
    refreshToDoList();
  }


  void showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("$message!!"),
          duration: Duration(seconds: 1),
          // backgroundColor: Theme.of(context).primaryColor,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 5.0),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                  child: Text(
                    "To-Do List",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  )),
              Expanded(
                child: ListView(
                  children: _todoItems,
                  shrinkWrap: true,
                ),
              ),
            ],
          )),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => _addTodoDialog(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
