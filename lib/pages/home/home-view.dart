import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_finder/main.dart';
import 'package:path_finder/pages/action/storage-service.dart';
import 'package:path_finder/pages/model/location.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var _lat = .0;
  var _lon = .0;
  var _alt = .0;

  final StorageService storageService = getIt.get<StorageService>();

  void _incrementCounter() {
    setState(() {
      _counter++;
      Future<Position> position = _determinePosition();
      position.then((value) => {
            _lat = value.latitude.toDouble(),
            _lon = value.longitude.toDouble(),
            _alt = value.altitude.toDouble(),
            _saveToStorage(Location(lat: _lat.toString(), lon: _lon.toString(), alt: _alt.toString(), title: 'test')),
          });
    });
  }

  _saveToStorage(Location location) {
    print('_lat-l:' + location.lat);
    print('_lon-l:' + location.lon);
    print('_alt-l:' + location.alt);
    setState(() {
      storageService.addLocation(location);
    });
    // Then show a snackbar.
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 500),
        content: Text(location.toString() + ' added')));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return Future.error('Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Coordinates:',
            ),
            Text(
              '$_lat',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              '$_lon',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'Altitude:',
            ),
            Text(
              '$_alt',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
