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

  // _toggleItem(Location item) {
  //   setState(() {
  //     item.done = !item.done;
  //     //_saveToStorage();
  //   });
  // }

  // _addItem(String title) {
  //   setState(() {
  //     final item = new Location(title: title, done: false);
  //     //list.items.add(item);
  //     //_saveToStorage();
  //   });
  // }

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
        child: _buildListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _deleteAll,
        tooltip: 'Delete All',
        child: Icon(Icons.delete),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  ListView _buildListView() {
    List<Location> locs = storageService.getLocations();
    return ListView.builder(
      itemCount: locs.length,
      itemBuilder: (context, index) {
        final item = locs[index];
        return Dismissible(
          // Each Dismissible must contain a Key. Keys allow Flutter to
          // uniquely identify widgets.
          key: UniqueKey(),
          // Provide a function that tells the app
          // what to do after an item has been swiped away.
          onDismissed: (direction) {
            //storageService.removeLocation(locs[index]);
            // Remove the item from the data source.
            setState(() {
              locs.removeAt(index);
            });
            // Then show a snackbar.
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                duration: Duration(milliseconds: 500),
                content: Text(item.toString() + ' dismissed')));
          },
          // Show a red background as the item is swiped away.
          background: Container(color: Colors.red),
          child: ListTile(title: Text(item.toString() + ':' + index.toString())),
        );
      },
    );
  }

  void _deleteAll() {
    setState(() {
      storageService.deleteAll();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 500),
          content: Text('Deleted all locations')));
    });
  }
}
