import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class RideDetailsResponse {
  bool error;
  String msg;
  RideDetailsData data;

  RideDetailsResponse({this.error = false, this.msg = '', required this.data});

  factory RideDetailsResponse.fromJson(Map<String, dynamic> json) {
    return RideDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: RideDetailsData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory RideDetailsResponse.empty() => RideDetailsResponse(
        data: RideDetailsData.empty(),
      );
  static RideDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsResponse.empty();
}

class RideDetailsData {
  RideDetailsFrom from;
  RideDetailsTo to;
  Payment payment;
  RideDetailsDistance distance;
  RideDetailsDuration duration;
  String id;
  RideDetailsDriver driver;
  RideDetailsUser user;
  RideDetailsRide ride;
  double total;
  String otp;
  String status;
  DateTime createdAt;
  DateTime date;
  DateTime updatedAt;
  double extraLuggageCost;
  double couponDiscount;
  double subTotal;
  int v;
  String cancelReason;

  RideDetailsData(
      {required this.from,
      required this.payment,
      required this.to,
      required this.distance,
      required this.duration,
      this.id = '',
      required this.driver,
      required this.user,
      required this.ride,
      this.total = 0,
      this.otp = '',
      this.status = '',
      required this.createdAt,
      required this.updatedAt,
      required this.date,
      this.v = 0,
      this.extraLuggageCost = 0,
      this.couponDiscount = 0,
      this.subTotal = 0,
      this.cancelReason = ''});

  factory RideDetailsData.fromJson(Map<String, dynamic> json) =>
      RideDetailsData(
        from: RideDetailsFrom.getAPIResponseObjectSafeValue(json['from']),
        to: RideDetailsTo.getAPIResponseObjectSafeValue(json['to']),
        distance:
            RideDetailsDistance.getAPIResponseObjectSafeValue(json['distance']),
        duration:
            RideDetailsDuration.getAPIResponseObjectSafeValue(json['duration']),
        id: APIHelper.getSafeStringValue(json['_id']),
        driver: RideDetailsDriver.getAPIResponseObjectSafeValue(json['driver']),
        user: RideDetailsUser.getAPIResponseObjectSafeValue(json['user']),
        ride: RideDetailsRide.getAPIResponseObjectSafeValue(json['ride']),
        total: APIHelper.getSafeDoubleValue(json['sub_total']),
        otp: APIHelper.getSafeStringValue(json['otp']),
        status: APIHelper.getSafeStringValue(json['status']),
        payment: Payment.getAPIResponseObjectSafeValue(json['payment']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        date: APIHelper.getSafeDateTimeValue(json['date']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        v: APIHelper.getSafeIntValue(json['__v']),
        cancelReason: APIHelper.getSafeStringValue(json['cancel_reason']),
        extraLuggageCost:
            APIHelper.getSafeDoubleValue(json['extra_luggage_cost']),
        couponDiscount: APIHelper.getSafeDoubleValue(json['coupon_discount']),
        subTotal: APIHelper.getSafeDoubleValue(json['total']),
      );

  Map<String, dynamic> toJson() => {
        'from': from.toJson(),
        'to': to.toJson(),
        'payment': payment.toJson(),
        'distance': distance.toJson(),
        'duration': duration.toJson(),
        '_id': id,
        'driver': driver.toJson(),
        'user': user.toJson(),
        'ride': ride.toJson(),
        'sub_total': total,
        'otp': otp,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        '__v': v,
        'cancel_reason': cancelReason,
        'extra_luggage_cost': extraLuggageCost,
        'coupon_discount': couponDiscount,
        'total': subTotal
      };

  factory RideDetailsData.empty() => RideDetailsData(
      from: RideDetailsFrom.empty(),
      to: RideDetailsTo.empty(),
      distance: RideDetailsDistance(),
      payment: Payment(),
      date: AppComponents.defaultUnsetDateTime,
      duration: RideDetailsDuration(),
      driver: RideDetailsDriver(),
      user: RideDetailsUser(),
      ride: RideDetailsRide.empty(),
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static RideDetailsData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsData.empty();

  bool get shouldUpdateDriverLocationFromStatus => switch (status) {
        'reached' || 'completed' || 'cancelled' => false,
        _ => true,
      };
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

class RideDetailsDistance {
  String text;
  int value;

  RideDetailsDistance({this.text = '', this.value = 0});

  factory RideDetailsDistance.fromJson(Map<String, dynamic> json) =>
      RideDetailsDistance(
        text: APIHelper.getSafeStringValue(json['text']),
        value: APIHelper.getSafeIntValue(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static RideDetailsDistance getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsDistance.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsDistance();
}

class RideDetailsDriver {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  RideDetailsDriver({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.image = '',
  });

  factory RideDetailsDriver.fromJson(Map<String, dynamic> json) =>
      RideDetailsDriver(
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

  static RideDetailsDriver getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsDriver.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsDriver();
}

class RideDetailsDuration {
  String text;
  int value;

  RideDetailsDuration({this.text = '', this.value = 0});

  factory RideDetailsDuration.fromJson(Map<String, dynamic> json) =>
      RideDetailsDuration(
        text: APIHelper.getSafeStringValue(json['text']),
        value: APIHelper.getSafeIntValue(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static RideDetailsDuration getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsDuration.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsDuration();
}

class RideDetailsFrom {
  RideDetailsLocation location;
  String address;

  RideDetailsFrom({required this.location, this.address = ''});

  factory RideDetailsFrom.fromJson(Map<String, dynamic> json) =>
      RideDetailsFrom(
        location:
            RideDetailsLocation.getAPIResponseObjectSafeValue(json['location']),
        address: APIHelper.getSafeStringValue(json['address']),
      );

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'address': address,
      };

  factory RideDetailsFrom.empty() => RideDetailsFrom(
        location: RideDetailsLocation(),
      );
  static RideDetailsFrom getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsFrom.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsFrom.empty();
}

class RideDetailsTo {
  RideDetailsLocation location;
  String address;

  RideDetailsTo({required this.location, this.address = ''});

  factory RideDetailsTo.fromJson(Map<String, dynamic> json) => RideDetailsTo(
        location:
            RideDetailsLocation.getAPIResponseObjectSafeValue(json['location']),
        address: APIHelper.getSafeStringValue(json['address']),
      );

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'address': address,
      };

  factory RideDetailsTo.empty() => RideDetailsTo(
        location: RideDetailsLocation(),
      );
  static RideDetailsTo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsTo.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsTo.empty();
}

class RideDetailsLocation {
  double lat;
  double lng;

  RideDetailsLocation({this.lat = 0, this.lng = 0});

  factory RideDetailsLocation.fromJson(Map<String, dynamic> json) =>
      RideDetailsLocation(
        lat: APIHelper.getSafeDoubleValue(json['lat']),
        lng: APIHelper.getSafeDoubleValue(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static RideDetailsLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsLocation();
}

class RideDetailsRide {
  String id;
  RideDetailsVehicle vehicle;

  RideDetailsRide({this.id = '', required this.vehicle});

  factory RideDetailsRide.fromJson(Map<String, dynamic> json) =>
      RideDetailsRide(
        id: APIHelper.getSafeStringValue(json['_id']),
        vehicle:
            RideDetailsVehicle.getAPIResponseObjectSafeValue(json['vehicle']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'vehicle': vehicle.toJson(),
      };

  factory RideDetailsRide.empty() => RideDetailsRide(
        vehicle: RideDetailsVehicle(),
      );
  static RideDetailsRide getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsRide.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsRide.empty();
}

class RideDetailsVehicle {
  String id;
  String name;
  String model;
  List<String> images;
  int capacity;
  String color;

  RideDetailsVehicle({
    this.id = '',
    this.name = '',
    this.model = '',
    this.images = const [],
    this.capacity = 0,
    this.color = '',
  });

  factory RideDetailsVehicle.fromJson(Map<String, dynamic> json) =>
      RideDetailsVehicle(
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

  static RideDetailsVehicle getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsVehicle.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsVehicle();
}

class RideDetailsUser {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  RideDetailsUser(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.phone = '',
      this.email = '',
      this.image = ''});

  factory RideDetailsUser.fromJson(Map<String, dynamic> json) =>
      RideDetailsUser(
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

  static RideDetailsUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsUser();
}
