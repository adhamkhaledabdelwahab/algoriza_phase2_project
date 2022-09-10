import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/weather_cubit/weather_cubit.dart';

class DayHourWeatherWidget extends StatefulWidget {
  const DayHourWeatherWidget({Key? key}) : super(key: key);

  @override
  State<DayHourWeatherWidget> createState() => _DayHourWeatherWidgetState();
}

class _DayHourWeatherWidgetState extends State<DayHourWeatherWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        final cubit = WeatherCubit.get(context);
        final todayHours = cubit.currentForecast!.forecastWeatherDataEntity
            .dayForecastDataEntities[0].forecastHourDataEntities;
        final chartData = todayHours
            .map(
              (e) => Data(
                degree: e.temp_c.toInt(),
                hour: e.time.hour,
                humidity: e.humidity,
                iconPath: e.weatherConditionDataEntity.iconPath,
              ),
            )
            .toList();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 175,
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemExtent: 55,
                itemCount: chartData.length,
                itemBuilder: (_, index) {
                  String apm = '';
                  int hour = chartData[index].hour;
                  if (hour < 12) {
                    apm = 'AM';
                  } else {
                    apm = 'PM';
                  }
                  if (hour % 12 == 0) {
                    hour = 12;
                  } else {
                    hour %= 12;
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "$hour $apm",
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Image.asset(
                        chartData[index].iconPath,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "${chartData[index].degree}°",
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.water_drop,
                              color: Colors.blue.shade100,
                              size: 15,
                            ),
                            Text(
                              "${chartData[index].humidity}%",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 170,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      color: Colors.white,
                      spots: chartData
                          .map(
                            (e) => FlSpot(
                              e.hour.toDouble(),
                              e.degree.toDouble(),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                  borderData: FlBorderData(
                    border: const Border(
                      bottom: BorderSide(color: Colors.white),
                      left: BorderSide(color: Colors.white),
                      right: BorderSide(color: Colors.white),
                      top: BorderSide(color: Colors.white),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 5,
                        getTitlesWidget: (val, met) => Text(
                          "${val.toInt() % 12 == 0 ? 12 : val.toInt() % 12} ${val.toInt() < 12 ? 'am' : 'pm'}",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (val, met) => Text(
                          "${val.toInt()}°",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                ),
                swapAnimationDuration: const Duration(milliseconds: 150),
                // Optional
                swapAnimationCurve: Curves.linear,
              ),
            ),
          ],
        );
      },
    );
  }
}

class Data {
  int degree;
  int hour;
  int humidity;
  String iconPath;

  Data({
    required this.degree,
    required this.hour,
    required this.humidity,
    required this.iconPath,
  });
}
