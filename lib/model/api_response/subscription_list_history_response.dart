import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class SubscriptionHistoryResponse {
  bool error;
  String msg;
  List<SubscriptionHistory> data;

  SubscriptionHistoryResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory SubscriptionHistoryResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionHistoryResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: APIHelper.getSafeListValue(json['data'])
          .map((e) => SubscriptionHistory.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static SubscriptionHistoryResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SubscriptionHistoryResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SubscriptionHistoryResponse();
}

class SubscriptionHistory {
  String id;
  String uid;
  Subscription subscription;
  DateTime startDate;
  DateTime endDate;
  int duration;
  double price;
  Currency currency;
  Payment payment;
  String status;

  SubscriptionHistory({
    this.id = '',
    this.uid = '',
    required this.subscription,
    required this.startDate,
    required this.endDate,
    this.duration = 0,
    this.price = 0,
    required this.currency,
    required this.payment,
    this.status = '',
  });

  factory SubscriptionHistory.fromJson(Map<String, dynamic> json) =>
      SubscriptionHistory(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        subscription:
            Subscription.getAPIResponseObjectSafeValue(json['subscription']),
        startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
        endDate: APIHelper.getSafeDateTimeValue(json['end_date']),
        duration: APIHelper.getSafeIntValue(json['duration']),
        price: APIHelper.getSafeDoubleValue(json['price']),
        currency: Currency.getAPIResponseObjectSafeValue(json['currency']),
        payment: Payment.getAPIResponseObjectSafeValue(json['payment']),
        status: APIHelper.getSafeStringValue(json['status']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'subscription': subscription.toJson(),
        'start_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(startDate),
        'end_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(endDate),
        'duration': duration,
        'price': price,
        'currency': currency.toJson(),
        'payment': payment.toJson(),
        'status': status,
      };

  factory SubscriptionHistory.empty() => SubscriptionHistory(
        currency: Currency(),
        endDate: AppComponents.defaultUnsetDateTime,
        payment: Payment(),
        startDate: AppComponents.defaultUnsetDateTime,
        subscription: Subscription(),
      );
  static SubscriptionHistory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SubscriptionHistory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SubscriptionHistory.empty();
}

class Subscription {
  String id;
  String name;

  Subscription({this.id = '', this.name = ''});

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static Subscription getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Subscription.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Subscription();
}

class Currency {
  String id;
  String name;
  String code;
  String symbol;
  double rate;

  Currency(
      {this.id = '',
      this.name = '',
      this.code = '',
      this.symbol = '',
      this.rate = 0});

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        code: APIHelper.getSafeStringValue(json['code']),
        symbol: APIHelper.getSafeStringValue(json['symbol']),
        rate: APIHelper.getSafeDoubleValue(json['rate']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'code': code,
        'symbol': symbol,
        'rate': rate,
      };

  static Currency getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Currency.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Currency();
}

class Payment {
  String method;
  String status;
  String transactionId;
  int amount;

  Payment(
      {this.method = '',
      this.status = '',
      this.transactionId = '',
      this.amount = 0});

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        method: APIHelper.getSafeStringValue(json['method']),
        status: APIHelper.getSafeStringValue(json['status']),
        transactionId: APIHelper.getSafeStringValue(json['transaction_id']),
        amount: APIHelper.getSafeIntValue(json['amount']),
      );

  Map<String, dynamic> toJson() => {
        'method': method,
        'status': status,
        'transaction_id': transactionId,
        'amount': amount,
      };

  static Payment getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Payment.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Payment();
}
