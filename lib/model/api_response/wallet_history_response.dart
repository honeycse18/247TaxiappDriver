import 'package:taxiappdriver/model/core_api_responses/paginated_data_response.dart';
import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class WalletTransactionHistoryResponse {
  bool error;
  String msg;
  PaginatedDataResponse<TransactionHistoryItems> data;

  WalletTransactionHistoryResponse(
      {this.error = false, this.msg = '', required this.data});

  factory WalletTransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
    return WalletTransactionHistoryResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            TransactionHistoryItems.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory WalletTransactionHistoryResponse.empty() =>
      WalletTransactionHistoryResponse(
        data: PaginatedDataResponse.empty(),
      );
  static WalletTransactionHistoryResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WalletTransactionHistoryResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WalletTransactionHistoryResponse.empty();
}

class TransactionHistoryItems {
  String id;
  String uid;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  double amount;
  String transactionId;
  String type;
  String method;
  WithdrawMethod withdrawMethod;

  TransactionHistoryItems({
    this.id = '',
    this.uid = '',
    this.status = '',
    required this.createdAt,
    required this.updatedAt,
    this.amount = 0,
    this.type = '',
    this.method = '',
    this.transactionId = '',
    required this.withdrawMethod,
  });

  factory TransactionHistoryItems.fromJson(Map<String, dynamic> json) =>
      TransactionHistoryItems(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        status: APIHelper.getSafeStringValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        amount: APIHelper.getSafeDoubleValue(json['amount']),
        transactionId: APIHelper.getSafeStringValue(json['transaction_id']),
        type: APIHelper.getSafeStringValue(json['type']),
        method: APIHelper.getSafeStringValue(json['method']),
        withdrawMethod: WithdrawMethod.getAPIResponseObjectSafeValue(
            json['withdraw_method']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'amount': amount,
        'transaction_id': transactionId,
        'type': type,
        'method': method,
        'withdraw_method': withdrawMethod.toJson(),
      };

  factory TransactionHistoryItems.empty() => TransactionHistoryItems(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime,
      withdrawMethod: WithdrawMethod());
  static TransactionHistoryItems getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? TransactionHistoryItems.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : TransactionHistoryItems.empty();
}

class WithdrawMethod {
  String name;
  String details;

  WithdrawMethod({this.name = '', this.details = ''});

  factory WithdrawMethod.fromJson(Map<String, dynamic> json) {
    return WithdrawMethod(
      name: APIHelper.getSafeStringValue(json['name']),
      details: APIHelper.getSafeStringValue(json['details']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'details': details,
      };

  static WithdrawMethod getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WithdrawMethod.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : WithdrawMethod();
}
