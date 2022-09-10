import 'package:flutter/material.dart';
import 'package:weather_app/src/features/weather/domain/entities/forecast_weather_entity.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/weather_cubit/weather_cubit.dart';

class LocationDetailsPage extends StatelessWidget {
  const LocationDetailsPage({
    Key? key,
    required this.forecastWeatherEntity,
  }) : super(key: key);

  final ForecastWeatherEntity forecastWeatherEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WeatherCubit.get(context).mode == ThemeMode.dark
          ? Colors.blueGrey.shade700
          : Theme.of(context).canvasColor,
      appBar: AppBar(
        title: const Text("Location Details"),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Name: ",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                forecastWeatherEntity.locationDataEntity.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Region: ",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${forecastWeatherEntity.locationDataEntity.region}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Country: ",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                forecastWeatherEntity.locationDataEntity.country,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Temp_c: ",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${forecastWeatherEntity.currentWeatherDataEntity.temp_c.toInt()}°",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Feels like: ",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${forecastWeatherEntity.currentWeatherDataEntity.feelsLike_c.toInt()}°",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Condition: ",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                forecastWeatherEntity
                    .currentWeatherDataEntity.weatherConditionDataEntity.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
