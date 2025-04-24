import 'package:flutter/material.dart';
import 'package:rack_n_roll/authService/auth_service.dart';
import 'package:rack_n_roll/screens/login.dart';


class ProfileScreen extends StatelessWidget {
  final authService = AuthService();

  void logOut(BuildContext context) async {
    await authService.signOut();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Log Out Successful')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Light background color
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5FA),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 35, color: Color(0xFF4C80B8)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bluetooth, size: 28, color: Color(0xFF4C80B8)),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Curved Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: CurvedHeaderClipper(),
              child: Container(
                height: 180, // Adjust the height of the curve
                color: Color(0xFF4C80B8),
              ),
            ),
          ),


          Column(
            children: [
              SizedBox(height: 90), // Space for the curved background


              // Profile Picture
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 65,
                          backgroundImage: AssetImage('assets/images/test.jpg'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.border_color_outlined, size: 20, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Hi, Carla Angela",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),


              // Account Info Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                  children: [
                    // Account Information Title
                    Text(
                      "Account Information",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8), // Add some spacing between text and container


                    // Account Info Container
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildInfoRow(Icons.assignment_ind, "Name", "Carla Angela Tagle"),
                          _buildInfoRow(Icons.home, "Address", "Sta. Mesa, Manila"),
                          _buildInfoRow(Icons.phone, "Contact Number", "0912-345-6789"),
                          _buildInfoRow(Icons.email, "Email", "qcabtagle@tip.edu.ph"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


              Spacer(),


              // Logout Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                child: ElevatedButton(
                  onPressed: () => logOut(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF3C53D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Center(
                    child: Text(
                      "Logout",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  // Helper Widget for Info Rows
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF4C80B8),),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}


// Custom Clipper for the Curved Background
class CurvedHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50); // Start at the bottom left
    path.quadraticBezierTo(
      size.width / 2, size.height + 20, // Curve control point
      size.width, size.height - 50, // End at the bottom right
    );
    path.lineTo(size.width, 0); // Top right corner
    path.close();
    return path;
  }


  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
