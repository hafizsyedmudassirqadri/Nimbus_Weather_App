import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wheather_app/constants/app_colors.dart';
import 'package:wheather_app/controller/home_controller.dart';
import 'package:shimmer/shimmer.dart';

// import 'package:wheather_app/view/bottom_navbar.dart';

class HomeScreenUi extends StatefulWidget {
  HomeScreenUi({super.key});

  @override
  State<HomeScreenUi> createState() => _HomeScreenUiState();
}

class _HomeScreenUiState extends State<HomeScreenUi> {
  ScrollController _scrollController = ScrollController();
  double _scrollThreshold = 140;
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;
      if (_scrollController.position.extentAfter < _scrollThreshold &&
          homeController.hasNext) {
        homeController.getCities();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.homeScreenBgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Good Evening ",
                        style: GoogleFonts.poppins(
                          color: AppColors.lightThemeSecondaryText,
                          fontSize: screenWidth * 0.034,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: "\n${homeController.studentName.value}",
                            style: GoogleFonts.poppins(
                              color: AppColors.lightThemePrimaryText,
                              fontSize: screenWidth * 0.046,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: screenWidth * 0.06,
                      backgroundColor: AppColors.primaryBlue,
                      child: Text(
                        homeController.initials,
                        style: GoogleFonts.poppins(
                          color: AppColors.white,
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.015),

              //Search Bar
              Obx(() {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.01,
                    vertical: screenHeight * 0.005,
                  ),
                  child: homeController.isRegionLoading.value
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            width: double.infinity,
                            height: screenHeight * 0.065,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(21),
                            ),
                          ),
                        )
                      : TextField(
                          decoration: InputDecoration(
                            hintText: "Search Cities or Countries ...",
                            hintStyle: GoogleFonts.poppins(
                              color: AppColors.lightThemeSecondaryText,
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.w400,
                            ),
                            prefixIcon: const Icon(Icons.search_rounded),
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.cancel,
                                color: AppColors.lightThemeSecondaryText,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(21.0),
                              ),
                              borderSide: BorderSide(
                                color: AppColors.lightThemeSecondaryText,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(21.0),
                              ),
                              borderSide: BorderSide(
                                color: AppColors.blueGrey,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                );
              }),

              SizedBox(height: screenHeight * 0.015),

              // Categories with Shimmer Loading
              Obx(() {
                return homeController.isRegionLoading.value
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            5,
                            (index) => Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.016,
                              ),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: screenWidth * 0.22,
                                  height: screenHeight * 0.045,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(99),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (
                              int index = 0;
                              index < homeController.continentList.length;
                              index++
                            )
                              GestureDetector(
                                onTap: () => homeController.regionTap(index),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04,
                                    vertical: screenHeight * 0.009,
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.016,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        index ==
                                            homeController
                                                .selectedContinentListIndex
                                                .value
                                        ? AppColors.primaryBlue
                                        : AppColors.homeScreenContainerBg,
                                    borderRadius: BorderRadius.circular(99),
                                    border: Border.all(
                                      color:
                                          index ==
                                              homeController
                                                  .selectedContinentListIndex
                                                  .value
                                          ? Colors.blue
                                          : const Color(0xFFE1D9D1),
                                    ),
                                  ),
                                  child: Text(
                                    homeController.continentList[index],
                                    style: TextStyle(
                                      color:
                                          index ==
                                              homeController
                                                  .selectedContinentListIndex
                                                  .value
                                          ? AppColors.white
                                          : AppColors.lightThemeSecondaryText,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
              }),

              SizedBox(height: screenHeight * 0.010),

              Obx(() {
                return homeController.isRegionLoading.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Cities Shimmer
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              width: screenWidth * 0.22,
                              height: screenHeight * 0.025,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),

                          // Results Shimmer
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              width: screenWidth * 0.20,
                              height: screenHeight * 0.02,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cities",
                            style: GoogleFonts.poppins(
                              color: AppColors.black,
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "23 Results",
                              style: GoogleFonts.poppins(
                                color: AppColors.lightThemeSecondaryText,
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
              }),

              SizedBox(height: screenHeight * 0.003),

              GetBuilder<HomeController>(
                builder: (c) {
                  return Expanded(
                    child: c.isCitiesLoading && c.cities.isEmpty
                        ? ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  height: screenHeight * 0.09,
                                  margin: EdgeInsets.only(
                                    bottom: screenHeight * 0.01,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                              );
                            },
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: c.cities.length + (c.isCitiesLoading ? 1 : 0),
                            itemBuilder: (context, index) {
                              // Pagination Loading
                              if (index == c.cities.length && c.isCitiesLoading) {
                                return GestureDetector(
                                  onTap: c.isCitiesLoading
                                      ? null
                                      : () {
                                          c.getCities();
                                        },
                                  child: c.isCitiesLoading
                                      ? Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            height: screenHeight * 0.06,
                                            margin: EdgeInsets.only(
                                              bottom: screenHeight * 0.01,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                          ),
                                        )
                                      : null,
                                );
                              }

                              final city = c.cities[index];

                              // City Card
                              return Container(
                                height: screenHeight * 0.09,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                margin: EdgeInsets.only(
                                  bottom: screenHeight * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.homeScreenContainerBg,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: AppColors.rainCardBg,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Image.asset(
                                        'assets/Icon/rain.png',
                                        width: screenWidth * 0.08,
                                        height: screenWidth * 0.08,
                                      ),
                                    ),

                                    SizedBox(width: screenWidth * 0.03),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            city.name ?? "",
                                            style: GoogleFonts.poppins(
                                              color: AppColors.black,
                                              fontSize: screenWidth * 0.036,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            "${city.country} . ${city.region}",
                                            style: GoogleFonts.poppins(
                                              color: AppColors
                                                  .lightThemeSecondaryText,
                                              fontSize: screenWidth * 0.030,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(width: screenWidth * 0.03),

                                    Text(
                                      "${city.weather?.temperatureC?.toStringAsFixed(0) ?? '--'}°C",
                                      style: GoogleFonts.poppins(
                                        color: AppColors.black,
                                        fontSize: screenWidth * 0.045,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
