import 'package:flutter/material.dart';
import '../screens/home_page.dart';
import '../screens/history_page.dart';


class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex; // To track active tab


  const CustomBottomNavBar({Key? key, required this.currentIndex}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(context, 0, Icons.home_outlined, "Home"),
          _buildNavItem(context, 1, Icons.history, "History"),
        ],
      ),
    );
  }


  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label) {
    bool isSelected = index == currentIndex;


    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => index == 0 ? HomeScreen() : HistoryScreen(),
            ),
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5, // Half width for 2 buttons
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4C80B8) : const Color(0xFFF3C53D),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.black),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
