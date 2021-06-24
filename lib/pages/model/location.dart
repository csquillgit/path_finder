class Location {
  String title;
  bool done;

  Location({this.title, this.done});

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['title'] = title;
    m['done'] = done;

    return m;
  }
}
