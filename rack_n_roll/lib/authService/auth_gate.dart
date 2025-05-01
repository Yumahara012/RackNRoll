/*

Function of this file =
This will continuously listen for authService state changes.


Unauthenticated ---> Login Page
Authenthicated  ---> Home Page


 */

import 'package:flutter/material.dart';
import 'package:rack_n_roll/screens/home_page.dart';
import 'package:rack_n_roll/screens/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // Listen to authService state changes
      stream: Supabase.instance.client.auth.onAuthStateChange,

      //  Build appropriate page based on authService state
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final session = snapshot.hasData ? snapshot.data!.session : null;

        if (session != null ) {
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}

