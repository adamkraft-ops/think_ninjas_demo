import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../common/constants.dart';
import '../widgets/roll_card.dart';

class RollSelector extends StatelessWidget {
  const RollSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double boxWidth = screenWidth * 0.3;
    double boxHeight = screenHeight * 0.2;
    double iconSize = screenWidth * 0.1;
    double fontSize = screenWidth * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.rollSelectMessage,
          style: GoogleFonts.alice(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
            ),
          ),
        ),
        backgroundColor: Colors.grey,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white60, Colors.white70],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoleCard(
                    role: 'Waiter',
                    color: Colors.grey,
                    boxWidth: boxWidth,
                    boxHeight: boxHeight,
                    iconSize: iconSize,
                    fontSize: fontSize,
                  ),
                  SizedBox(width: Width.zero),
                  RoleCard(
                    role: 'User',
                    color: Colors.orange,
                    boxWidth: boxWidth,
                    boxHeight: boxHeight,
                    iconSize: iconSize,
                    fontSize: fontSize,
                  ),
                  SizedBox(width: Width.zero),
                  RoleCard(
                    role: 'Kitchen',
                    color: Colors.black,
                    boxWidth: boxWidth,
                    boxHeight: boxHeight,
                    iconSize: iconSize,
                    fontSize: fontSize,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
