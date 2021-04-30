class TodoItem {
  String title;
  bool done;

  TodoItem({this.title, this.done});

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['title'] = title;
    m['done'] = done;

    return m;
  }
}
