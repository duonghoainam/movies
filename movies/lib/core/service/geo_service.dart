import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

var locationProvider =
StateNotifierProvider<LocationService, LocationState>((ref) {
  var service = LocationService();
  service.requestPermission();
  service.getLocationPermission();
  service.getCurrentPosition();
  return service;
});

class LocationState {
  final double lat;
  final double lng;
  final bool isEnabled;

  const LocationState.empty(
      {this.lat = 0, this.lng = 0, this.isEnabled = false});

//<editor-fold desc="Data Methods">
  const LocationState({
    required this.lat,
    required this.lng,
    required this.isEnabled,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is LocationState &&
              runtimeType == other.runtimeType &&
              lat == other.lat &&
              lng == other.lng &&
              isEnabled == other.isEnabled);

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode ^ isEnabled.hashCode;

  @override
  String toString() {
    return 'LocationState{' +
        ' lat: $lat,' +
        ' lng: $lng,' +
        ' isEnabled: $isEnabled,' +
        '}';
  }

  LocationState copyWith({
    double? lat,
    double? lng,
    bool? isEnabled,
  }) {
    return LocationState(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
//</editor-fold>
}

class LocationService extends StateNotifier<LocationState> {
  LocationService() : super(LocationState.empty()) {
    // MeteorService().user.listen((user) {
    //   final enabledLocation = user?.profile.appSettings.enableLocation ?? false;
    //   // if (enabledLocation != state.isEnabled)
    //   state = state.copyWith(isEnabled: enabledLocation);
    // });
  }

  FutureOr<void> getCurrentPosition() async {
    try {
      Position currLocation = await Geolocator.getCurrentPosition();
      state = state.copyWith(
          lat: currLocation.latitude, lng: currLocation.longitude);
    } on LocationServiceDisabledException catch (e) {
      // AppLog.warning(e);
      state = state.copyWith(isEnabled: false);
      // return Future.error(e);
    }
  }

  void getLocationPermission() async {
    // if (!PrefsInstance().settings.geo) {
    //   state = state.copyWith(isEnabled: false);
    //   return;
    // }
    LocationPermission permission = await Geolocator.checkPermission();
    // AppLog.print(PrefsInstance().settings.geo);

    state = switch (permission) {
      LocationPermission.always => state.copyWith(isEnabled: true),
      LocationPermission.whileInUse => state.copyWith(isEnabled: true),
      _ => state.copyWith(isEnabled: false)
    };
  }

  FutureOr<void> requestPermission() async {
    // if (PrefsInstance().settings.geo)
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      state = switch (permission) {
        LocationPermission.always => state.copyWith(isEnabled: true),
        LocationPermission.whileInUse => state.copyWith(isEnabled: true),
        LocationPermission.deniedForever => state.copyWith(isEnabled: false),
        _ => state.copyWith(isEnabled: false)
      };
    } on PermissionDefinitionsNotFoundException catch (e,stk) {
      print(stk);
      state = state.copyWith(isEnabled: false);
    }
  }

  void updatePrefPermission(bool sth) async {
    // PrefsInstance().saveSettings(PrefsInstance().settings.copyWith(geo: sth));
    // var p = await MeteorService().updateProfile({'enableLocation': sth});

    await requestPermission();
    await getCurrentPosition();

    // var user = User.fromJson(p);
    // state = state.copyWith(isEnabled: user.profile.appSettings.enableLocation);

    // getLocationPermission();
    //
    // if (!state.isEnabled) {
    //   requestPermission();
    // }
    //
    // getCurrentPosition();
  }

// getServicePermission() async {
//   if (Platform.isAndroid) {
//     var serviceEnabled = await getServicePermission();
//     if (!serviceEnabled) {
//       // showSnackBar(context, AppString.errLocationPermission, error: true);
//       ser();
//       return;
//     }
//   }
// }

// void onChanged(void Function(LocationData? data) onChanged) {
//   onLocationChanged().listen(onChanged);
// }
}
