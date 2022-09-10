import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/core/components/custom_drawer.dart';
import 'package:weather_app/src/core/utils/week_day_util.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/weather_cubit/weather_cubit.dart';
import 'package:weather_app/src/features/weather/presentation/widgets/weather_page_widgets/sliver_app_bar_top.dart';
import 'package:weather_app/src/features/weather/presentation/widgets/weather_page_widgets/sliver_app_bar_bottom.dart';

class CustomSliverAppBar extends StatefulWidget {
  const CustomSliverAppBar({Key? key}) : super(key: key);

  @override
  State<CustomSliverAppBar> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  ValueNotifier<bool> valueNotifier = ValueNotifier(true);

  void removeDemo() {
    valueNotifier.removeListener(doTaskWhenNotified);
  }

  void addDemo() {
    valueNotifier.addListener(doTaskWhenNotified);
  }

  void doTaskWhenNotified() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  void initState() {
    addDemo();
    super.initState();
  }

  @override
  void dispose() {
    removeDemo();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        final cubit = WeatherCubit.get(context);
        final locationName = cubit.currentForecast!.locationDataEntity.name;
        final tempC =
            cubit.currentForecast!.currentWeatherDataEntity.temp_c.toInt();
        final iconPath = cubit.currentForecast!.currentWeatherDataEntity
            .weatherConditionDataEntity.iconPath;
        final maxC = cubit
            .currentForecast!.forecastWeatherDataEntity.dayForecastDataEntities
            .firstWhere((element) => element.date.day == DateTime.now().day)
            .forecastDayDataEntity
            .maxTemp_c
            .toInt();
        final minC = cubit
            .currentForecast!.forecastWeatherDataEntity.dayForecastDataEntities
            .firstWhere((element) => element.date.day == DateTime.now().day)
            .forecastDayDataEntity
            .minTemp_c
            .toInt();
        final feelsLike =
            cubit.currentForecast!.currentWeatherDataEntity.feelsLike_c.toInt();
        final day = getPartWeekdayName(cubit
            .currentForecast!.currentWeatherDataEntity.last_updated.weekday);
        final timeFormat = DateFormat('hh:mm aa').format(
            cubit.currentForecast!.currentWeatherDataEntity.last_updated);
        final time = '$day $timeFormat';
        return SliverAppBar(
          title: !valueNotifier.value
              ? CustomSliverAppBarTop(
                  location: locationName,
                )
              : null,
          backgroundColor: Theme.of(context).canvasColor,
          bottom: !valueNotifier.value
              ? PreferredSize(
                  preferredSize: const Size(
                    double.infinity,
                    110,
                  ),
                  child: CustomSliverAppBarBottom(
                    iconPath: iconPath,
                    tempC: tempC,
                    maxC: maxC,
                    minC: minC,
                    time: time,
                  ),
                )
              : null,
          pinned: true,
          expandedHeight: 300.0,
          leading: IconButton(
            onPressed: () {
              WeatherCustomDrawer.toggleDrawer(context);
            },
            icon: const Icon(Icons.menu),
            color: Colors.white,
            iconSize: 30,
          ),
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.biggest.height > 166 && !valueNotifier.value) {
                valueNotifier.value = true;
              } else if (constraints.biggest.height == 56) {
                valueNotifier.value = false;
              }
              return FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                    left: 30,
                    right: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$tempC°",
                            style: const TextStyle(
                              fontSize: 60,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Image.asset(
                            iconPath,
                            width: 130,
                            height: 130,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      Text(
                        locationName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "$maxC° / $minC° Feels like $feelsLike°",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
