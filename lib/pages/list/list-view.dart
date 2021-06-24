import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_finder/main.dart';
import 'package:path_finder/pages/action/storage-service.dart';
import 'package:path_finder/pages/model/location.dart';

class MyListPage extends StatefulWidget {
  MyListPage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

// class TodoList {
//   List<TodoItem> items;

//   TodoList() {
//     items = new List();
//   }

//   toJSONEncodable() {
//     return items.map((item) {
//       return item.toJSONEncodable();
//     }).toList();
//   }
// }

class _MyHomePageState extends State<MyListPage> {
  //final TodoList list = new TodoList();
  final StorageService storageService = getIt.get<StorageService>();
  bool initialized = false;
  TextEditingController controller = new TextEditingController();

  _MyHomePageState() {
    print("created");
  }

  _toggleItem(Location item) {
    setState(() {
      item.done = !item.done;
      //_saveToStorage();
    });
  }

  _addItem(String title) {
    setState(() {
      final item = new Location(title: title, done: false);
      //list.items.add(item);
      //_saveToStorage();
    });
  }

  // _saveToStorage() {
  //   storage.saveToStorage('todos', list.toJSONEncodable());
  // }

  // _clearStorage() async {
  //   await storage.clearStorage();

  //   setState(() {
  //     list.items = storage.getItem('todos') ?? [];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        constraints: BoxConstraints.expand(),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: _items(),
        ),
      ),
    );
  }

  List<Widget> _items() {
    List<Widget> items = [];
    List<Location> locs = storageService.getLocations();
    print(locs.length);
    locs.forEach((Location loc) {
      items.add(
        Container(
          height: 50,
          color: Colors.green,
          child: Center(child: Text(loc.title)),
        ),
      );
    });
    return items;
  }

  void _save() {
    _addItem(controller.value.text);
    controller.clear();
  }
}
