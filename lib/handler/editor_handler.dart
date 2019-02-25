import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whispery/globals/strings.dart';

class EditorHandler {
  Future<bool> submit(username, flair, bio) async {
    bool _value;

    final prefs = await SharedPreferences.getInstance();

    var data = {
      "username": username,
      "bio": bio,
      "flair": flair,
    };

    await Firestore.instance
        .collection(Strings.userPath)
        .document(prefs.getString("uid"))
        .setData(data)
        .whenComplete(() {
      prefs.setString("username", username);
      prefs.setString("flair", flair);
      _value = true;
    }).catchError((e) {
      _value = false;
    });

    return _value;
  }
}
