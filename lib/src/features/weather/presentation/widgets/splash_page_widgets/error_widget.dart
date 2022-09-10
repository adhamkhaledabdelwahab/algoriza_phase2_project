import 'package:flutter/material.dart';
import 'package:weather_app/src/core/components/custom_button.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/weather_cubit/weather_cubit.dart';

class SplashErrorWidget extends StatelessWidget {
  const SplashErrorWidget({
    Key? key,
    required this.message,
  }) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning,
                color: Colors.red,
                size: 25,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
            text: 'Reload',
            onTap: () {
              WeatherCubit.get(context).fetchAppForecastWeathers();
            },
          ),
        ],
      ),
    );
  }
}
