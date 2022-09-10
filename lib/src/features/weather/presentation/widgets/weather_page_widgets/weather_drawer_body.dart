import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:weather_app/src/core/components/custom_drawer.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/weather_cubit/weather_cubit.dart';
import 'package:weather_app/src/features/weather/presentation/pages/other_locations_page/other_locations_page.dart';

class WeatherDrawerBody extends StatelessWidget {
  const WeatherDrawerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        final cubit = WeatherCubit.get(context);
        final favName = cubit.currentForecast!.locationDataEntity.name;
        final favIconPath = cubit.currentForecast!.currentWeatherDataEntity
            .weatherConditionDataEntity.iconPath;
        final favTempC =
            cubit.currentForecast!.currentWeatherDataEntity.temp_c.toInt();
        final otherName = cubit.otherForecasts.last.locationDataEntity.name;
        final otherIconPath = cubit.otherForecasts.last.currentWeatherDataEntity
            .weatherConditionDataEntity.iconPath;
        final otherTempC =
            cubit.otherForecasts.last.currentWeatherDataEntity.temp_c.toInt();
        return SafeArea(
          child: Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: HexColor("#313A43"),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            cubit.toggleThemeMode();
                          },
                          padding: const EdgeInsets.only(left: 12),
                          icon: Icon(cubit.mode == ThemeMode.dark
                              ? Icons.light_mode
                              : Icons.dark_mode),
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {
                            WeatherCustomDrawer.toggleDrawer(context);
                          },
                          padding: const EdgeInsets.only(left: 12),
                          icon: const Icon(Icons.arrow_back_outlined),
                          color: Colors.white,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              "Favourite Location",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        const Tooltip(
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 10,
                          ),
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                          message:
                              'Favourite Location: \n\nThe main location appears on app launch',
                          child: Icon(
                            Icons.info_outline,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_pin,
                                color: Colors.white,
                                size: 15,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  favName,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              favIconPath,
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "$favTempC°",
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const DottedLine(
                      dashColor: Colors.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.add_location_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              "Other Locations",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_pin,
                                color: Colors.white,
                                size: 15,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  otherName,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              otherIconPath,
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "$otherTempC°",
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: HexColor("#4F5762"),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          Get.to(() => const OtherLocationsPage());
                          WeatherCustomDrawer.toggleDrawer(context);
                        },
                        child: const Text(
                          "Manage locations",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const DottedLine(
                      dashColor: Colors.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.transparent,
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {},
                        child: const ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.only(left: 15),
                          leading: Icon(
                            Icons.info_outline,
                            color: Colors.white,
                            size: 30,
                          ),
                          title: Text(
                            "Report wrong location",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.transparent,
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {},
                        child: const ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.only(left: 15),
                          leading: Icon(
                            Icons.headset_mic_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                          title: Text(
                            "Contact us",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.transparent,
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {
                          WeatherCubit.get(context).factoryReset();
                          WeatherCustomDrawer.toggleDrawer(context);
                        },
                        child: const ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.only(left: 15),
                          leading: Icon(
                            Icons.lock_reset_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                          title: Text(
                            "Factory Reset",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
