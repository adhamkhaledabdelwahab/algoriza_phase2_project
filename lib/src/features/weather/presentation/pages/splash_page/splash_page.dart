import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:weather_app/src/core/errors/failures.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/weather_cubit/weather_cubit.dart';
import 'package:weather_app/src/features/weather/presentation/pages/location_page/location_page.dart';
import 'package:weather_app/src/features/weather/presentation/pages/weather_page/weather_page.dart';
import 'package:weather_app/src/features/weather/presentation/widgets/splash_page_widgets/error_widget.dart';
import 'package:weather_app/src/features/weather/presentation/widgets/splash_page_widgets/loading_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WeatherCubit.get(context).fetchAppForecastWeathers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (_, state) {
        debugPrint('$state');
        if (state is AppForecastWeathersFetchingErrorState &&
            state.errMessage == UnKnownFailure().errMessage) {
          Get.off(
            () => const LocationPage(
              isStartUp: true,
            ),
          );
        } else if (state is AppForecastWeathersFetchedState &&
            WeatherCubit.get(context).currentForecast != null &&
            WeatherCubit.get(context).otherForecasts.isNotEmpty) {
          Get.off(() => const WeatherPage());
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: WeatherCubit.get(context).mode == ThemeMode.dark
              ? Colors.blueGrey.shade900
              : Theme.of(context).canvasColor,
          body: SafeArea(
            child: Center(
              child: state is AppForecastWeathersFetchingErrorState &&
                      state.errMessage != UnKnownFailure().errMessage
                  ? SplashErrorWidget(message: state.errMessage)
                  : const SplashLoadingWidget(),
            ),
          ),
        );
      },
    );
  }
}
