import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/location_cubit/location_cubit.dart';
import 'package:weather_app/src/features/weather/presentation/widgets/location_page_widgets/location_type_selector_widget.dart';

class LocationFormWidget extends StatelessWidget {
  const LocationFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        String? message;
        bool loading = false;
        if (state is InputLocationValidatingState ||
            state is DeviceLocationFetchingState) {
          loading = true;
        }
        if (state is InputLocationValidatingErrorState) {
          message = state.errMessage;
        } else if (state is DeviceLocationFetchingErrorState) {
          message = state.errMessage;
        } else if (state is LocationOtherLocationsUpdatingErrorState) {
          message = 'This location already exists!';
        }
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const LocationTypeSelectorWidget(),
                const SizedBox(
                  height: 30,
                ),
                LocationCubit.locationTypes[
                    LocationCubit.get(context).selectedLocationType]!,
                const SizedBox(
                  height: 10,
                ),
                message != null
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.warning,
                                color: Colors.red,
                                size: 25,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                message,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : loading
                        ? const CircularProgressIndicator()
                        : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
