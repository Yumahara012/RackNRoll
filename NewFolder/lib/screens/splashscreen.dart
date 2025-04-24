import 'package:flutter/material.dart';
import 'welcome.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.2),
            // Logo (scales with screen)
            SizedBox(
              height: screenHeight * 0.45,
              width: screenWidth * .9,
              child: Image.asset('assets/logo.jpg')
            ),

            SizedBox(height: screenHeight * 0.1), // Responsive spacing

            // Lottie animation + Loading text
            Column(
              children: [
                Lottie.asset(
                  'assets/loading.json',
                  width: screenWidth * 0.15, // 20% of screen width
                  height: screenWidth * 0.15, // Square
                  fit: BoxFit.fill,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Loading...',
                  style: TextStyle(
                    color: Color(0xFF4C80B8),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
