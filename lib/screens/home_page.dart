import 'package:flutter/material.dart';
import 'package:rack_n_roll/screens/history_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'profile_page.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/custom_toggle_button.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  bool isRack = true; // Default state


  @override
  void initState() {
    super.initState();
    fetchLastToggleState(); // Fetch saved toggle state when the screen loads
  }


  Future<void> fetchLastToggleState() async {
    final response = await Supabase.instance.client
        .from('rack_history')
        .select('state')
        .order('timestamp', ascending: false) // Get the most recent state
        .limit(1)
        .maybeSingle();


    if (response != null && response['state'] != null) {
      setState(() {
        isRack = response['state'] == "Rack"; // Update toggle state based on saved data
      });
    }
  }


  Future<void> toggleRackState(bool value) async {
    setState(() {
      isRack = value; // Update UI first
    });


    String newState = isRack ? "Rack" : "Roll";


    await Supabase.instance.client.from('rack_history').insert({
      'state': newState,
      'timestamp': DateTime.now().toIso8601String(), // Stores local time
    });




  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5FA),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/test.jpg'),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bluetooth, size: 28, color: Color(0xFF4C80B8)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 50), // Smooth transition
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Image.asset(
                  isRack ? 'assets/images/Rack_BG.png' : 'assets/images/Roll_BG.png',
                  width: 400,
                  height: 320,
                  key: ValueKey<bool>(isRack), // Important for proper animation
                ),
              ),
              SizedBox(height:10),

              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },


                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Customized padding
                  child: Text(
                    isRack
                        ? "Hello sunshine! The rack is outside, letting your clothes dry efficiently with proper airflow and sunlight."
                        : "It's raining, yikes! The rack is lowered to keep your clothes safe, dry, and protected.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF313A51),
                    ),
                    textAlign: TextAlign.center,
                    key: ValueKey<bool>(isRack),
                  ),
                ),
              ),
              SizedBox(height: 20),


              CustomToggleButton(
                isRack: isRack,
                onChanged: toggleRackState,
              ),
            ],
          )
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
    );
  }


}
