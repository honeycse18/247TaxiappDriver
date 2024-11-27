import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:taxiappdriver/model/api_response/my_vehicle_details_response.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/model/fakeModel/enam.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';

class MyVehicleInformationScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  UserDetailsData userDetailsData = UserDetailsData.empty();
  String vehicleId = '';
  //VehicleDetailsItem vehicleDetailsItem = VehicleDetailsItem.empty();
  final PageController imageController = PageController(keepPage: false);

  List<String> images = [];
  List<String> documents = [];
  MyVehicleDetails myVehicleDetails = MyVehicleDetails.empty();
  final GlobalKey<FormState> addCarFstFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addCarSecondFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addCarThirdFormKey = GlobalKey<FormState>();
  Rx<AddVehicleTabState> addVehicleState = AddVehicleTabState.VehicleInfo.obs;
  /* <---- Edit button tap ----> */
  void onAddButtonTap() async {
    await Get.toNamed(AppPageNames.addVehicleScreen);
    getUserDetails();
  }

  void onEditButtonTap() async {
    await Get.toNamed(AppPageNames.addVehicleScreen, arguments: vehicleId);
    getUserDetails();
  }

  /*<----------- Get user details from API----------->*/ /*<----------- Get user details from API----------->*/
  Future<void> getUserDetails() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessGetLoggedInUserDetails(response);
  }

  void onSuccessGetLoggedInUserDetails(UserDetailsResponse response) {
    userDetailsData = response.data;
    vehicleId = userDetailsData.vehicle.id;
    update();
    if (vehicleId != '') {
      getVehicleDetails(vehicleId);
    }
  }

  /*<----------- Get vehicle details from API----------->*/
  Future<void> getVehicleDetails(String vehicleId) async {
    MyVehicleDetailsResponse? response =
        await APIRepo.getVehicleDetails(productId: vehicleId);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    _onSuccessGetVehicleDetailsResponse(response);
  }

  void _onSuccessGetVehicleDetailsResponse(MyVehicleDetailsResponse response) {
    myVehicleDetails = response.data;
    images = response.data.images;
    update();
  }

  void _getScreenParameters() {
    dynamic params = Get.arguments;

    if (params is UserDetailsData) {
      userDetailsData = params;

      if (userDetailsData.vehicle.id != '') {
        myVehicleDetails = userDetailsData.vehicle;
        vehicleId = userDetailsData.vehicle.id;
        images = userDetailsData.vehicle.images;
        update();
      } else if (userDetailsData.isEmpty()) {
        getUserDetails();
      }
      update();
    }
    update();
  }

  /* <---- Initial state ----> */
  @override
  void onInit() {
    _getScreenParameters();

    super.onInit();
  }
}
