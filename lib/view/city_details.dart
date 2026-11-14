
import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  static const Color primaryBlue = Color(0xFF3265EF);
  static const Color darkBlue = Color(0xFF1748D9);
  static const Color textColor = Color(0xFF102348);
  static const Color mutedColor = Color(0xFF7183A5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  circleButton(Icons.arrow_back, () {}),
                  circleButton(Icons.favorite_border, () {}),
                ],
              ),

              const SizedBox(height: 12),

              // Main Weather Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6090FF), Color(0xFF1748D9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.location_on_outlined,
                            color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text(
                          'Pakistan · Asia',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Karachi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '28°',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.wb_cloudy_outlined,
                            color: Colors.white,
                            size: 55,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Partly cloudy · Feels like 29°',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Weather Details
              Row(
                children: const [
                  Expanded(
                    child: WeatherInfoCard(
                      icon: Icons.water_drop_outlined,
                      title: 'Humidity',
                      value: '64%',
                      color: Color(0xFF2876FF),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: WeatherInfoCard(
                      icon: Icons.air,
                      title: 'Wind',
                      value: '14 km/h',
                      color: Color(0xFF2876FF),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: WeatherInfoCard(
                      icon: Icons.sunny,
                      title: 'UV index',
                      value: '6',
                      color: Color(0xFF2876FF),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // 5 Day Forecast
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.07),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '5-day forecast',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        ForecastItem(
                          day: 'Tue',
                          temperature: '29°',
                          icon: Icons.wb_sunny_outlined,
                          color: Colors.orange,
                        ),
                        ForecastItem(
                          day: 'Wed',
                          temperature: '30°',
                          icon: Icons.wb_cloudy_outlined,
                          color: Colors.orange,
                        ),
                        ForecastItem(
                          day: 'Thu',
                          temperature: '31°',
                          icon: Icons.wb_sunny_outlined,
                          color: Colors.orange,
                        ),
                        ForecastItem(
                          day: 'Fri',
                          temperature: '28°',
                          icon: Icons.cloud_outlined,
                          color: Colors.blue,
                        ),
                        ForecastItem(
                          day: 'Sat',
                          temperature: '26°',
                          icon: Icons.thunderstorm_outlined,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Things to Do Heading
              const Text(
                'Things to do',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),

              const SizedBox(height: 10),

              // Places List
              const PlaceCard(
                icon: Icons.wb_sunny_outlined,
                name: 'Clifton Beach',
                category: 'Beach',
              ),

              const SizedBox(height: 10),

              const PlaceCard(
                icon: Icons.account_balance_outlined,
                name: 'Mohatta Palace',
                category: 'Museum',
              ),

              const SizedBox(height: 10),

              const PlaceCard(
                icon: Icons.account_balance_outlined,
                name: 'Quaid-e-Azam Mausoleum',
                category: 'Landmark',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget circleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: textColor,
          size: 22,
        ),
      ),
    );
  }
}

// Weather Information Card
class WeatherInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const WeatherInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 13, color: color),
              const SizedBox(width: 3),
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9,
                    color: WeatherScreen.mutedColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: WeatherScreen.textColor,
            ),
          ),
        ],
      ),
    );
  }
}

// Forecast Item
class ForecastItem extends StatelessWidget {
  final String day;
  final String temperature;
  final IconData icon;
  final Color color;

  const ForecastItem({
    super.key,
    required this.day,
    required this.temperature,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          day,
          style: const TextStyle(
            fontSize: 10,
            color: WeatherScreen.mutedColor,
          ),
        ),
        const SizedBox(height: 9),
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 6),
        Text(
          temperature,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: WeatherScreen.textColor,
          ),
        ),
      ],
    );
  }
}

// Things to Do Place Card
class PlaceCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final String category;

  const PlaceCard({
    super.key,
    required this.icon,
    required this.name,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF3976FF),
              size: 19,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: WeatherScreen.textColor,
              ),
            ),
          ),
          Text(
            category,
            style: const TextStyle(
              fontSize: 9,
              color: WeatherScreen.mutedColor,
            ),
          ),
        ],
      ),
    );
  }
}
