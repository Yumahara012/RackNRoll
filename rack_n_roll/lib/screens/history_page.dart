import 'package:flutter/material.dart';
import 'package:rack_n_roll/screens/profile_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart'; // For formatting date/time
import '../widgets/custom_bottom_navbar.dart';


class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}


class _HistoryScreenState extends State<HistoryScreen> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> history = [];


  @override
  void initState() {
    super.initState();
    fetchHistory();
  }


  // Fetch history records from Supabase
  Future<void> fetchHistory() async {
    final response = await supabase
        .from('rack_history')
        .select()
        .order('id', ascending: false);
    setState(() {
      history = response;
    });
  }


  // Delete a record from Supabase
  Future<void> deleteRecord(int id) async {
    await supabase.from('rack_history').delete().match({'id': id});
    setState(() {
      history.removeWhere((record) => record['id'] == id);
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
      body: history.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final record = history[index];
          DateTime localTime = DateTime.parse(record['timestamp']).toLocal();
          String formattedDate = DateFormat.yMMMMd().format(localTime);
          String formattedTime = DateFormat.jm().format(localTime);
          bool isRack = record['state'] == "Rack";


          return Dismissible(
            key: Key(record['id'].toString()), // Unique key
            direction: DismissDirection.endToStart, // Swipe left to delete
            background: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              color: const Color.fromARGB(255, 219, 64, 53),
              child: Icon(Icons.delete, color: Colors.white, size: 30),
            ),
            onDismissed: (direction) {
              deleteRecord(record['id']);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFF5F5FA), // Light grey background
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Date & Time (Left Side)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        formattedTime,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ],
                  ),


                  // State & Circle Icon (Right Side)
                  Row(
                    children: [
                      Text(
                        record['state'],
                        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: isRack ? Color(0xFFF3C53D) : Color(0xFF4C80B8), // Yellow for Rack, Blue for Roll
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
    );
  }
}
