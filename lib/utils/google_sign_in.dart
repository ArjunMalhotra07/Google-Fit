import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:withstand_fitness_project/utils/constants.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<void> handleSignIn(BuildContext context) async {
    try {
      //Opens up choose account Pop up
      final googleUser = await _googleSignIn.signIn();
      Constants().showSnackBar("Signing you in...", context);
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      Constants().showSnackBar("Processing Request...", context);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleLogOut(BuildContext context) async {
    await _googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    Constants().showSnackBar("Signing you out...", context);
  }

  Future<Position> getCurrentLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error('Location Services are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission Denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Services denied forever. Cannot fetch');
    }
    return await Geolocator.getCurrentPosition();
  }
}
