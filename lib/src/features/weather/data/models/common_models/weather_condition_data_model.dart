import 'package:weather_app/src/features/weather/domain/entities/common_entity/weather_condition_data_entity.dart';

class WeatherConditionDataModel extends WeatherConditionDataEntity {
  static const String _textKey = 'text';
  static const String _iconPathKey = 'icon';

  const WeatherConditionDataModel({
    required String text,
    required String iconPath,
  }) : super(
          text: text,
          iconPath: iconPath,
        );

  Map<String, dynamic> toJson() {
    return {
      _textKey: text,
      _iconPathKey: iconPath,
    };
  }

  factory WeatherConditionDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherConditionDataModel(
      iconPath: (json[_iconPathKey] as String)
          .replaceFirst("//cdn.weatherapi.com/", ""),
      text: json[_textKey],
    );
  }
}
