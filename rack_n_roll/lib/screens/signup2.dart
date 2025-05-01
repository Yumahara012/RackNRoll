import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rack_n_roll/authService/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'signup_success.dart';

class Signup2Screen extends StatefulWidget {
  final String email;

  Signup2Screen({required this.email});

  @override
  _Signup2ScreenState createState() => _Signup2ScreenState();
}

class _Signup2ScreenState extends State<Signup2Screen> {
  List<TextEditingController> otpControllers =
  List.generate(6, (index) => TextEditingController());
  List<FocusNode> otpFocusNodes = List.generate(6, (index) => FocusNode());
  final authService = AuthService();

  Future<void> confirmOTP() async {
    String otpCode = otpControllers.map((controller) => controller.text).join();

    if (otpCode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter a valid 6-digit OTP!')),
      );
      return;
    }

    try {
      bool otpVerified = await authService.confirmOtp(otpCode, widget.email);

      if (otpVerified) {
        bool isVerified = Supabase.instance.client.auth.currentUser?.emailConfirmedAt != null;

        if (isVerified) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignupSuccessScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email not verified yet! Try again later.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid OTP. Please try again!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error verifying OTP: $e')),
      );
    }
  }

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
            // OTP Image
            SizedBox(
              height: screenHeight * 0.4,
              child: Image.asset("assets/otp1.png", fit: BoxFit.contain),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Title
            Text(
              "Almost There!",
              style: TextStyle(
                  fontSize: 22,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF313A51)),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Subtitle
            Text(
              "Please enter the 6-digit code sent to your Email Address for verification.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            SizedBox(height: screenHeight * 0.04),

            // OTP Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 3 ? 12 : 4, // Extra space before the 4th box
                    right: 0.5,
                  ),
                  child: Container(
                    width: screenWidth * 0.125,
                    height: screenWidth * 0.12,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5FA),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: TextField(
                        controller: otpControllers[index],
                        focusNode: otpFocusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          color: Color(0xFF313A51),
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context).requestFocus(otpFocusNodes[index + 1]);
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context).requestFocus(otpFocusNodes[index - 1]);
                          }
                        },
                      ),
                    ),
                  ),
                );
              }),
            ),

            SizedBox(height: screenHeight * 0.03),

            // Finish Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4C80B8),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: confirmOTP,
              child: Text("Finish",
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
