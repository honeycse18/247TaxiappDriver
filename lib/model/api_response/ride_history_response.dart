import 'package:taxiappdriver/model/core_api_responses/paginated_data_response.dart';
import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class RideHistoryResponse {
  bool error;
  String msg;
  PaginatedDataResponse<RideHistoryDoc> data;

  RideHistoryResponse({this.error = false, this.msg = '', required this.data});

  factory RideHistoryResponse.fromJson(Map<String, dynamic> json) {
    return RideHistoryResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(json['data'],
          docFromJson: (data) =>
              RideHistoryDoc.getAPIResponseObjectSafeValue(data)),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory RideHistoryResponse.empty() => RideHistoryResponse(
        data: PaginatedDataResponse.empty(),
      );
  static RideHistoryResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryResponse.empty();
}

class RideHistoryDoc {
  RideHistoryFrom from;
  RideHistoryTo to;
  RideHistoryDistance distance;
  RideHistoryDuration duration;
  Payment payment;
  String id;
  String uid;
  RideHistoryDriver driver;
  RideHistoryUser user;
  RideHistoryRide ride;
  RideHistoryCurrency currency;
  DateTime date;
  bool schedule;
  double total;
  String otp;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String cancelReason;

  RideHistoryDoc({
    required this.from,
    required this.to,
    required this.distance,
    required this.payment,
    required this.duration,
    required this.currency,
    this.id = '',
    this.uid = '',
    required this.driver,
    required this.user,
    required this.ride,
    required this.date,
    this.schedule = false,
    this.total = 0,
    this.otp = '',
    this.status = '',
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
    this.cancelReason = '',
  });

  factory RideHistoryDoc.fromJson(Map<String, dynamic> json) => RideHistoryDoc(
        from: RideHistoryFrom.getAPIResponseObjectSafeValue(json['from']),
        to: RideHistoryTo.getAPIResponseObjectSafeValue(json['to']),
        distance:
            RideHistoryDistance.getAPIResponseObjectSafeValue(json['distance']),
        duration:
            RideHistoryDuration.getAPIResponseObjectSafeValue(json['duration']),
        id: APIHelper.getSafeStringValue(json['_id']),
        driver: RideHistoryDriver.getAPIResponseObjectSafeValue(json['driver']),
        payment: Payment.getAPIResponseObjectSafeValue(json['payment']),
        currency:
            RideHistoryCurrency.getAPIResponseObjectSafeValue(json['currency']),
        user: RideHistoryUser.getAPIResponseObjectSafeValue(json['user']),
        ride: RideHistoryRide.getAPIResponseObjectSafeValue(json['ride']),
        date: APIHelper.getSafeDateTimeValue(json['date']),
        schedule: APIHelper.getSafeBoolValue(json['schedule']),
        total: APIHelper.getSafeDoubleValue(json['total']),
        otp: APIHelper.getSafeStringValue(json['otp']),
        status: APIHelper.getSafeStringValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        v: APIHelper.getSafeIntValue(json['__v']),
        cancelReason: APIHelper.getSafeStringValue(json['cancel_reason']),
      );

  Map<String, dynamic> toJson() => {
        'from': from.toJson(),
        'to': to.toJson(),
        'distance': distance.toJson(),
        'duration': duration.toJson(),
        'payment': payment.toJson(),
        'currency': currency.toJson(),
        '_id': id,
        'driver': driver.toJson(),
        'user': user.toJson(),
        'ride': ride.toJson(),
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'schedule': schedule,
        'total': total,
        'otp': otp,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
        'cancel_reason': cancelReason,
      };

  factory RideHistoryDoc.empty() => RideHistoryDoc(
      payment: Payment(),
      from: RideHistoryFrom.empty(),
      to: RideHistoryTo.empty(),
      distance: RideHistoryDistance(),
      duration: RideHistoryDuration(),
      currency: RideHistoryCurrency(),
      driver: RideHistoryDriver(),
      user: RideHistoryUser(),
      ride: RideHistoryRide(),
      date: AppComponents.defaultUnsetDateTime,
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static RideHistoryDoc getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryDoc.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryDoc.empty();
}

class Payment {
  String method;
  String status;
  String transactionId;
  double amount;

  Payment({
    this.method = '',
    this.status = '',
    this.amount = 0,
    this.transactionId = '',
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        method: APIHelper.getSafeStringValue(json['method']),
        status: APIHelper.getSafeStringValue(json['status']),
        transactionId: APIHelper.getSafeStringValue(json['transaction_id']),
        amount: APIHelper.getSafeDoubleValue(json['amount']),
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

class RideHistoryDistance {
  String text;
  int value;

  RideHistoryDistance({this.text = '', this.value = 0});

  factory RideHistoryDistance.fromJson(Map<String, dynamic> json) =>
      RideHistoryDistance(
        text: APIHelper.getSafeStringValue(json['text']),
        value: APIHelper.getSafeIntValue(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static RideHistoryDistance getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryDistance.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryDistance();
}

class RideHistoryDriver {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  RideHistoryDriver({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.image = '',
  });

  factory RideHistoryDriver.fromJson(Map<String, dynamic> json) =>
      RideHistoryDriver(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
      };

  static RideHistoryDriver getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryDriver.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryDriver();
}

class RideHistoryDuration {
  String text;
  int value;

  RideHistoryDuration({this.text = '', this.value = 0});

  factory RideHistoryDuration.fromJson(Map<String, dynamic> json) =>
      RideHistoryDuration(
        text: APIHelper.getSafeStringValue(json['text']),
        value: APIHelper.getSafeIntValue(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static RideHistoryDuration getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryDuration.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryDuration();
}

class RideHistoryFrom {
  RideHistoryLocation location;
  String address;

  RideHistoryFrom({required this.location, this.address = ''});

  factory RideHistoryFrom.fromJson(Map<String, dynamic> json) =>
      RideHistoryFrom(
        location:
            RideHistoryLocation.getAPIResponseObjectSafeValue(json['location']),
        address: APIHelper.getSafeStringValue(json['address']),
      );

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'address': address,
      };

  factory RideHistoryFrom.empty() => RideHistoryFrom(
        location: RideHistoryLocation(),
      );
  static RideHistoryFrom getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryFrom.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryFrom.empty();
}

class RideHistoryLocation {
  double lat;
  double lng;

  RideHistoryLocation({this.lat = 0, this.lng = 0});

  factory RideHistoryLocation.fromJson(Map<String, dynamic> json) =>
      RideHistoryLocation(
        lat: APIHelper.getSafeDoubleValue(json['lat']),
        lng: APIHelper.getSafeDoubleValue(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static RideHistoryLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryLocation();
}

class RideHistoryTo {
  RideHistoryLocation location;
  String address;

  RideHistoryTo({required this.location, this.address = ''});

  factory RideHistoryTo.fromJson(Map<String, dynamic> json) => RideHistoryTo(
        location:
            RideHistoryLocation.getAPIResponseObjectSafeValue(json['location']),
        address: APIHelper.getSafeStringValue(json['address']),
      );

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'address': address,
      };

  factory RideHistoryTo.empty() => RideHistoryTo(
        location: RideHistoryLocation(),
      );
  static RideHistoryTo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryTo.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryTo.empty();
}

/* class RideHistoryRide {
  String id;
  String name;
  String model;
  List<String> images;
  int capacity;
  String color;
  // RideHistoryVehicle vehicle;

  RideHistoryRide({
    this.id = '',
    this.name = '',
    this.model = '',
    this.images = const [],
    this.capacity = 0,
    this.color = '',
  });

  factory RideHistoryRide.fromJson(Map<String, dynamic> json) =>
      RideHistoryRide(
        id: APIHelper.getSafeStringValue(json['_id']),
        vehicle:
            RideHistoryVehicle.getAPIResponseObjectSafeValue(json['vehicle']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'vehicle': vehicle.toJson(),
      };

  factory RideHistoryRide.empty() => RideHistoryRide(
        vehicle: RideHistoryVehicle(),
      );
  static RideHistoryRide getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryRide.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryRide.empty();
} */

class RideHistoryRide {
  String id;
  String name;
  String model;
  List<String> images;
  int capacity;
  String color;

  RideHistoryRide({
    this.id = '',
    this.name = '',
    this.model = '',
    this.images = const [],
    this.capacity = 0,
    this.color = '',
  });

  factory RideHistoryRide.fromJson(Map<String, dynamic> json) =>
      RideHistoryRide(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        model: APIHelper.getSafeStringValue(json['model']),
        images: APIHelper.getSafeListValue(json['images'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        capacity: APIHelper.getSafeIntValue(json['capacity']),
        color: APIHelper.getSafeStringValue(json['color']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'model': model,
        'images': images,
        'capacity': capacity,
        'color': color,
      };

  static RideHistoryRide getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryRide.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryRide();
}

class RideHistoryCurrency {
  String id;
  String name;
  String code;
  String symbol;
  int rate;

  RideHistoryCurrency({
    this.id = '',
    this.name = '',
    this.code = '',
    this.symbol = '',
    this.rate = 0,
  });

  factory RideHistoryCurrency.fromJson(Map<String, dynamic> json) =>
      RideHistoryCurrency(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        code: APIHelper.getSafeStringValue(json['code']),
        symbol: APIHelper.getSafeStringValue(json['symbol']),
        rate: APIHelper.getSafeIntValue(json['rate']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'code': code,
        'symbol': symbol,
        'rate': rate,
      };

  static RideHistoryCurrency getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryCurrency.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryCurrency();
}

class RideHistoryUser {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  RideHistoryUser(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.phone = '',
      this.email = '',
      this.image = ''});

  factory RideHistoryUser.fromJson(Map<String, dynamic> json) =>
      RideHistoryUser(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
      };

  static RideHistoryUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryUser();
}
