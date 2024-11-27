import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class SubscriptionListResponse {
  bool error;
  String msg;
  List<SubscriptionListItem> data;

  SubscriptionListResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory SubscriptionListResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionListResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: APIHelper.getSafeListValue(json['data'])
          .map((e) => SubscriptionListItem.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static SubscriptionListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SubscriptionListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SubscriptionListResponse();
}

class SubscriptionListItem {
  String id;
  String name;
  double price;
  Category category;
  List<String> features;
  int duration;
  bool isActive;
  DateTime createdAt;
  DateTime updatedAt;

  SubscriptionListItem({
    this.id = '',
    this.name = '',
    this.price = 0,
    required this.category,
    this.features = const [],
    this.duration = 0,
    this.isActive = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubscriptionListItem.fromJson(Map<String, dynamic> json) =>
      SubscriptionListItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        price: APIHelper.getSafeDoubleValue(json['price']),
        category: Category.getAPIResponseObjectSafeValue(json['category']),
        features: APIHelper.getSafeListValue(json['features'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        duration: APIHelper.getSafeIntValue(json['duration']),
        isActive: APIHelper.getSafeBoolValue(json['is_active']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'price': price,
        'category': category.toJson(),
        'features': features,
        'duration': duration,
        'is_active': isActive,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory SubscriptionListItem.empty() => SubscriptionListItem(
        category: Category.empty(),
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static SubscriptionListItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SubscriptionListItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SubscriptionListItem.empty();
}

class Category {
  String id;
  String uid;
  String name;
  List<String> modelYear;
  int seats;
  int numberOfFreeLuggage;
  int costPerExtraLuggage;
  bool active;
  String image;
  int minFare;
  int baseFare;
  int perKm;
  int perMin;
  DateTime createdAt;
  DateTime updatedAt;

  Category({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.modelYear = const [],
    this.seats = 0,
    this.numberOfFreeLuggage = 0,
    this.costPerExtraLuggage = 0,
    this.active = false,
    this.image = '',
    this.minFare = 0,
    this.baseFare = 0,
    this.perKm = 0,
    this.perMin = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        modelYear: APIHelper.getSafeListValue(json['model_year'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        seats: APIHelper.getSafeIntValue(json['seats']),
        numberOfFreeLuggage:
            APIHelper.getSafeIntValue(json['number_of_free_luggage']),
        costPerExtraLuggage:
            APIHelper.getSafeIntValue(json['cost_per_extra_luggage']),
        active: APIHelper.getSafeBoolValue(json['active']),
        image: APIHelper.getSafeStringValue(json['image']),
        minFare: APIHelper.getSafeIntValue(json['min_fare']),
        baseFare: APIHelper.getSafeIntValue(json['base_fare']),
        perKm: APIHelper.getSafeIntValue(json['per_km']),
        perMin: APIHelper.getSafeIntValue(json['per_min']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'model_year': modelYear,
        'seats': seats,
        'number_of_free_luggage': numberOfFreeLuggage,
        'cost_per_extra_luggage': costPerExtraLuggage,
        'active': active,
        'image': image,
        'min_fare': minFare,
        'base_fare': baseFare,
        'per_km': perKm,
        'per_min': perMin,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory Category.empty() => Category(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static Category getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Category.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Category.empty();
}
