import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants{
  void showSnackBar(String message, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1), // Optional: Adjust the duration as needed
      ),
    );
  }
}