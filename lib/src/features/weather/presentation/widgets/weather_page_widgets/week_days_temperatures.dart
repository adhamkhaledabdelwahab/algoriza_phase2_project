import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/core/utils/week_day_util.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/weather_cubit/weather_cubit.dart';

class WeekDaysTemp extends StatelessWidget {
  const WeekDaysTemp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        final cubit = WeatherCubit.get(context);
        final days = cubit
            .currentForecast!.forecastWeatherDataEntity.dayForecastDataEntities;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: days
              .map(
                (e) => Row(
                  children: [
                    Expanded(
                      child: Text(
                        e.date.day ==
                                DateTime.now()
                                    .subtract(const Duration(days: 1))
                                    .day
                            ? "Yesterday"
                            : e.date.day == DateTime.now().day
                                ? 'Today'
                                : getFullWeekdayName(e.date.weekday),
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        e.date.day !=
                                DateTime.now()
                                    .subtract(const Duration(days: 1))
                                    .day
                            ? Row(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.water_drop,
                                        color: Colors.blue.shade100,
                                        size: 15,
                                      ),
                                      Text(
                                        "${e.forecastDayDataEntity.avgHumidity}%",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    e.forecastDayDataEntity
                                        .weatherConditionDataEntity.iconPath,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  Image.asset(
                                    e.forecastDayDataEntity
                                        .weatherConditionDataEntity.iconPath
                                        .replaceFirst('day', 'night'),
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              )
                            : Container(),
                        Text(
                          "${e.forecastDayDataEntity.maxTemp_c.toInt()}° ${e.forecastDayDataEntity.minTemp_c.toInt()}°",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
              .toList(),
        );
      },
    );
  }
}
