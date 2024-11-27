import 'package:taxiappdriver/utils/constansts/app_constans.dart';

enum AddVehicleTabState { VehicleInfo, VehicleDocuments }

enum AddVehicleTabStateStatus { VehicleInfo, VehicleDocuments }

enum AddVehicleDetailsTabState { incomplete, current }

enum ForgotPasswordTabListEnum {
  email(AppConstants.forgotPasswordHisyoryTabTypEmail, 'Email'),
  phone(AppConstants.forgotPasswordHisyoryTabTypPhone, 'Phone'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringTextValue;
  const ForgotPasswordTabListEnum(this.stringValue, this.stringTextValue);

  static ForgotPasswordTabListEnum toEnumValue(String value) {
    final Map<String, ForgotPasswordTabListEnum> stringToEnumMap = {
      ForgotPasswordTabListEnum.email.stringValue:
          ForgotPasswordTabListEnum.email,
      ForgotPasswordTabListEnum.phone.stringValue:
          ForgotPasswordTabListEnum.phone,
      ForgotPasswordOptionListEnum.unknown.stringValue:
          ForgotPasswordTabListEnum.unknown,
    };
    return stringToEnumMap[value] ?? ForgotPasswordTabListEnum.unknown;
  }
}

enum ForgotPasswordOptionListEnum {
  email(AppConstants.forgotPasswordHisyoryTabTypEmail, 'Email'),
  phone(AppConstants.forgotPasswordHisyoryTabTypPhone, 'Phone'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringTextValue;
  const ForgotPasswordOptionListEnum(this.stringValue, this.stringTextValue);

  static ForgotPasswordOptionListEnum toEnumValue(String value) {
    final Map<String, ForgotPasswordOptionListEnum> stringToEnumMap = {
      ForgotPasswordOptionListEnum.email.stringValue:
          ForgotPasswordOptionListEnum.email,
      ForgotPasswordOptionListEnum.phone.stringValue:
          ForgotPasswordOptionListEnum.phone,
      ForgotPasswordOptionListEnum.unknown.stringValue:
          ForgotPasswordOptionListEnum.unknown,
    };
    return stringToEnumMap[value] ?? ForgotPasswordOptionListEnum.unknown;
  }
}

enum TransactionHistoryStatus {
  all(AppConstants.transactionHistoryStatusAll, 'All'),
  today(AppConstants.transactionHistoryStatusToday, 'Today'),
  thisWeek(AppConstants.transactionHistoryStatusThisWeek, 'This Week'),
  thisMonth(AppConstants.transactionHistoryStatusThisMonth, 'This month'),
  thisYear(AppConstants.transactionHistoryStatusSixMonth, 'This Year'),
  withdrawHistory(
      AppConstants.transactionHistoryStatusWithdrawHistory, 'Withdraw History'),

  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const TransactionHistoryStatus(this.stringValue, this.stringValueForView);

  static TransactionHistoryStatus toEnumValue(String value) {
    final Map<String, TransactionHistoryStatus> stringToEnumMap = {
      TransactionHistoryStatus.today.stringValue:
          TransactionHistoryStatus.today,
      TransactionHistoryStatus.thisWeek.stringValue:
          TransactionHistoryStatus.thisWeek,
      TransactionHistoryStatus.thisMonth.stringValue:
          TransactionHistoryStatus.thisMonth,
      TransactionHistoryStatus.thisYear.stringValue:
          TransactionHistoryStatus.thisYear,
      TransactionHistoryStatus.withdrawHistory.stringValue:
          TransactionHistoryStatus.withdrawHistory,
      TransactionHistoryStatus.unknown.stringValue:
          TransactionHistoryStatus.unknown
    };
    return stringToEnumMap[value] ?? TransactionHistoryStatus.unknown;
  }
}

enum VehicleDetailsInfoTypeStatus {
  specifications(AppConstants.vehicleDetailsInfoTypeStatusSpecifications,
      'Specifications'),
  features(AppConstants.vehicleDetailsInfoTypeStatusFeatures, 'Features'),
  documents(AppConstants.vehicleDetailsInfoTypeStatusDocuments, 'Documents');

  final String stringValue;
  final String stringValueForView;
  const VehicleDetailsInfoTypeStatus(this.stringValue, this.stringValueForView);

  static VehicleDetailsInfoTypeStatus toEnumValue(String value) {
    final Map<String, VehicleDetailsInfoTypeStatus> stringToEnumMap = {
      VehicleDetailsInfoTypeStatus.specifications.stringValue:
          VehicleDetailsInfoTypeStatus.specifications,
      VehicleDetailsInfoTypeStatus.features.stringValue:
          VehicleDetailsInfoTypeStatus.features,
      VehicleDetailsInfoTypeStatus.documents.stringValue:
          VehicleDetailsInfoTypeStatus.documents,
    };
    return stringToEnumMap[value] ??
        VehicleDetailsInfoTypeStatus.specifications;
  }
}
