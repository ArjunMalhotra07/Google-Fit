import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:withstand_fitness_project/utils/google_sign_in.dart';

class FindLocation extends StatefulWidget {
  const FindLocation({super.key});

  @override
  State<FindLocation> createState() => _FindLocationState();
}

class _FindLocationState extends State<FindLocation> {
  void liveLocation() {
    LocationSettings locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
        forceLocationManager: true,
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationText:
              "Example app will continue to receive your location even when you aren't using it",
          notificationTitle: "Running in Background",
          enableWakeLock: true,
        ));
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      print("here");
      setState(() {
        lat = position.latitude;
        long = position.longitude;
      });
      print("LAT --> $lat");
      print("LON --> $long");
      print("");
    });
  }

  double lat = 0;
  double long = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.getCurrentLocation().then((value) {
                  setState(() {
                    lat = value.latitude;
                    long = value.longitude;
                  });
                  liveLocation();
                });
              },
              child: const Text('Current Location'),
            ),
            Text(lat.toString()),
            Text(long.toString())
          ],
        )));
  }
}
