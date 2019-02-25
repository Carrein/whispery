// import 'package:geolocator/geolocator.dart';

// class LocationHandler {
//   static Future<Position> getLocationUpdate() async {
//     Geolocator geolocator = Geolocator();
//     Position position;

//     await geolocator.checkGeolocationPermissionStatus().then((status) async {
//       switch (status) {
//         case GeolocationStatus.denied:
//         case GeolocationStatus.disabled:
//         case GeolocationStatus.restricted:
//         case GeolocationStatus.unknown:
//           position = null;
//           break;
//         case GeolocationStatus.granted:
//           await geolocator
//               .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//               .then((location) {
//             position = location;
//           });
//           break;
//       }
//     }).whenComplete(() {
//       return position;
//     });
//   }
// }
