import 'package:flutter/material.dart';
//import 'package:rack_n_roll/screens/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../authService/auth_service.dart';
import 'signup2.dart';

class Signup1Screen extends StatefulWidget {
  @override
  _Signup1ScreenState createState() => _Signup1ScreenState();
}

class _Signup1ScreenState extends State<Signup1Screen> {
  bool _isObscured = true;
  final authService = AuthService();
  final SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  Future<void> signUp() async {
    final email = emailController.text.trim();
    final name = nameController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error! Your Name is REQUIRED!')),
      );
      return;
    }
    if(email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error! Email is REQUIRED!')),
      );
    }
    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error! Enter a valid email address!')),
      );
      return;
    }
    if(password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error! Password is REQUIRED!')),
      );
      return;
    }
    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error! Password must be at least 8 characters long!')),
      );
      return;
    }
    if (confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error! Confirming your Password is REQUIRED!')),
      );
      return;
    }
    if(password != confirmPassword){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords don\u0027t match!')),
      );
      return;
    }

    try {
      await authService.signUpWithEmailPassword(email, password);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification email sent! Check your inbox.')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Signup2Screen(email: email)),
      );

    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup Failed! ${e.toString()}')),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double horizontalPadding = screenWidth * 0.08; // 8% of screen width
    double imageHeight = screenHeight * 0.4; // 30% of screen height

    return Scaffold(
      extendBodyBehindAppBar: true,
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
                SizedBox(height: screenHeight * 0.01),

                // Centered Logo & Title
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: imageHeight,
                        child: Image.asset("assets/signup1.png", fit: BoxFit.contain),
                      ),
                      Text(
                        "Let's Get to Know You!",
                        style: TextStyle(
                          fontSize: 22,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF313A51),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),

                // Input Fields
                _buildTextField("Enter your Name", Icons.person_outline, nameController),
                SizedBox(height: screenHeight * 0.015),
                _buildTextField("Enter your E-mail", Icons.email_outlined, emailController),
                SizedBox(height: screenHeight * 0.015),
                _buildTextField("Enter Password", Icons.lock_outline, passwordController, isPassword: true),
                SizedBox(height: screenHeight * 0.015),
                _buildTextField("Confirm Password", Icons.lock_outline, confirmPasswordController, isPassword: true),
                SizedBox(height: screenHeight * 0.06),

                // Progress Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.5, // Adjust as needed
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF3C53D)),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      "1 of 2",
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
                  onPressed: signUp,
                  child: Text("Next", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: screenHeight * 0.06),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, IconData icon, TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      controller: controller, // Assign controller
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

}
