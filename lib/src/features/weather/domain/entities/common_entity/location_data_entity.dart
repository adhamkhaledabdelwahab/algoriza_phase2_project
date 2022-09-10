import 'package:equatable/equatable.dart';

class LocationDataEntity extends Equatable {
  final String name;
  final String country;
  final String? region;
  final double latitude;
  final double longitude;
  final String timeZoneId;

  const LocationDataEntity({
    required this.name,
    required this.country,
    this.region,
    required this.latitude,
    required this.longitude,
    required this.timeZoneId,
  });

  @override
  List<Object?> get props => [
        name,
        country,
        region,
        latitude,
        longitude,
        timeZoneId,
      ];
}
