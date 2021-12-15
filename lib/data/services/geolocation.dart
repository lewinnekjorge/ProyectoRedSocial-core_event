import 'package:geolocator/geolocator.dart';
import 'package:core_event/domain/services/location.dart';

class GpsService implements LocationInterface {
  @override
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }
}
