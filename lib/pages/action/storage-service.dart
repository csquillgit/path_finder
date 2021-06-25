import 'package:localstorage/localstorage.dart';
import 'package:path_finder/pages/model/location.dart';

class StorageService {
  List<Location> locs = [];

  addLocation(Location item) {
    locs.add(item);
  }

  removeLocation(Location loc) {
    return locs.remove(loc);
  }

  getLocations() {
    return locs;
  }

  deleteAll() {
    locs.clear();
  }

//   final LocalStorage _storage = new LocalStorage('todo_app');

//   saveToStorage(String key, var value) {
//     _storage.setItem(key, value);
//   }

//   save(TodoItem item) {
//     List<dynamic> _items = _storage.getItem('todos');
//     if (_items == null) {
//       _items ??= List<dynamic>();
//     }
//     _items.add(item);
//     _storage.setItem('todos', _items);
//   }

//   toJSONEncodable(List<dynamic> items) {
//     return items.map((item) {
//       return item.toJSONEncodable();
//     }).toList();
//   }

//   // remove(TodoItem item) {
//   //   _items.add(item);
//   // }

//   clearStorage() {
//     _storage.clear();
//   }

//   getItem(String key) {
//     return _storage.getItem(key);
//   }

//   Future<bool> ready() {
//     Future<bool> future = _storage.ready;
//     return future;
//   }
// }

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
}
