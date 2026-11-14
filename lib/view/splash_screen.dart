import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SplashScreenUi extends StatelessWidget {
  const SplashScreenUi({super.key});

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    // final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF0B1B3A),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Nimbus",
              style: GoogleFonts.sora(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenheight * 0.03),
            Text(
              "Weather & City Guide",
              style: GoogleFonts.sora(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenheight * 0.02),
            Text(
              "Checking Your Sessiion...",
              style: GoogleFonts.sora(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
