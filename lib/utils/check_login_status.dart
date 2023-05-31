import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:withstand_fitness_project/screens/home_page.dart';
import 'package:withstand_fitness_project/screens/login_in_page.dart';

import '../screens/bottom_navigation_page.dart';

class CheckLoginStatus extends StatelessWidget {
  const CheckLoginStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return MyBottomNavigationBar();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Unexpected Error Occured'),
            );
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
