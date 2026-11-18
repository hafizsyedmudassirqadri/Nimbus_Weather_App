import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheather_app/constants/api_constants.dart';
import 'package:wheather_app/controller/api_controller.dart';
import 'package:wheather_app/models/cities_weather_model.dart';

class HomeController extends GetxController {
  RxList<dynamic> continentList = [].obs;

  RxInt selectedContinentListIndex = 0.obs;

  String selectedregion = "";

  @override
  onInit() {
    _searchWorker = debounce<String>(
      _searchInput,
      (query) {
        if (isClosed) return;
        _searchQuery = query;
        _applySearch();
      },
      time: const Duration(milliseconds: 500),
    );
    _loadStudentName();
    getRegions();
    getCities();
    super.onInit();
  }

  RxBool isRegionLoading = false.obs;

  Future<void> _loadStudentName() async {
    final prefs = await SharedPreferences.getInstance();
    studentName.value = prefs.getString('user_name') ?? 'User';
  }

  final RxString studentName = ''.obs;

  bool isCitiesLoading = false;
  int cityPage = 1;
  int currentPage = 0;
  int totalPage = 0;
  List<Cities> cities = [];
  List<Cities> _allLoadedCities = [];
  bool hasNext = true;
  RxInt totalCities = 0.obs;
  final RxString _searchInput = ''.obs;
  late final Worker _searchWorker;
  String _searchQuery = '';

  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  void searchCities(String query) {
    _searchInput.value = query.trim().toLowerCase();
  }

  @override
  void onClose() {
    _searchWorker.dispose();
    super.onClose();
  }

  void _applySearch() {
    if (_searchQuery.isEmpty) {
      cities = List<Cities>.from(_allLoadedCities);
    } else {
      cities = _allLoadedCities.where((city) {
        final searchable =
            '${city.name ?? ''} ${city.country ?? ''} ${city.region ?? ''}'
                .toLowerCase();
        return searchable.contains(_searchQuery);
      }).toList();
    }
    update();
  }

  int get displayedCityCount =>
      _searchQuery.isEmpty ? totalCities.value : cities.length;

  // Initials nikalne ki function controller ke andar
  String get initials {
    final nameParts = studentName.value
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (nameParts.length >= 2) {
      return '${nameParts.first[0]}${nameParts.last[0]}'.toUpperCase();
    } else if (nameParts.isNotEmpty) {
      return nameParts.first[0].toUpperCase();
    }
    return '';
  }

  void regionTap(index) {
    selectedContinentListIndex.value = index;
    selectedregion = index == 0 ? '' : continentList[index].toString();
    getCities(reset: true);

    print(continentList[index]);
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

  Future<void> getCities({bool reset = false}) async {
    Map<String, String> queryParam = {};

    if (reset) {
      cities.clear();
      _allLoadedCities.clear();
      _searchInput.value = '';
      _searchQuery = '';
      totalCities.value = 0;
      cityPage = 1;
      hasNext = true;
      isCitiesLoading = false;

      update();
    }

    if (selectedregion.isNotEmpty && selectedContinentListIndex.value != 0) {
      queryParam.addAll({"region": selectedregion});
    }
    queryParam.addAll({"page": cityPage.toString(), "limit": "8"});

    if (isCitiesLoading || !hasNext) return;
    isCitiesLoading = true;
    update();

    try {
      var response = await ApiController().get(
        url: ApiConstants.cityApi,
        queryParams: queryParam,
      );
      if (response.$1 == 200 || response.$1 == 201) {
        final citiesWeather = citiesWeatherFromJson(response.$2);
        // continentList.add("All");
        if (citiesWeather.data != null) {
          _allLoadedCities.addAll(citiesWeather.data!);
          _applySearch();
          totalCities.value =
              citiesWeather.meta?.total ?? _allLoadedCities.length;
          hasNext = citiesWeather.meta?.hasNext ?? false;
          totalPage = citiesWeather.meta?.totalPages ?? 0;
          currentPage = citiesWeather.meta?.page ?? cityPage;
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
