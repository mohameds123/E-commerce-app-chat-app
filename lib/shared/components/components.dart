import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
User?user;
void navigateAndFinish({
  context,
  widget,
}){
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context)=>widget,
      ),
          (route) => false
  );
}