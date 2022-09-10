import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:weather_app/src/core/components/custom_button.dart';
import 'package:weather_app/src/core/components/custom_dialog_widget.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/weather_cubit/weather_cubit.dart';
import 'package:weather_app/src/features/weather/presentation/pages/location_details_page/location_details_page.dart';
import 'package:weather_app/src/features/weather/presentation/pages/location_page/location_page.dart';

class OtherLocationsPage extends StatelessWidget {
  const OtherLocationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {
        if (state is OtherLocationsUpdatingState ||
            state is AppForecastWeathersFetchingState) {
          Get.dialog(
            const CustomDialogWidget(
              message: 'Adding new location',
              isError: false,
            ),
            barrierDismissible: false,
          );
        } else if (state is WeatherFavouriteLocationUpdatingState) {
          Get.dialog(
            const CustomDialogWidget(
              message: 'Updating favourite location',
              isError: false,
            ),
            barrierDismissible: false,
          );
        } else if (state is SingleOtherLocationRemovingState) {
          Get.dialog(
            const CustomDialogWidget(
              message: 'Removing Single Location',
              isError: false,
            ),
            barrierDismissible: false,
          );
        } else if (state is OtherLocationsUpdatedState ||
            state is WeatherFavouriteLocationUpdatedState ||
            state is SingleOtherLocationRemovedState ||
            state is AppForecastWeathersFetchedState) {
          Get.back();
        } else if (state is SingleOtherLocationRemovingErrorState) {
          Get.dialog(
            CustomDialogWidget(
              message: state.errMessage,
              isError: true,
            ),
            barrierDismissible: false,
          );
        } else if (state is OtherLocationsUpdatingErrorState) {
          Get.dialog(
            CustomDialogWidget(
              message: state.errMessage,
              isError: true,
            ),
            barrierDismissible: false,
          );
        }
      },
      builder: (_, state) {
        final cubit = WeatherCubit.get(context);
        final list = cubit.otherForecasts.reversed.toList();
        return Scaffold(
          backgroundColor: cubit.mode == ThemeMode.dark
              ? Colors.blueGrey.shade800
              : Theme.of(context).canvasColor,
          appBar: AppBar(
            title: const Text("Other Locations"),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (_, index) {
                          return ListTile(
                            onTap: () {
                              Get.to(
                                () => LocationDetailsPage(
                                  forecastWeatherEntity: list[index],
                                ),
                              );
                            },
                            leading: IconButton(
                              onPressed: () async {
                                if (list[index].locationDataEntity.name !=
                                    cubit.currentForecast!.locationDataEntity
                                        .name) {
                                  await WeatherCubit.get(context)
                                      .updateFavouriteLocation(
                                          list[index].inputName);
                                }
                              },
                              icon: Icon(
                                list[index].locationDataEntity.name ==
                                        cubit.currentForecast!
                                            .locationDataEntity.name
                                    ? Icons.favorite_outlined
                                    : Icons.favorite_outline,
                                color: Colors.white,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    list[index].locationDataEntity.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: cubit.mode == ThemeMode.dark
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    if (list[index].locationDataEntity.name !=
                                        cubit.currentForecast!
                                            .locationDataEntity.name) {
                                      await WeatherCubit.get(context)
                                          .removeSingleLocation(
                                              list[index].inputName);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  list[index]
                                      .currentWeatherDataEntity
                                      .weatherConditionDataEntity
                                      .iconPath,
                                  width: 50,
                                  height: 50,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "${list[index].currentWeatherDataEntity.temp_c.toInt()}°",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: cubit.mode == ThemeMode.dark
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CustomButton(
                      text: 'Add New Location',
                      onTap: () {
                        Get.to(
                          () => const LocationPage(
                            isStartUp: false,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
