import 'package:equatable/equatable.dart';

class WeatherConditionDataEntity extends Equatable {
  final String text;
  final String iconPath;

  const WeatherConditionDataEntity({
    required this.text,
    required this.iconPath,
  });

  @override
  List<Object?> get props => [
        text,
        iconPath,
      ];
}
