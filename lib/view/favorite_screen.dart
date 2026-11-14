import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wheather_app/constants/app_colors.dart';
import 'package:wheather_app/constants/icon_constants.dart';
import 'package:wheather_app/models/favorite_page_model.dart';

class FavoriteScreenUi extends StatefulWidget {
  const new({super.key});

  @override
  State<FavoriteScreenUi> createState() => _FavoriteScreenUiState();
}

class _FavoriteScreenUiState extends State<FavoriteScreenUi> {
  List<FavoriteContainerDetails> myFavoriteConList = [
    FavoriteContainerDetails(
      citynamewithdeg: "Karachi 28°",
      location: "Home Town",
      weathericon: "${IconConstants.cloudSunIcon}",
    ),
    FavoriteContainerDetails(
      citynamewithdeg: "Tokyo 17°",
      location: "Trip in Spring",
      weathericon: "${IconConstants.rainIcon}",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.homeScreenBgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenwidth * 0.06,
          vertical: screenheight * 0.09,
        ),

        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Favorite",
                    style: GoogleFonts.sora(
                      color: AppColors.lightThemePrimaryText,
                      fontSize: screenwidth * 0.074,
                      fontWeight: FontWeight.w800,
                    ),
                    children: [
                      TextSpan(
                        text: "\n2 saved Cities.",
                        style: GoogleFonts.dmSans(
                          color: AppColors.lightThemeSecondaryText,
                          fontSize: screenwidth * 0.032,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenwidth * 0.025,
                      vertical: screenheight * 0.008,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.add, color: AppColors.white),
                        SizedBox(width: screenwidth * 0.01),
                        Text(
                          "Add",
                          style: GoogleFonts.dmSans(
                            color: AppColors.white,
                            fontSize: screenwidth * 0.040,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: ListView.builder(
                itemCount: myFavoriteConList.length,
                itemBuilder: (context, index) {
                  FavoriteContainerDetails singleConDetails =
                      myFavoriteConList[index];
                  return Container(
                    height: screenheight * 0.09,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    margin: EdgeInsets.only(bottom: screenheight * 0.01),
                    decoration: BoxDecoration(
                      color: AppColors.homeScreenContainerBg,
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenwidth * 0.026,
                            vertical: screenheight * 0.013,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.rainCardBg,
                            borderRadius: BorderRadius.circular(12.0),
                          ),

                          child: Image.asset(
                            singleConDetails.weathericon,
                            width: screenwidth * 0.08,
                            height: screenwidth * 0.08,
                          ),
                        ),
                        SizedBox(width: screenwidth * 0.03),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              singleConDetails.citynamewithdeg,
                              style: GoogleFonts.sora(
                                color: AppColors.black,
                                fontSize: screenwidth * 0.038,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: screenheight * 0.02,

                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit_outlined,
                                    size: 15,
                                    color: AppColors.lightThemeSecondaryText,
                                  ),
                                  SizedBox(width: screenwidth * 0.004),
                                  Text(
                                    singleConDetails.location,
                                    style: GoogleFonts.dmSans(
                                      color: AppColors.lightThemeSecondaryText,
                                      fontSize: screenwidth * 0.034,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Spacer(),

                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenwidth * 0.031,
                              vertical: screenheight * 0.016,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.rainCardBg,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Image.asset(
                              "assets/Icon/edit.png",
                              height: 14,
                              width: 14,
                            ),
                          ),
                        ),

                        SizedBox(width: screenwidth * 0.02),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenwidth * 0.031,
                              vertical: screenheight * 0.016,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xffFFE9EA),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Image.asset(
                              "assets/Icon/trash.png",
                              height: 14,
                              width: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
