import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rack_n_roll/screens/login.dart';

class ForgotSuccessScreen extends StatefulWidget {
  @override
  _ForgotSuccessScreen createState() => _ForgotSuccessScreen();
}

class _ForgotSuccessScreen extends State<ForgotSuccessScreen> {
  List<TextEditingController> otpControllers =
  List.generate(6, (index) => TextEditingController());
  List<FocusNode> otpFocusNodes = List.generate(6, (index) => FocusNode());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF4C80B8), size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image
            SizedBox(
              height: screenHeight * 0.5,
              child: Image.asset("assets/done.png", fit: BoxFit.contain),
            ),

            // Title
            Align(
              alignment: Alignment.center,
              child: Text(
                "Password Changed!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF313A51)),
              ),
            ),

            SizedBox(height: screenHeight * 0.005),

            // Subtitle
            Text(
              "Your password has been changed successfully!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            SizedBox(height: screenHeight * 0.04),

            // Finish Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4C80B8),
                minimumSize: Size(double.infinity, 50),
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
              child: Text("Back to Login",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: screenHeight * 0.06),
          ],
        ),
      ),
    );
  }
}
