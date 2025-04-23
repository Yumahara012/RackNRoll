import 'package:flutter/material.dart';
import 'package:rack_n_roll/authService/auth_service.dart';
import 'package:rack_n_roll/screens/forgot_success.dart';

class Forgotpassword3Screen extends StatefulWidget {
  final String email;

  Forgotpassword3Screen({required this.email});

  @override
  _Forgotpassword3ScreenState createState() => _Forgotpassword3ScreenState();
}

class _Forgotpassword3ScreenState extends State<Forgotpassword3Screen> {
  bool _isObscured = true;
  final authService = AuthService();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();


Future<void> changePassword() async {
  final password = passwordController.text.trim();
  final confirmPassword = confirmPasswordController.text.trim();

  if (password.isEmpty || confirmPassword.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill in both fields.")));
    return;
  }

  if (password != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passwords do not match.")));
    return;
  }

  try {
    final response = await authService.changePassword(password);
    if (response.user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ForgotSuccessScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to update password.")));
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
  }
}



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double horizontalPadding = screenWidth * 0.08; // 8% of screen width
    double imageHeight = screenHeight * 0.35;

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
                SizedBox(height: screenHeight * 0.02),

                // Centered Logo & Title
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: imageHeight,
                        child: Image.asset("assets/reset1.png", fit: BoxFit.contain),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        "Reset Password",
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
                        "Almost there! Set a strong new password to keep your account safe.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.black54),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                    ],
                  ),
                ),

                // Email Input Field
                _buildTextField("Enter New Password", Icons.lock_outline, passwordController, isPassword: true),
                SizedBox(height: screenHeight * 0.015),

                // Password Input Field
                _buildTextField("Confirm New Password", Icons.lock_outline, confirmPasswordController, isPassword: true),
                SizedBox(height: screenHeight * 0.06),

                // Progress Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 1.0, // Last step (3 of 3)
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF3C53D)),
                      ),
                    ),
                    Text(
                      "3 of 3",
                      style: TextStyle(color: Colors.black54, fontSize: screenWidth * 0.035),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),

                // Submit Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4C80B8),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: changePassword ,
                  child: Text("Reset Password", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, IconData icon, TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      controller: controller,
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
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
