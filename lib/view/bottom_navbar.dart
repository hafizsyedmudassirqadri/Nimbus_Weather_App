import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wheather_app/constants/app_colors.dart';
import 'package:wheather_app/controller/home_controller.dart';
import 'package:wheather_app/view/favorite_screen.dart';
import 'package:wheather_app/view/home_screen.dart';
import 'package:wheather_app/view/profile_screen.dart';

// class BottomNavbar extends StatefulWidget {
//   const BottomNavbar({super.key});
//   @override
//   State<BottomNavbar> createState() => _BottomNavbarState();
// }

// class _BottomNavbarState extends State<BottomNavbar> {
//   List<Widget> myScreenList = [
//     HomeScreenUi(),
//     FavoriteScreenUi(),
//     ProfileScreenUi(),
//   ];
//   int myScreenIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: myScreenList[myScreenIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: AppColors.lightThemeBgColor,
//         selectedItemColor: AppColors.textButton,
//         unselectedItemColor: Colors.grey,
//         currentIndex: myScreenIndex,
//         type: BottomNavigationBarType.fixed, // Yeh line add karein
//         onTap: (index) {
//           setState(() {
//             myScreenIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: "Favorite",
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }







class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

 
  List<Widget> myScreenList = [HomeScreenUi(),  FavoriteScreenUi(), ProfileScreenUi()];
  int myScreenIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightThemeBgColor,
      body: myScreenList[myScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: myScreenIndex,
        onTap: (index) {
          // print("Bottom Navbar index: $index");
          myScreenIndex = index;
          setState(() {
            
          });
        },
        backgroundColor: AppColors.lightThemeBgColor,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.lightThemeSecondaryText,
        selectedLabelStyle: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: "Explore",
          
          ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline_sharp), label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_sharp), label: "Profile"),
        ],
      ),
    );
  }
}
