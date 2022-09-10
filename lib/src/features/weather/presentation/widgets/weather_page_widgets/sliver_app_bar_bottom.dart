import 'package:flutter/material.dart';

class CustomSliverAppBarBottom extends StatelessWidget {
  const CustomSliverAppBarBottom({
    Key? key,
    required this.iconPath,
    required this.tempC,
    required this.maxC,
    required this.minC,
    required this.time,
  }) : super(key: key);

  final String iconPath;
  final int tempC;
  final int maxC;
  final int minC;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "$tempC°",
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(
                    "$maxC°"
                    "/"
                    "$minC°",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
          FittedBox(
            child: Image.asset(
              iconPath,
              height: 120,
              width: 120,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
