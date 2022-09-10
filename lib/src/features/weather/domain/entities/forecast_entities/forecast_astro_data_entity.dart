// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class ForecastAstroDataEntity extends Equatable {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonSet;
  final String moon_phase;
  final double moon_illumination;

  const ForecastAstroDataEntity({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonSet,
    required this.moon_phase,
    required this.moon_illumination,
  });

  @override
  List<Object?> get props => [
        sunrise,
        sunset,
        moonrise,
        moonSet,
        moon_phase,
        moon_illumination,
      ];
}
