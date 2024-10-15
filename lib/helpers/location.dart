import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  Future<Position?> getCurrentPosition() async {
    printInfo(info: 'try get current position');
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return null;
      }

      return await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.best),
      );
    } catch (e) {
      printError(info: e.toString());
      return null;
    }
  }
}
