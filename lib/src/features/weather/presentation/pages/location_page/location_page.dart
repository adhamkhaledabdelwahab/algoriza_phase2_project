import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/location_cubit/location_cubit.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/weather_cubit/weather_cubit.dart';
import 'package:weather_app/src/features/weather/presentation/pages/splash_page/splash_page.dart';
import 'package:weather_app/src/features/weather/presentation/widgets/location_page_widgets/location_form_widget.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({
    Key? key,
    required this.isStartUp,
  }) : super(key: key);

  final bool isStartUp;

  @override
  Widget build(BuildContext context) {
    LocationCubit.get(context).initializeLocationPage();
    return BlocConsumer<LocationCubit, LocationState>(
      listener: (_, state) async {
        debugPrint('$state');
        if (state is LocationTypeFormValidatedState ||
            state is DeviceLocationFetchedState) {
          await LocationCubit.get(context).validateLocation();
        } else if (state is InputLocationValidatedState) {
          await LocationCubit.get(context).updateFavouriteLocation();
        } else if (state is LocationOtherLocationsUpdatedState) {
          if (isStartUp) {
            Get.off(() => const SplashPage());
          } else {
            WeatherCubit.get(context).addNewOtherLocations(
              LocationCubit.get(context).validatedLocation!,
            );
            Get.back();
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: WeatherCubit.get(context).mode == ThemeMode.dark
              ? Colors.blueGrey.shade900
              : Theme.of(context).canvasColor,
          body: SafeArea(
            child: Center(
              child: LocationCubit.get(context).selectedLocationType != null
                  ? const LocationFormWidget()
                  : const CircularProgressIndicator(
                      color: Colors.white,
                    ),
            ),
          ),
        );
      },
    );
  }
}
