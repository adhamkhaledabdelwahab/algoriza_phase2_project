import 'package:flutter/material.dart';

class SplashLoadingWidget extends StatelessWidget {
  const SplashLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'weather/weather_back.png',
          width: 200,
          height: 200,
        ),
        const SizedBox(
          height: 15,
        ),
        const SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "Fetching Current Weather",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
