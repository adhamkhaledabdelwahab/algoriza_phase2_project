import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/location_cubit/location_cubit.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/weather_cubit/weather_cubit.dart';
import 'package:weather_app/src/features/weather/presentation/pages/splash_page/splash_page.dart';
import 'package:weather_app/src/injection_container.dart';

Future<void> main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<WeatherCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<LocationCubit>(),
        ),
      ],
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Weather App',
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.blue,
              canvasColor: Colors.blueAccent.shade100,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              canvasColor: Colors.black,
            ),
            themeMode: WeatherCubit
                .get(context)
                .mode,
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
