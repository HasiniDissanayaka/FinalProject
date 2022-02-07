import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:traintravelers/screens/homepage.dart';
import 'package:traintravelers/screens/loginpage.dart';


class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context,streamsnapshot){
              if (streamsnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${streamsnapshot.error}"),
                  ),
                );
              }
              //connection state active - do the login chek inside the
              //if statement
              if(streamsnapshot.connectionState==ConnectionState.active){
                // Get the user
             Object? _user = streamsnapshot.data;
                if(_user == null){
                  return LoginPage();


                }else{
                  return HomePage();
                }

              }
              //cheking the auth state-loading
              return Scaffold(
                body: Center(

                  child: Text("Cheking authentication..."),
                ),
              );
            }
          );
        }
        return Scaffold(
          body: Center(
            child: Text("initialize app"),
          ),
        );
      },
    );
  }
}
