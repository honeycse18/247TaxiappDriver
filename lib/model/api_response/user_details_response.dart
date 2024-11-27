import 'package:taxiappdriver/model/api_response/my_vehicle_details_response.dart';
import 'package:taxiappdriver/model/api_response/ride_details_response.dart';
import 'package:taxiappdriver/model/api_response/ride_history_response.dart';
import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class UserDetailsResponse {
  bool error;
  String msg;
  UserDetailsData data;

  UserDetailsResponse({this.error = false, this.msg = '', required this.data});

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) {
    return UserDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: UserDetailsData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory UserDetailsResponse.empty() => UserDetailsResponse(
        data: UserDetailsData.empty(),
      );
  static UserDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserDetailsResponse.empty();
}

class UserDetailsData {
  String id;
  String service;
  String uid;
  String name;
  String phone;
  String email;
  String image;
  String role;
  String address;
  String gender;
  double rate;
  bool fleet;
  String address2;
  String experience;
  String about;
  UserDetailsLoc location;
  UserRentDetails rent;
  Driver driver;
  double walletBalance;
  UserDetailsCountry country;
  List<String> documents;
  List<String> idCard;
  String licenseNo;
  double rating;
  List<String> paymentMethods;
  Currency currency;
  MyVehicleDetails vehicle;
  String status;
  bool deleted;
  String badgeNumber;
  String dbsNumber;
  String driverNi;
  String driverNiNumber;
  List<String> drivingLicense;
  DateTime drivingLicenseExpired;
  String enhanceDbs;
  String taxiDriverBadge;
  bool expired;
  Subscriptions subscriptions;
  RideHistoryDoc rideStatus;

  UserDetailsData({
    this.id = '',
    this.uid = '',
    this.service = '',
    this.name = '',
    this.phone = '',
    this.gender = '',
    this.email = '',
    this.image = '',
    this.role = '',
    this.address = '',
    this.rate = 0,
    this.fleet = false,
    this.address2 = '',
    this.experience = '',
    this.about = '',
    required this.location,
    required this.rent,
    required this.driver,
    required this.country,
    required this.currency,
    required this.vehicle,
    this.documents = const [],
    this.idCard = const [],
    this.rating = 0.0,
    this.licenseNo = '',
    this.status = '',
    this.paymentMethods = const [],
    this.deleted = false,
    this.badgeNumber = '',
    this.dbsNumber = '',
    this.driverNi = '',
    this.driverNiNumber = '',
    this.walletBalance = 0,
    this.drivingLicense = const [],
    required this.drivingLicenseExpired,
    this.enhanceDbs = '',
    this.taxiDriverBadge = '',
    this.expired = false,
    required this.subscriptions,
    required this.rideStatus,
  });

  factory UserDetailsData.fromJson(Map<String, dynamic> json) =>
      UserDetailsData(
        id: APIHelper.getSafeStringValue(json['_id']),
        gender: APIHelper.getSafeStringValue(json['gender']),
        service: APIHelper.getSafeStringValue(json['service']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
        role: APIHelper.getSafeStringValue(json['role']),
        address: APIHelper.getSafeStringValue(json['address']),
        address2: APIHelper.getSafeStringValue(json['address2']),
        experience: APIHelper.getSafeStringValue(json['experience']),
        about: APIHelper.getSafeStringValue(json['about']),
        rate: APIHelper.getSafeDoubleValue(json['rate']),
        fleet: APIHelper.getSafeBoolValue(json['fleet']),
        status: APIHelper.getSafeStringValue(json['status']),
        walletBalance: APIHelper.getSafeDoubleValue(json['wallet_balance']),
        subscriptions:
            Subscriptions.getAPIResponseObjectSafeValue(json['subscriptions']),
        location:
            UserDetailsLoc.getAPIResponseObjectSafeValue(json['location']),
        rent: UserRentDetails.getAPIResponseObjectSafeValue(json['rent']),
        driver: Driver.getAPIResponseObjectSafeValue(json['driver']),
        rideStatus: RideHistoryDoc.getAPIResponseObjectSafeValue(json['ride']),
        country:
            UserDetailsCountry.getAPIResponseObjectSafeValue(json['country']),
        documents: APIHelper.getSafeListValue(json['driving_license'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        idCard: APIHelper.getSafeListValue(json['id_card'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        licenseNo: APIHelper.getSafeStringValue(json['license_no']),
        rating: APIHelper.getSafeDoubleValue(json['rating'], 0.0),
        paymentMethods: APIHelper.getSafeListValue(json['payment_methods'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        currency: Currency.getAPIResponseObjectSafeValue(json['currency']),
        vehicle:
            MyVehicleDetails.getAPIResponseObjectSafeValue(json['vehicle']),
        deleted: APIHelper.getSafeBoolValue(json['deleted']),
        badgeNumber: APIHelper.getSafeStringValue(json['badge_number']),
        dbsNumber: APIHelper.getSafeStringValue(json['dbs_number']),
        driverNi: APIHelper.getSafeStringValue(json['driver_ni']),
        driverNiNumber: APIHelper.getSafeStringValue(json['driver_ni_number']),
        drivingLicense: APIHelper.getSafeListValue(json['driving_license'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        drivingLicenseExpired:
            APIHelper.getSafeDateTimeValue(json['driving_license_expired']),
        enhanceDbs: APIHelper.getSafeStringValue(json['enhance_dbs']),
        taxiDriverBadge:
            APIHelper.getSafeStringValue(json['taxi_driver_badge']),
        expired: APIHelper.getSafeBoolValue(json['expired']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'gender': gender,
        'uid': uid,
        'service': service,
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
        'status': status,
        'wallet_balance': walletBalance,
        'role': role,
        'address': address,
        'experience': experience,
        'address2': address2,
        'about': about,
        'rate': rate,
        'subscriptions': subscriptions.toJson(),
        'fleet': fleet,
        'location': location.toJson(),
        'ride': rideStatus.toJson(),
        'rent': rent.toJson(),
        'driver': driver.toJson(),
        'currency': currency.toJson(),
        'driving_license': documents,
        'id_card': idCard,
        'license_no': licenseNo,
        'rating': rating,
        'payment_methods': paymentMethods,
        'country': country.toJson(),
        'vehicle': vehicle.toJson(),
        'deleted': deleted,
        'badge_number': badgeNumber,
        'dbs_number': dbsNumber,
        'driver_ni': driverNi,
        'driver_ni_number': driverNiNumber,
        'driving_license_expired': drivingLicenseExpired.toIso8601String(),
        'enhance_dbs': enhanceDbs,
        'taxi_driver_badge': taxiDriverBadge,
        'expired': expired,
      };

  factory UserDetailsData.empty() => UserDetailsData(
      drivingLicenseExpired: AppComponents.defaultUnsetDateTime,
      vehicle: MyVehicleDetails.empty(),
      location: UserDetailsLoc(),
      rideStatus: RideHistoryDoc.empty(),
      rent: UserRentDetails.empty(),
      driver: Driver.empty(),
      subscriptions: Subscriptions.empty(),
      country: UserDetailsCountry(),
      currency: Currency());
  static UserDetailsData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetailsData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserDetailsData.empty();

  bool isEmpty() => id.isEmpty;
}

class Currency {
  String id;
  String name;
  String code;
  String symbol;

  Currency({
    this.name = '',
    this.id = '',
    this.code = '',
    this.symbol = '',
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        code: APIHelper.getSafeStringValue(json['code']),
        symbol: APIHelper.getSafeStringValue(json['symbol']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'code': code,
        'symbol': symbol,
      };

  static Currency getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Currency.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Currency();
}

class Driver {
  bool fleet;
  String id;
  Owner owner;
  String status;

  Driver(
      {this.fleet = false,
      this.id = '',
      required this.owner,
      this.status = ''});

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        fleet: APIHelper.getSafeBoolValue(json['fleet']),
        id: APIHelper.getSafeStringValue(json['_id']),
        owner: Owner.getAPIResponseObjectSafeValue(json['owner']),
        status: APIHelper.getSafeStringValue(json['status']),
      );

  Map<String, dynamic> toJson() => {
        'fleet': fleet,
        '_id': id,
        'owner': owner.toJson(),
        'status': status,
      };

  factory Driver.empty() => Driver(
        owner: Owner(),
      );
  static Driver getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Driver.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Driver.empty();
}

class Owner {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  Owner(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.phone = '',
      this.email = '',
      this.image = ''});

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
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

  static Owner getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Owner.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Owner();
}

class UserRentDetails {
  String id;
  Vehicle vehicle;
  Prices prices;
  String address;
  UserRentDetailsLocation location;
  Facilities facilities;

  UserRentDetails({
    this.id = '',
    required this.vehicle,
    required this.prices,
    this.address = '',
    required this.location,
    required this.facilities,
  });

  factory UserRentDetails.fromJson(Map<String, dynamic> json) =>
      UserRentDetails(
        id: APIHelper.getSafeStringValue(json['_id']),
        vehicle: Vehicle.getAPIResponseObjectSafeValue(json['vehicle']),
        prices: Prices.getAPIResponseObjectSafeValue(json['prices']),
        address: APIHelper.getSafeStringValue(json['address']),
        location: UserRentDetailsLocation.getAPIResponseObjectSafeValue(
            json['location']),
        facilities:
            Facilities.getAPIResponseObjectSafeValue(json['facilities']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'vehicle': vehicle.toJson(),
        'prices': prices.toJson(),
        'address': address,
        'location': location.toJson(),
        'facilities': facilities.toJson(),
      };

  factory UserRentDetails.empty() => UserRentDetails(
        facilities: Facilities(),
        location: UserRentDetailsLocation(),
        prices: Prices.empty(),
        vehicle: Vehicle(),
      );
  static UserRentDetails getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserRentDetails.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserRentDetails.empty();
}

class UserDetailsCountry {
  String id;
  String name;
  String code;

  UserDetailsCountry({this.id = '', this.name = '', this.code = ''});

  factory UserDetailsCountry.fromJson(Map<String, dynamic> json) =>
      UserDetailsCountry(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        code: APIHelper.getSafeStringValue(json['code']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'code': code,
      };

  static UserDetailsCountry getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetailsCountry.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserDetailsCountry();
}

class Vehicle {
  String id;
  String uid;
  String name;
  List<String> images;

  Vehicle(
      {this.id = '', this.uid = '', this.name = '', this.images = const []});

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        images: APIHelper.getSafeListValue(json['images'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'images': images,
      };

  static Vehicle getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Vehicle.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Vehicle();
}

class UserRentDetailsLocation {
  double lat;
  double lng;

  UserRentDetailsLocation({this.lat = 0, this.lng = 0});

  factory UserRentDetailsLocation.fromJson(Map<String, dynamic> json) =>
      UserRentDetailsLocation(
        lat: APIHelper.getSafeDoubleValue(json['lat']),
        lng: APIHelper.getSafeDoubleValue(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static UserRentDetailsLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserRentDetailsLocation.fromJson(unsafeResponseValue)
          : UserRentDetailsLocation();
}

class Prices {
  Hourly hourly;
  Weekly weekly;
  Monthly monthly;

  Prices({required this.hourly, required this.weekly, required this.monthly});

  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
        hourly: Hourly.getAPIResponseObjectSafeValue(json['hourly']),
        weekly: Weekly.getAPIResponseObjectSafeValue(json['weekly']),
        monthly: Monthly.getAPIResponseObjectSafeValue(json['monthly']),
      );

  Map<String, dynamic> toJson() => {
        'daily': hourly.toJson(),
        'weekly': weekly.toJson(),
        'monthly': monthly.toJson(),
      };

  factory Prices.empty() => Prices(
        hourly: Hourly(),
        monthly: Monthly(),
        weekly: Weekly(),
      );
  static Prices getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Prices.fromJson(unsafeResponseValue)
          : Prices.empty();
}

class Hourly {
  bool active;
  double price;

  Hourly({this.active = false, this.price = 0});

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        active: APIHelper.getSafeBoolValue(json['active']),
        price: APIHelper.getSafeDoubleValue(json['price']),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'price': price,
      };

  static Hourly getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Hourly.fromJson(unsafeResponseValue)
          : Hourly();
}

class Weekly {
  bool active;
  double price;

  Weekly({this.active = false, this.price = 0});

  factory Weekly.fromJson(Map<String, dynamic> json) => Weekly(
        active: APIHelper.getSafeBoolValue(json['active']),
        price: APIHelper.getSafeDoubleValue(json['price']),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'price': price,
      };

  static Weekly getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Weekly.fromJson(unsafeResponseValue)
          : Weekly();
}

class Monthly {
  bool active;
  double price;

  Monthly({this.active = false, this.price = 0});

  factory Monthly.fromJson(Map<String, dynamic> json) => Monthly(
        active: APIHelper.getSafeBoolValue(json['active']),
        price: APIHelper.getSafeDoubleValue(json['price']),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'price': price,
      };

  static Monthly getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Monthly.fromJson(unsafeResponseValue)
          : Monthly();
}

class Facilities {
  bool smoking;
  int luggage;

  Facilities({this.smoking = false, this.luggage = 0});

  factory Facilities.fromJson(Map<String, dynamic> json) => Facilities(
        smoking: APIHelper.getSafeBoolValue(json['smoking']),
        luggage: APIHelper.getSafeIntValue(json['luggage']),
      );

  Map<String, dynamic> toJson() => {
        'smoking': smoking,
        'luggage': luggage,
      };

  static Facilities getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Facilities.fromJson(unsafeResponseValue)
          : Facilities();
}

class UserDetailsLoc {
  double lat;
  double lng;

  UserDetailsLoc({
    this.lat = 0,
    this.lng = 0,
  });

  factory UserDetailsLoc.fromJson(Map<String, dynamic> json) => UserDetailsLoc(
        lat: APIHelper.getSafeDoubleValue(json['lat']),
        lng: APIHelper.getSafeDoubleValue(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static UserDetailsLoc getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetailsLoc.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : UserDetailsLoc();
}

class UserDetailsRide {
  String id;
  UserDetailsRideDetailsVehicle vehicle;
  UserDetailsRideDetailsLocation location;
  bool online;

  UserDetailsRide(
      {this.id = '',
      required this.vehicle,
      required this.location,
      this.online = false});

  factory UserDetailsRide.fromJson(Map<String, dynamic> json) =>
      UserDetailsRide(
        id: APIHelper.getSafeStringValue(json['_id']),
        vehicle: UserDetailsRideDetailsVehicle.getAPIResponseObjectSafeValue(
            json['vehicle']),
        location: UserDetailsRideDetailsLocation.getAPIResponseObjectSafeValue(
            json['location']),
        online: APIHelper.getSafeBoolValue(json['online']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'vehicle': vehicle.toJson(),
        'location': location.toJson(),
        'online': online,
      };

  factory UserDetailsRide.empty() => UserDetailsRide(
      vehicle: UserDetailsRideDetailsVehicle(),
      location: UserDetailsRideDetailsLocation());
  static UserDetailsRide getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetailsRide.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserDetailsRide.empty();
}

class UserDetailsRideDetailsLocation {
  double lat;
  double lng;

  UserDetailsRideDetailsLocation({this.lat = 0, this.lng = 0});

  factory UserDetailsRideDetailsLocation.fromJson(Map<String, dynamic> json) =>
      UserDetailsRideDetailsLocation(
          lat: APIHelper.getSafeDoubleValue(json['lat']),
          lng: APIHelper.getSafeDoubleValue(json['lng']));

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static UserDetailsRideDetailsLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetailsRideDetailsLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserDetailsRideDetailsLocation();
}

class UserDetailsRideDetailsVehicle {
  String id;
  String uid;
  String name;
  List<String> images;

  UserDetailsRideDetailsVehicle(
      {this.id = '', this.uid = '', this.name = '', this.images = const []});

  factory UserDetailsRideDetailsVehicle.fromJson(Map<String, dynamic> json) =>
      UserDetailsRideDetailsVehicle(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        images: APIHelper.getSafeListValue(json['images'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'images': images,
      };

  static UserDetailsRideDetailsVehicle getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetailsRideDetailsVehicle.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserDetailsRideDetailsVehicle();
}

class DriverVehicle {
  UserVehicleLocation location;
  String id;
  String uid;
  String driver;
  String name;
  Category category;
  String model;
  String year;
  List<String> images;
  String maxPower;
  String maxSpeed;
  int capacity;
  String color;
  String fuelType;
  int mileage;
  String gearType;
  bool ac;
  String vehicleNumber;
  List<String> documents;
  String status;
  bool online;
  DateTime createdAt;
  DateTime updatedAt;

  DriverVehicle({
    required this.location,
    this.id = '',
    this.uid = '',
    this.driver = '',
    this.name = '',
    required this.category,
    this.model = '',
    this.year = '',
    this.images = const [],
    this.maxPower = '',
    this.maxSpeed = '',
    this.capacity = 0,
    this.color = '',
    this.fuelType = '',
    this.mileage = 0,
    this.gearType = '',
    this.ac = false,
    this.documents = const [],
    this.status = '',
    this.online = false,
    required this.createdAt,
    required this.updatedAt,
    this.vehicleNumber = '',
  });

  factory DriverVehicle.fromJson(Map<String, dynamic> json) => DriverVehicle(
        location:
            UserVehicleLocation.getAPIResponseObjectSafeValue(json['location']),
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        driver: APIHelper.getSafeStringValue(json['driver']),
        name: APIHelper.getSafeStringValue(json['name']),
        category: Category.getAPIResponseObjectSafeValue(json['category']),
        model: APIHelper.getSafeStringValue(json['model']),
        year: APIHelper.getSafeStringValue(json['year']),
        images: APIHelper.getSafeListValue(json['images'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        maxPower: APIHelper.getSafeStringValue(json['max_power']),
        maxSpeed: APIHelper.getSafeStringValue(json['max_speed']),
        capacity: APIHelper.getSafeIntValue(json['capacity']),
        color: APIHelper.getSafeStringValue(json['color']),
        fuelType: APIHelper.getSafeStringValue(json['fuel_type']),
        mileage: APIHelper.getSafeIntValue(json['mileage']),
        gearType: APIHelper.getSafeStringValue(json['gear_type']),
        ac: APIHelper.getSafeBoolValue(json['ac']),
        vehicleNumber: APIHelper.getSafeStringValue(json['vehicle_number']),
        documents: APIHelper.getSafeListValue(json['documents'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        status: APIHelper.getSafeStringValue(json['status']),
        online: APIHelper.getSafeBoolValue(json['online']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        '_id': id,
        'uid': uid,
        'driver': driver,
        'name': name,
        'category': category.toJson(),
        'model': model,
        'year': year,
        'images': images,
        'max_power': maxPower,
        'max_speed': maxSpeed,
        'capacity': capacity,
        'color': color,
        'fuel_type': fuelType,
        'mileage': mileage,
        'gear_type': gearType,
        'ac': ac,
        'vehicle_number': vehicleNumber,
        'documents': documents,
        'status': status,
        'online': online,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory DriverVehicle.empty() => DriverVehicle(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
        location: UserVehicleLocation(),
        category: Category(),
      );
  static DriverVehicle getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DriverVehicle.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : DriverVehicle.empty();
}

class UserVehicleLocation {
  String type;
  List<double> coordinates;

  UserVehicleLocation({this.type = '', this.coordinates = const []});

  factory UserVehicleLocation.fromJson(Map<String, dynamic> json) =>
      UserVehicleLocation(
        type: APIHelper.getSafeStringValue(json['type']),
        coordinates: APIHelper.getSafeListValue(json['coordinates'])
            .map((e) => APIHelper.getSafeDoubleValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates,
      };

  static UserVehicleLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserVehicleLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserVehicleLocation();
}

class Category {
  String id;
  String name;
  String image;

  Category({this.id = '', this.name = '', this.image = ''});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'image': image,
      };

  static Category getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Category.fromJson(unsafeResponseValue)
          : Category();
}

class Subscriptions {
  String id;
  Subscription subscription;
  DateTime startDate;
  DateTime endDate;

  Subscriptions(
      {this.id = '',
      required this.subscription,
      required this.startDate,
      required this.endDate});

  factory Subscriptions.fromJson(Map<String, dynamic> json) => Subscriptions(
        id: APIHelper.getSafeStringValue(json['_id']),
        subscription:
            Subscription.getAPIResponseObjectSafeValue(json['subscription']),
        startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
        endDate: APIHelper.getSafeDateTimeValue(json['end_date']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'subscription': subscription.toJson(),
        'start_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(startDate),
        'end_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(endDate),
      };

  factory Subscriptions.empty() => Subscriptions(
      endDate: AppComponents.defaultUnsetDateTime,
      startDate: AppComponents.defaultUnsetDateTime,
      subscription: Subscription());
  static Subscriptions getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Subscriptions.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Subscriptions.empty();
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
