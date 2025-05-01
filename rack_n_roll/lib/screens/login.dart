import 'package:flutter/material.dart';
import 'package:rack_n_roll/screens/forgotpassword1.dart';
import 'package:flutter/gestures.dart';
import 'package:rack_n_roll/screens/signup1.dart';
import 'package:rack_n_roll/screens/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:rack_n_roll/authService/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authService = AuthService();
  bool _isObscured = true;
  final SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> logIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
      try {
        await authService.signInWithEmailPassword(email, password);

        ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Log In Successful')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );

        } catch(e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Failed! Wrong Credentials!')),
        );
      }

  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double horizontalPadding = screenWidth * 0.08;
    double imageHeight = screenHeight * 0.3;
    double buttonSize = screenWidth * 0.25;
    double iconSize = buttonSize * 0.4;

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
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.03),

              // Responsive Logo
              Image.asset("assets/logo.jpg", height: imageHeight),
              SizedBox(height: screenHeight * 0.01),

              // Email Input
              _buildTextField(
                  controller: emailController,
                  hintText: 'Enter your email',
                  icon: Icons.email_outlined),
              SizedBox(height: screenHeight * 0.015),

              // Password Input with Visibility Toggle
              _buildTextField(
                  controller: passwordController,
                  hintText: "Enter your password",
                  icon: Icons.lock_outline,
                  isPassword: true),
              SizedBox(height: screenHeight * 0.01),

              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push
                      (context,
                        MaterialPageRoute(builder: (context) => Forgotpassword1Screen()));
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              // Login Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4C80B8),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: logIn,
                child: Text("Login", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold))

              ),
              SizedBox(height: screenHeight * 0.03),

              Text("Or Login with", style: TextStyle(fontSize: 15)),
              SizedBox(height: screenHeight * 0.015),

              // Improved Responsive Social Login Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  socialLoginButton("assets/fb.png", buttonSize, iconSize),
                  SizedBox(width: screenWidth * 0.01),
                  socialLoginButton("assets/google.png", buttonSize, iconSize),
                  SizedBox(width: screenWidth * 0.01),
                  socialLoginButton("assets/x.png", buttonSize, iconSize),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),

        Text.rich(
        TextSpan(
        text: "Don't have an account? ",
          style: TextStyle(fontSize: 15),
          children: [
            TextSpan(
              text: "Register Now",
              style: TextStyle(
                color: Color(0xFF4C80B8),
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Navigate to the signup screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup1Screen()), // Replace with actual sign-up screen
                  );
                },
            ),
          ],
        ),
      ),

      SizedBox(height: screenHeight * 0.06),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller, // Use the passed controller
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
            color: Color.fromRGBO(128, 128, 128, 0.8),
          ),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        )
            : Icon(icon, color: Color.fromRGBO(128, 128, 128, 0.8)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }


  Widget socialLoginButton(String assetPath, double buttonSize, double iconSize) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 105, // Limits button width
        minWidth: 80, // Ensures it doesn't shrink too much
        maxHeight: 55,
        minHeight: 50,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Image.asset(assetPath, width: 28, height: 28),
        ),
      ),
    );
  }
}
