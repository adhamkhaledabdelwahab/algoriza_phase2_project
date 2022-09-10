// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:weather_app/src/features/weather/domain/entities/forecast_entities/forecast_astro_data_entity.dart';

class ForecastAstroDataModel extends ForecastAstroDataEntity {
  static const String _sunriseKey = 'sunrise';
  static const String _sunsetKey = 'sunset';
  static const String _moonriseKey = 'moonrise';
  static const String _moonSetKey = 'moonset';
  static const String _moon_phaseKey = 'moon_phase';
  static const String _moon_illuminationKey = 'moon_illumination';

  const ForecastAstroDataModel({
    required String sunrise,
    required String sunset,
    required String moonrise,
    required String moonSet,
    required String moon_phase,
    required double moon_illumination,
  }) : super(
          sunrise: sunrise,
          sunset: sunset,
          moonSet: moonSet,
          moonrise: moonrise,
          moon_phase: moon_phase,
          moon_illumination: moon_illumination,
        );

  Map<String, dynamic> toJson() {
    return {
      _sunriseKey: sunrise,
      _sunsetKey: sunset,
      _moonriseKey: moonrise,
      _moonSetKey: moonSet,
      _moon_phaseKey: moon_phase,
      _moon_illuminationKey: moon_illumination,
    };
  }

  factory ForecastAstroDataModel.fromJson(Map<String, dynamic> json) {
    return ForecastAstroDataModel(
      sunrise: json[_sunriseKey],
      sunset: json[_sunsetKey],
      moonrise: json[_moonriseKey],
      moonSet: json[_moonSetKey],
      moon_phase: json[_moon_phaseKey],
      moon_illumination: double.parse(json[_moon_illuminationKey] as String),
    );
  }
}
