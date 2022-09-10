import 'package:weather_app/src/core/constants/http_consts.dart';

Uri fetchRequiredUri({
  required String location,
  required String weatherType,
  String? date,
  String? daysNumber,
}) {
  final currentParams = {
    keyParam: apiKey,
    queryParam: location,
  };
  if (daysNumber != null) {
    currentParams[daysParam] = daysNumber;
  }
  if (date != null) {
    currentParams[dateParam] = date;
  }
  final uri = Uri.http(
    baseUrl,
    '$version/$weatherType',
    currentParams,
  );
  return uri;
}
