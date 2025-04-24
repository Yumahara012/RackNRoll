import 'package:flutter/material.dart';


class CustomToggleButton extends StatelessWidget {
  final bool isRack;
  final ValueChanged<bool> onChanged;


  const CustomToggleButton({Key? key, required this.isRack, required this.onChanged}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!isRack);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut, // Smooth transition
        width: 250,
        height: 100,
        decoration: BoxDecoration(
          color: isRack ? Color(0xFFF3C53D) : Color(0xFF4C80B8), // Yellow for Rack, Blue for Roll
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.black, width: 2), // Black outer border
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 50),
              curve: Curves.easeInOut,
              alignment: isRack ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50), // Text padding
                child: Text(
                  isRack ? "Rack" : "Roll",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: isRack ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),

            AnimatedAlign(
              duration: const Duration(milliseconds: 50),
              curve: Curves.easeInOut, // Smooth movement
              alignment: isRack ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10), // Keeps space inside toggle
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white, // White inner circle
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1), // Black inner circle border
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
