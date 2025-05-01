import 'package:flutter/material.dart';
import 'package:rack_n_roll/authService/auth_service.dart';
import 'package:rack_n_roll/screens/login.dart';

class ProfileScreen extends StatefulWidget {
  String profilePictureUrl = ''; // initialize empty

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final authService = AuthService();

  // Dummy initial info, replace with real user data fetch later
  String address = "Sta. Mesa, Manila";
  String contactNumber = "0912-345-6789";
  String profilePictureUrl = ''; // <- MOVED here to _ProfileScreenState

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

  void showEditDialog(BuildContext context) {
    final addressController = TextEditingController(text: address);
    final contactController = TextEditingController(text: contactNumber);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: contactController,
              decoration: InputDecoration(labelText: 'Contact Number'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                address = addressController.text;
                contactNumber = contactController.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Information Updated')),
              );
              // TODO: Save changes to your database (Supabase update)
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  // 🔥 NEW: Build Profile Picture (Dynamic)
  Widget _buildProfilePicture() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 65,
          backgroundImage: profilePictureUrl.isNotEmpty
              ? NetworkImage(profilePictureUrl)
              : AssetImage('assets/images/default_avatar.png') as ImageProvider,
          backgroundColor: Colors.grey[300],
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
                height: 180,
                color: Color(0xFF4C80B8),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 90),
              Center(
                child: Column(
                  children: [
                    _buildProfilePicture(), // <<<<<<<< REPLACED old Stack here
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account Information",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),

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
                          _buildInfoRow(Icons.home, "Address", address),
                          _buildInfoRow(Icons.phone, "Contact Number", contactNumber),
                          _buildInfoRow(Icons.email, "Email", "qcabtagle@tip.edu.ph"),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => showEditDialog(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4C80B8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text('Edit Address & Contact', style: TextStyle(color: Colors.white)),
                          ),
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
          Icon(icon, color: Color(0xFF4C80B8)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Clipper for Curved Header
class CurvedHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 2, size.height + 20,
      size.width, size.height - 50,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
