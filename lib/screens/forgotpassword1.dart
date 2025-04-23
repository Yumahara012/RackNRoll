import 'package:flutter/material.dart';
import 'package:rack_n_roll/authService/auth_service.dart';
import 'package:rack_n_roll/screens/forgotpassword2.dart';

class Forgotpassword1Screen extends StatefulWidget {
  @override
  _Forgotpassword1 createState() => _Forgotpassword1();
}

class _Forgotpassword1 extends State<Forgotpassword1Screen> {
  final authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  bool _isObscured = true;

  Future<void> sendResetToEmail() async {
    final email = emailController.text.trim();

    try {
      await authService.sendOTPforPasswordReset(email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('The OTP was sent to your email!'))
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Forgotpassword2Screen(email: email)),
      );

    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}'))
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double horizontalPadding = screenWidth * 0.08; // 8% of screen width
    double imageHeight = screenHeight * 0.4;

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
      body: Container(
        color: Colors.white, // Ensures no background color change
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.03),

                // Centered Logo & Title
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: imageHeight,
                        child: Image.asset("assets/signup1.png", fit: BoxFit.contain),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        "Forgot your Password?",
                        style: TextStyle(
                          fontSize: 22,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF313A51),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      Text(
                        " No worries! Let’s get you back in safely. Please enter the email address linked with your account.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.black54),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                    ],
                  ),
                ),

                // Input Fields
                _buildTextField("Enter your E-mail", Icons.email_outlined, controller: emailController),
                SizedBox(height: screenHeight * 0.08),

                // Progress Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.33, // Adjust as needed
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF3C53D)),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      "1 of 3",
                      style: TextStyle(color: Colors.black54, fontSize: screenWidth * 0.035),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),

                // Next Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4C80B8),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: sendResetToEmail,
                  child: Text("Send Code", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: screenHeight * 0.06),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, IconData icon,
      {bool isPassword = false, TextEditingController? controller}) {
    return TextField(
      controller: controller, // Connect the controller
      obscureText: isPassword ? _isObscured : false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xFF8391A1), fontSize: 14),
        filled: true,
        fillColor: Color(0xFFF5F5FA),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey.withOpacity(0.8),
          ),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        )
            : Icon(icon, color: Colors.grey.withOpacity(0.8)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
