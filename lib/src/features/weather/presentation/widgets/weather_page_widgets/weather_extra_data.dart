import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/weather_cubit/weather_cubit.dart';

class WeatherExtraData extends StatelessWidget {
  const WeatherExtraData({Key? key}) : super(key: key);

  String getUVIndexText(double uv) {
    if (uv >= 1 && uv <= 2) {
      return 'Low';
    } else if (uv >= 3 && uv <= 5) {
      return 'Moderate';
    } else if (uv >= 6 && uv <= 7) {
      return 'High';
    } else if (uv >= 8 && uv <= 10) {
      return 'Very high';
    } else {
      return 'Extreme';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        final cubit = WeatherCubit.get(context);
        final current = cubit.currentForecast!.currentWeatherDataEntity;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image.asset(
                  'weather/64x64/day/113.png',
                  width: 100,
                ),
                const Text(
                  "UV index",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  getUVIndexText(current.uv),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: VerticalDivider(
                color: Colors.white38,
                thickness: 1,
                width: 0,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Icon(
                    Icons.air,
                    color: Colors.yellow,
                    size: 50,
                  ),
                ),
                const Text(
                  "Wind",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${current.wind_kph} km/h",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: VerticalDivider(
                color: Colors.white38,
                thickness: 1,
                width: 0,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Icon(
                    Icons.water_drop,
                    color: Colors.blue.shade100,
                    size: 50,
                  ),
                ),
                const Text(
                  "Humidity",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${current.humidity}%",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
