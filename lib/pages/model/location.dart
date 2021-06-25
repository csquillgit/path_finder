class Location {
  String title;
  String lat;
  String lon;
  String alt;

  Location({this.lat, this.lon, this.alt, this.title});

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['title'] = title;
    m['lat'] = lat;
    m['lon'] = lon;
    m['alt'] = alt;

    return m;
  }

  @override
  String toString() {
    return lat + ':' + lon;
  }
}
