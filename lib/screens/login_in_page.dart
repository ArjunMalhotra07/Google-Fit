import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:withstand_fitness_project/utils/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        child: Center(
            child: Container(
          height: 100,
          width: 300,
          child: ElevatedButton.icon(
            icon: FaIcon(
              FontAwesomeIcons.google,
              color: Colors.orange,
            ),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.handleSignIn(context);
            },
            label: Text('Login With Google',
                style: TextStyle(color: Colors.black, fontSize: 20)),
          ),
        )),
      ),
    );
  }
}
