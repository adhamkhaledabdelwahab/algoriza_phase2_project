import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/core/components/custom_button.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/location_cubit/location_cubit.dart';

class LocationNameWidget extends StatelessWidget {
  const LocationNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LocationCubit, LocationState, String?>(
      selector: (state) {
        return state is LocationTypeFormValidatingErrorState &&
                state.errMessage.contains('Name')
            ? state.errMessage
            : null;
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: LocationCubit.get(context).nameController,
                keyboardType: TextInputType.text,
                maxLines: null,
                autofocus: false,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                cursorColor: Colors.grey[700],
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.text_fields,
                    color: Colors.black,
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 18,
                  ),
                  fillColor: Colors.grey.shade300,
                  errorText: state,
                  errorStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  hintText: 'Location Name',
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
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
                text: 'Fetch Weather',
                onTap: () {
                  LocationCubit.get(context).validateLocationTypeForm();
                }),
          ],
        );
      },
    );
  }
}
