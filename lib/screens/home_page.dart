import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${user?.displayName.toString()}"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) => HealthApp())
              },
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(user?.photoURL ??
                    "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.dreamstime.com%2Fdefault-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-image179376714&psig=AOvVaw1lRMibTxrBcDmjarZovdyX&ust=1684960076964000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCNj0j8mjjP8CFQAAAAAdAAAAABAE"),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'Email: ${user?.email.toString()}',
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 100,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white60),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        const TextStyle(color: Colors.black)),
                  ),
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.handleLogOut(context);
                  },
                  child: const Text('Sign Out')),
            )
          ],
        ),
      ),
    );
  }
}
