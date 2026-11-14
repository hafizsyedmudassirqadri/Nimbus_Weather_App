import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wheather_app/constants/api_constants.dart';
import 'package:wheather_app/controller/api_controller.dart';
import 'package:wheather_app/models/cities_weather_model.dart';

class HomeController extends GetxController {
  RxList<dynamic> continentList = [].obs;
  RxInt selectedContinentListIndex = 0.obs;
  @override
  onInit() {
    getRegions();
    getCities();
    super.onInit();
  }

  RxBool isRegionLoading = false.obs;

  var studentName = "Muddassir Shah".obs;

  bool isCitiesLoading = false;
  int cityPage = 1;
  int currentPage = 0;
  int totalPage = 0;
  List<Cities> cities = [];
  bool hasNext = true;

  // Initials nikalne ki function controller ke andar
  String get initials {
    List<String> nameParts = studentName.value.trim().split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    } else if (nameParts.isNotEmpty && nameParts[0].isNotEmpty) {
      return nameParts[0][0].toUpperCase();
    }
    return '';
  }

  void regionTap(index) {
    selectedContinentListIndex.value = index;
  }

  Future<void> getRegions() async {
    isRegionLoading.value = true;

    var response = await ApiController().get(url: ApiConstants.regionApi);
    try {
      if (response.$1 == 200 || response.$1 == 201) {
        var regionResponse = jsonDecode(response.$2)["data"];
        continentList.add("All");
        for (var i in regionResponse) {
          continentList.add(i["name"]);
        }
      } else {}
    } catch (e) {
      Text("ERROR$e");
    } finally {
      isRegionLoading.value = false;
    }
  }

  Future<void> getCities() async {
    if (isCitiesLoading || !hasNext) return;
    isCitiesLoading = true;
    update();

    try {
      var response = await ApiController().get(
        url: ApiConstants.cityApi,
        queryParams: {"page": cityPage.toString(), "limit": "8"},
      );
      if (response.$1 == 200 || response.$1 == 201) {
        final citiesWeather = citiesWeatherFromJson(response.$2);
        // continentList.add("All");
        if (citiesWeather.data != null) {
          cities.addAll(citiesWeather.data!);
          hasNext = citiesWeather.meta!.hasNext!;
          totalPage = citiesWeather.meta!.totalPages!;
          currentPage = citiesWeather.meta!.page!;
          cityPage++;
        }
      } else {}
    } catch (e) {
      Text("ERROR$e");
    } finally {
      isCitiesLoading = false;
      update();
    }
  }
}
