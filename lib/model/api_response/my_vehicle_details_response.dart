import 'package:flutter/material.dart';
import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';

class MyVehicleDetailsResponse {
  bool error;
  String msg;
  MyVehicleDetails data;

  MyVehicleDetailsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory MyVehicleDetailsResponse.fromJson(Map<String, dynamic> json) {
    return MyVehicleDetailsResponse(
        error: APIHelper.getSafeBoolValue(json['error']),
        msg: APIHelper.getSafeStringValue(json['msg']),
        data: MyVehicleDetails.getAPIResponseObjectSafeValue(json['data']));
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory MyVehicleDetailsResponse.empty() => MyVehicleDetailsResponse(
        data: MyVehicleDetails.empty(),
      );
  static MyVehicleDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyVehicleDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyVehicleDetailsResponse.empty();
}

class MyVehicleDetails {
  Location location;
  String id;
  String uid;
  Driver driver;
  Brand brand;
  BrandModel brandModel;
  Category category;
  DateTime year;
  List<String> images;
  String color;
  int luggageSpace;
  String vehicleNumber;
  String vehicleV5;
  String licenseImageFront;
  String licenseImageBack;
  DateTime licenseExpiry;
  String insuranceCertificate;
  DateTime insuranceExpiry;
  String motCertificate;
  DateTime motExpiry;
  String status;
  String suspendedReason;
  bool online;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  MyVehicleDetails({
    required this.location,
    this.id = '',
    this.uid = '',
    required this.driver,
    required this.brand,
    required this.brandModel,
    required this.category,
    required this.year,
    this.images = const [],
    this.color = '',
    this.luggageSpace = 0,
    this.vehicleNumber = '',
    this.vehicleV5 = '',
    this.licenseImageFront = '',
    this.licenseImageBack = '',
    required this.licenseExpiry,
    this.insuranceCertificate = '',
    required this.insuranceExpiry,
    this.motCertificate = '',
    required this.motExpiry,
    this.status = '',
    this.suspendedReason = '',
    this.online = false,
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
  });

  factory MyVehicleDetails.fromJson(Map<String, dynamic> json) =>
      MyVehicleDetails(
        location: Location.getAPIResponseObjectSafeValue(json['location']),
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        driver: Driver.getAPIResponseObjectSafeValue(json['driver']),
        brand: Brand.getAPIResponseObjectSafeValue(json['brand']),
        brandModel:
            BrandModel.getAPIResponseObjectSafeValue(json['brand_model']),
        category: Category.getAPIResponseObjectSafeValue(json['category']),
        year: APIHelper.getSafeDateTimeValue(json['year']),
        images: APIHelper.getSafeListValue(json['images'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        color: APIHelper.getSafeStringValue(json['color']),
        luggageSpace: APIHelper.getSafeIntValue(json['luggage_space']),
        vehicleNumber: APIHelper.getSafeStringValue(json['vehicle_number']),
        vehicleV5: APIHelper.getSafeStringValue(json['vehicle_v5']),
        licenseImageFront:
            APIHelper.getSafeStringValue(json['license_image_front']),
        licenseImageBack:
            APIHelper.getSafeStringValue(json['license_image_back']),
        licenseExpiry: APIHelper.getSafeDateTimeValue(json['license_expiry']),
        insuranceCertificate:
            APIHelper.getSafeStringValue(json['insurance_certificate']),
        insuranceExpiry:
            APIHelper.getSafeDateTimeValue(json['insurance_expiry']),
        motCertificate: APIHelper.getSafeStringValue(json['mot_certificate']),
        motExpiry: APIHelper.getSafeDateTimeValue(json['mot_expiry']),
        status: APIHelper.getSafeStringValue(json['status']),
        suspendedReason: APIHelper.getSafeStringValue(json['suspended_reason']),
        online: APIHelper.getSafeBoolValue(json['online']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        v: APIHelper.getSafeIntValue(json['__v']),
      );

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        '_id': id,
        'uid': uid,
        'driver': driver.toJson(),
        'brand': brand.toJson(),
        'brand_model': brandModel.toJson(),
        'category': category.toJson(),
        'year': APIHelper.toServerDateTimeFormattedStringFromDateTime(year),
        'images': images,
        'color': color,
        'luggage_space': luggageSpace,
        'vehicle_number': vehicleNumber,
        'vehicle_v5': vehicleV5,
        'license_image_front': licenseImageFront,
        'license_image_back': licenseImageBack,
        'license_expiry': APIHelper.toServerDateTimeFormattedStringFromDateTime(
            licenseExpiry),
        'insurance_certificate': insuranceCertificate,
        'insurance_expiry':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(
                insuranceExpiry),
        'mot_certificate': motCertificate,
        'mot_expiry':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(motExpiry),
        'status': status,
        'suspended_reason': suspendedReason,
        'online': online,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
      };

  factory MyVehicleDetails.empty() => MyVehicleDetails(
        brand: Brand.empty(),
        brandModel: BrandModel(),
        category: Category.empty(),
        createdAt: AppComponents.defaultUnsetDateTime,
        driver: Driver(),
        insuranceExpiry: AppComponents.defaultUnsetDateTime,
        licenseExpiry: AppComponents.defaultUnsetDateTime,
        location: Location(),
        motExpiry: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
        year: AppComponents.defaultUnsetDateTime,
      );
  static MyVehicleDetails getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyVehicleDetails.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyVehicleDetails.empty();

  Color get colorToObject => Helper.getColorFromTextHexColorCode(color);
}

class Location {
  String type;
  List<double> coordinates;

  Location({this.type = '', this.coordinates = const []});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: APIHelper.getSafeStringValue(json['type']),
        coordinates: APIHelper.getSafeListValue(json['coordinates']),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates,
      };

  static Location getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Location.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Location();
}

class Driver {
  String id;
  String name;
  String phone;
  String email;
  String image;
  String about;
  String experience;
  String address;

  Driver({
    this.id = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.image = '',
    this.about = '',
    this.experience = '',
    this.address = '',
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
        about: APIHelper.getSafeStringValue(json['about']),
        experience: APIHelper.getSafeStringValue(json['experience']),
        address: APIHelper.getSafeStringValue(json['address']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
        'about': about,
        'experience': experience,
        'address': address,
      };

  static Driver getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Driver.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Driver();
}

class Brand {
  String id;
  String uid;
  String name;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Brand({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.image = '',
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        v: APIHelper.getSafeIntValue(json['__v']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'image': image,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
      };

  factory Brand.empty() => Brand(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static Brand getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Brand.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Brand.empty();
}

class BrandModel {
  String id;
  String name;

  BrandModel({this.id = '', this.name = ''});

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static BrandModel getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? BrandModel.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : BrandModel();
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
  int v;

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
    this.v = 0,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        modelYear: APIHelper.getSafeListValue(json['model_year']),
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
        v: APIHelper.getSafeIntValue(json['__v']),
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
        '__v': v,
      };

  factory Category.empty() => Category(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static Category getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Category.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Category.empty();
}
