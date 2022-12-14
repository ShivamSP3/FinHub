
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/pages/signup.dart';

import '../pages/home_page.dart';

class AuthClass{


final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https: // www.googleapis.com/auth/contacts.readonly',
  ]
);
FirebaseAuth auth = FirebaseAuth.instance;
Future<void> googleSignIn (BuildContext context) async {
  try {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    if(googleSignInAccount!=null){
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    
    AuthCredential credential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication.idToken,accessToken: googleSignInAuthentication.accessToken);
  try {
      UserCredential userCredential = await  auth.signInWithCredential(credential);
       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=> const HomePage()
        ), (route) => false);
  } catch (e) {
     final Snackbar = SnackBar(content: Text(e.toString()));
       ScaffoldMessenger.of(context).showSnackBar(Snackbar);
  }
    }
    else{
       final Snackbar = SnackBar(content: Text("Not able to Sign In"));
       ScaffoldMessenger.of(context).showSnackBar(Snackbar);

    }
  } catch (e) {
     final Snackbar = SnackBar(content: Text(e.toString()));
       ScaffoldMessenger.of(context).showSnackBar(Snackbar);
  }
}
}