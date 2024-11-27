import 'package:taxiappdriver/utils/constansts/app_constans.dart';

// enum AddVehicleTabState { vehicle, information, documents }
enum AddVehicleDetailsTabState { incomplete, current, completed }
// enum AddVehicleDetailsTabState { incomplete, current, completed }

enum RideStatus {
  accepted(AppConstants.rideTypeStatusAccepted, 'Accepted'),
  rejected(AppConstants.rideTypeStatusRejected, 'Rejected');

  final String stringValue;
  final String stringValueForView;
  const RideStatus(this.stringValue, this.stringValueForView);

  static RideStatus toEnumValue(String value) {
    final Map<String, RideStatus> stringToEnumMap = {
      RideStatus.accepted.stringValue: RideStatus.accepted,
      RideStatus.rejected.stringValue: RideStatus.rejected,
    };
    return stringToEnumMap[value] ?? RideStatus.rejected;
  }
}

enum RideHistoryStatusEnum {
  // pending(AppConstants.historyListEnumPending, 'Pending'),
  upcoming(AppConstants.historyListEnumAccepted, 'Upcoming'),
  started(AppConstants.historyListEnumStarted, 'Started'),
  reached(AppConstants.historyListEnumReached, 'Reached'),
  complete(AppConstants.historyListEnumComplete, 'Complete'),
  cancelled(AppConstants.historyListEnumCancelled, 'Cancelled');

  final String stringValue;
  final String stringValueForView;
  const RideHistoryStatusEnum(this.stringValue, this.stringValueForView);

  static RideHistoryStatusEnum toEnumValue(String value) {
    final Map<String, RideHistoryStatusEnum> stringToEnumMap = {
      // RideHistoryStatusEnum.pending.stringValue: RideHistoryStatusEnum.pending,
      RideHistoryStatusEnum.upcoming.stringValue:
          RideHistoryStatusEnum.upcoming,
      RideHistoryStatusEnum.started.stringValue: RideHistoryStatusEnum.started,
      RideHistoryStatusEnum.reached.stringValue: RideHistoryStatusEnum.reached,
      RideHistoryStatusEnum.complete.stringValue:
          RideHistoryStatusEnum.complete,
      RideHistoryStatusEnum.cancelled.stringValue:
          RideHistoryStatusEnum.cancelled,
    };
    return stringToEnumMap[value] ?? RideHistoryStatusEnum.upcoming;
  }
}
