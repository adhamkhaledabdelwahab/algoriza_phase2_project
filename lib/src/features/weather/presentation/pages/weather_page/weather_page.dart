import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:weather_app/src/core/components/custom_dialog_widget.dart';
import 'package:weather_app/src/core/components/custom_drawer.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/weather_cubit/weather_cubit.dart';
import 'package:weather_app/src/features/weather/presentation/pages/splash_page/splash_page.dart';
import 'package:weather_app/src/features/weather/presentation/widgets/weather_page_widgets/weather_body.dart';
import 'package:weather_app/src/features/weather/presentation/widgets/weather_page_widgets/weather_drawer_body.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {
        debugPrint('$state');
        if (state is AppFactoryResetingState) {
          Get.dialog(
            const CustomDialogWidget(
              message: 'App Factory Reseting',
              isError: false,
            ),
            barrierDismissible: false,
          );
        } else if (state is AppFactoryResetedState) {
          Get.offAll(() => const SplashPage());
        } else if (state is AppFactoryResetingErrorState) {
          Get.dialog(
            const CustomDialogWidget(
              message: 'App Factory Reseting',
              isError: true,
            ),
            barrierDismissible: false,
          );
        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: WeatherCustomDrawer(
            drawer: WeatherDrawerBody(),
            child: WeatherBody(),
          ),
        );
      },
    );
  }
}
