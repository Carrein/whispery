import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whispery/globals/strings.dart';

class LoginHandler {
  Future<int> login(email, password) async {
    int _value;

    final prefs = await SharedPreferences.getInstance();

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((response) async {
      prefs.setString("uid", response.uid);
      print('enter');
      await Firestore.instance
          .collection(Strings.userPath)
          .document(response.uid)
          .get()
          .then((doc) {
        if (doc.exists) {
          //user and profile exists
          prefs.setString("username", doc.data["username"]);
          prefs.setString("flair", doc.data["flair"]);
          _value = 1;
          print(1);
        } else {
          //only user exists
          print(0);
          _value = 0;
        }
      });
    }).catchError((e) {
      //no such user exist
      _value = -1;
      print(-1);
    });

    return _value;
  }

  Future<bool> register(email, password) async {
    bool _value;
    final prefs = await SharedPreferences.getInstance();

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((response) {
      prefs.setString("uid", response.uid);
    }).whenComplete(() {
      _value = true;
    }).catchError((e) {
      _value = false;
    });

    return _value;
  }

  // Future<bool> forgotEmail() async {}
}
