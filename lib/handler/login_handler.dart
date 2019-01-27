import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whispery/globals/strings.dart';

class LoginHandler {
  Future<int> login(email, password) async {
    var value;

    final prefs = await SharedPreferences.getInstance();

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((response) async {
      prefs.setString("uid", response.uid);
      await Firestore.instance
          .collection(Strings.userPath)
          .document(response.uid)
          .get()
          .then((doc) {
        if (doc.exists) {
          //user and profile exists
          prefs.setString("username", doc.data["username"]);
          prefs.setString("flair", doc.data["flair"]);
          value = 1;
        } else {
          //only user exists
          value = 0;
        }
      });
    }).catchError((e) {
      //no such user exist
      value = -1;
    });

    return value;
  }

  Future<bool> register(email, password) async {
    bool value;
    final prefs = await SharedPreferences.getInstance();

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((response) {
      prefs.setString("uid", response.uid);
    }).whenComplete(() {
      value = true;
    }).catchError((e) {
      value = false;
    });

    return value;
  }

  // Future<bool> forgotEmail() async {}
}
