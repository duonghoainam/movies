import 'package:flutter/widgets.dart';

void unFocus(BuildContext context){
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.focusedChild?.unfocus();
  }
}

String parseDuration(String durationString) {
  // Remove the "PT" prefix
  durationString = durationString.replaceAll("PT", "");

  // Parse hours and minutes
  int hours = 0;
  int minutes = 0;

  if (durationString.contains("H")) {
    hours = int.parse(durationString.split("H")[0]);
    durationString = durationString.split("H")[1];
  }

  if (durationString.contains("M")) {
    minutes = int.parse(durationString.split("M")[0]);
  }

  // Format the duration
  String formattedDuration = '';
  if (hours > 0) {
    formattedDuration += '$hours h ';
  }
  if (minutes > 0) {
    formattedDuration += '$minutes min';
  }

  return formattedDuration.trim();
}
