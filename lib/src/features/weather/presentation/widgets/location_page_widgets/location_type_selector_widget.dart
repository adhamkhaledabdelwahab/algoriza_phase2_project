import 'package:flutter/material.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/location_cubit/location_cubit.dart';

class LocationTypeSelectorWidget extends StatelessWidget {
  const LocationTypeSelectorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonFormField<String>(
        dropdownColor: Colors.teal.shade100,
        borderRadius: BorderRadius.circular(15),
        value: LocationCubit.get(context).selectedLocationType,
        decoration: InputDecoration(
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 18,
          ),
          fillColor: Colors.grey.shade300,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
        ),
        icon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 30,
          color: Colors.black,
        ),
        items: LocationCubit.locationTypes.keys
            .map(
              (e) => DropdownMenuItem<String>(
                value: e,
                child: Text(
                  e,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (val) {
          if (val != null) {
            LocationCubit.get(context).updateSelectedLocationType(val);
          }
        },
      ),
    );
  }
}
