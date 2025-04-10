import 'package:flutter/material.dart';
import 'package:rack_n_roll/screens/login.dart';
import 'signup1.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double horizontalPadding = screenWidth * 0.1; // 10% of screen width

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo (scales with screen)
              SizedBox(
                  height: screenHeight * 0.6,
                  width: screenWidth * 1,
                  child: Image.asset('assets/logo.jpg')
              ),


              // Login Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF3C53D), // Yellow button
                  minimumSize: Size(double.infinity, 50), // Fixed height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold), // Fixed font size
                ),
              ),

              SizedBox(height: 20), // Fixed spacing

              // Register Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4C80B8), // Blue button
                  minimumSize: Size(double.infinity, 50), // Fixed height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup1Screen()),
                  );
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold), // Fixed font size
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
