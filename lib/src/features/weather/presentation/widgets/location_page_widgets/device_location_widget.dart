import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/location_cubit/location_cubit.dart';

class DeviceLocationWidget extends StatelessWidget {
  const DeviceLocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            readOnly: true,
            maxLines: null,
            autofocus: false,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            cursorColor: Colors.grey[700],
            decoration: InputDecoration(
              errorMaxLines: 100,
              suffixIcon: IconButton(
                onPressed: () async {
                  await LocationCubit.get(context).getCurrentLocation();
                },
                icon: const Icon(Icons.location_on_outlined),
                iconSize: 35,
                color: Colors.blue,
              ),
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 18,
              ),
              fillColor: Colors.grey.shade300,
              hintText: 'Device Location',
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        );
      },
    );
  }
}
