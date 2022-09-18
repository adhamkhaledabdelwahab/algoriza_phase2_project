import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/weather_cubit/weather_cubit.dart';

class ResetFactoryAlertDialog extends StatelessWidget {
  const ResetFactoryAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: const [
              Icon(
                Icons.warning_amber_outlined,
                color: Colors.red,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Reset Factory",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Are you sure you want to perform Factory Reset process,"
            "\n This process remove all your data?",
            style: TextStyle(
              height: 1.35,
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    WeatherCubit.get(context).factoryReset();
                  },
                  child: const Text("OK"),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Cancel"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
