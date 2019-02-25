// import 'package:http/http.dart' as http;
// import 'package:whispery/globals/strings.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:whispery/globals/constants.dart';

// class FeedHandler {
//   // Returns a string containing the response from the http request.
//   static Future<String> getFeed(response, index) async {
//     String value;
//     await http
//         .get(Strings.postsFunction +
//             response.latitude.toString() +
//             "&long=" +
//             response.longitude.toString() +
//             "&page=" +
//             index.toString() +
//             "&entries=" +
//             entries.toString() +
//             "&dist=" +
//             distance.toString())
//         .then((response) {
//       if (response.statusCode == 200) {
//         if (response.body.isEmpty) {
//           value = "";
//         } else {
//           value = response.body;
//         }
//       } else {
//         value = "";
//       }
//     }).catchError((e) {
//       print(e.toString());
//     });
//     return value;
//   }
// }
