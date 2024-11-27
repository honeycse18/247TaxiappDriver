import 'package:get/get_connect/http/src/http.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:taxiappdriver/model/api_response/about_us_response.dart';
import 'package:taxiappdriver/model/api_response/car_brand_response.dart';
import 'package:taxiappdriver/model/api_response/car_categories_response.dart';
import 'package:taxiappdriver/model/api_response/car_model_response.dart';
import 'package:taxiappdriver/model/api_response/chat_message_list_demo_response.dart';
import 'package:taxiappdriver/model/api_response/chat_message_list_response.dart';
import 'package:taxiappdriver/model/api_response/country_list_response.dart';
import 'package:taxiappdriver/model/api_response/dashboard_police_response.dart';
import 'package:taxiappdriver/model/api_response/find_account_response.dart';
import 'package:taxiappdriver/model/api_response/get_user_data_response.dart';
import 'package:taxiappdriver/model/api_response/get_wallet_details_response.dart';
import 'package:taxiappdriver/model/api_response/get_withdraw_saved_methods.dart';
import 'package:taxiappdriver/model/api_response/google_map_poly_lines_response.dart';
import 'package:taxiappdriver/model/api_response/login_response.dart';
import 'package:taxiappdriver/model/api_response/my_vehicle_details_response.dart';
import 'package:taxiappdriver/model/api_response/notification_list_response.dart';
import 'package:taxiappdriver/model/api_response/otp_request_response.dart';
import 'package:taxiappdriver/model/api_response/otp_verification_response.dart';
import 'package:taxiappdriver/model/api_response/registration_response.dart';
import 'package:taxiappdriver/model/api_response/ride_details_response.dart';
import 'package:taxiappdriver/model/api_response/ride_history_response.dart';
import 'package:taxiappdriver/model/api_response/ride_request_response.dart';
import 'package:taxiappdriver/model/api_response/saved_withdraw_method_details.dart';
import 'package:taxiappdriver/model/api_response/social_google_login_response.dart';
import 'package:taxiappdriver/model/api_response/subscription_list_history_response.dart';
import 'package:taxiappdriver/model/api_response/subscription_list_response.dart';
import 'package:taxiappdriver/model/api_response/support_text_response.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/model/api_response/vehicle_details_response.dart';
import 'package:taxiappdriver/model/api_response/wallet_history_response.dart';
import 'package:taxiappdriver/model/api_response/withdraw_method_list_response.dart';
import 'package:taxiappdriver/model/api_response/withdraw_methods_response.dart';
import 'package:taxiappdriver/model/core_api_responses/raw_api_response.dart';
import 'package:taxiappdriver/model/fakeModel/enam.dart';
import 'package:taxiappdriver/utils/api_client.dart';
import 'package:taxiappdriver/utils/constansts/app_constans.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';

import '../../model/api_response/faq_response.dart';

class APIRepo {
  /*<--------Get routes polylines from google API------->*/
  static Future<GoogleMapPolyLinesResponse?> getRoutesPolyLines(
      double originLatitude,
      double originLongitude,
      double targetLatitude,
      double targetLongitude) async {
    try {
      await APIHelper.preAPICallCheck();
      // final GetHttpClient apiHttpClient = APIClient.instance.googleMapsAPIClient();
      final Map<String, dynamic> queries = {
        'origin': '$originLatitude,$originLongitude',
        'destination': '$targetLatitude,$targetLongitude',
        'sensor': 'false',
        'key': AppConstants.googleAPIKey,
      };
      final Response response =
          // await apiHttpClient.get('/maps/api/directions/json', query: queries);
          await APIClient.instance.requestGetMapMethod(
              url: '/maps/api/directions/json', queries: queries);
      APIHelper.postAPICallCheck(response);
      final GoogleMapPolyLinesResponse responseModel =
          GoogleMapPolyLinesResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<UserDetailsResponse?> getUserDetails({String? token}) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/user/',
              headers: token != null
                  ? {'Authorization': 'Bearer $token'}
                  : APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final UserDetailsResponse responseModel =
          UserDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<--------Update password------->*/
  static Future<RawAPIResponse?> updatePassword(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/user/password',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  /*<------- Accept reject ride request -------->*/
  static Future<RawAPIResponse?> acceptRejectRideRequest(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/ride/request/status',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Get pending ride request response from API -------->*/
  static Future<RideRequestResponse?> getPendingRideRequestResponse() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/ride/requests', headers: APIHelper.getAuthHeaderMap());
      /* await apiHttpClient.get('/api/user/',
          headers: token != null
              ? {'Authorization': 'Bearer $token'}
              : APIHelper.getAuthHeaderMap()); */

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RideRequestResponse responseModel =
          RideRequestResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<-------Get dashboard emergency date details from API-------->*/

  static Future<DashboardEmergencyDataResponse?>
      getDashBoardEmergencyDataDetails() async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/settings', headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final DashboardEmergencyDataResponse responseModel =
          DashboardEmergencyDataResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> withdrawRequest(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/withdraw',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<--------Topup wallet------->*/
  static Future<RawAPIResponse?> topUpWallet(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/wallet/add',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<--------Topup wallet------->*/
  static Future<RawAPIResponse?> addWithdrawMethod(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/withdraw-method/user',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<--------Topup wallet------->*/
  static Future<RawAPIResponse?> editWithdrawMethod(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/withdraw-method/user',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SavedWithdrawMethodsResponse?> getWithdrawMethod() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response =
          await apiHttpClient.get('/api/withdraw-method/user/list',
              // query: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SavedWithdrawMethodsResponse responseModel =
          SavedWithdrawMethodsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<-------Get FAQ item list from API-------->*/
  static Future<FaqResponse?> getFaqItemList(int currentPageNumber) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/faq/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final FaqResponse responseModel =
          FaqResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<AboutUsResponse?> getAboutUsText() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'slug': 'about_us'};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/page',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final AboutUsResponse responseModel =
          AboutUsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> postContactUsMessage(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/contact',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<CountryListResponse?> getCountryList() async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/countries', headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final CountryListResponse responseModel =
          CountryListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ChatMessageListSendResponse?> sendMessage(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/message',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ChatMessageListSendResponse responseModel =
          ChatMessageListSendResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<--------Get transaction history------->*/
  static Future<WalletTransactionHistoryResponse?> getTransactionHistory(
      int currentPageNumber, TransactionHistoryStatus selectedStatus) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
        'filter_by': selectedStatus.stringValue
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/wallet/history',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final WalletTransactionHistoryResponse responseModel =
          WalletTransactionHistoryResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> updateDriverStatus(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/ride/driver/status',
              requestBody: requestBody, 
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  /*<--------Get transaction history------->*/
  static Future<WalletTransactionHistoryResponse?> getWithdrawHistory(
      int currentPageNumber) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/withdraw/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final WalletTransactionHistoryResponse responseModel =
          WalletTransactionHistoryResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<--------Get wallet details------->*/
  static Future<GetWalletDetailsResponse?> getWalletDetails() async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/wallet', headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final GetWalletDetailsResponse responseModel =
          GetWalletDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Get notification list from API -------->*/
  static Future<NotificationListResponse?> getNotificationList(
      int currentPageNumber) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/notification/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final NotificationListResponse responseModel =
          NotificationListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<WithdrawMethodListResponse?> getAddWithdrawMethods(
      int currentPageNumber) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/withdraw-method/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final WithdrawMethodListResponse responseModel =
          WithdrawMethodListResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Start ride with submit OTP -------->*/
  static Future<RawAPIResponse?> startRideWithSubmitOtp(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/ride',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<--------Verify OTP------->*/
  static Future<OtpVerificationResponse?> verifyOTP(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/user/verify-otp', requestBody: requestBody);
      APIHelper.postAPICallCheck(response);
      final OtpVerificationResponse responseModel =
          OtpVerificationResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SupportTextResponse?> getSupportText(
      {required String slug}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'slug': slug};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/page',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SupportTextResponse responseModel =
          SupportTextResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Read notification -------->*/
  static Future<RawAPIResponse?> readNotification(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/notification/read',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }
  /*<-------- Google Login API ------->*/

  static Future<SocialGoogleLoginResponse?> socialGoogleLoginVerify(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response = await apiHttpClient
          .post('/api/user/verify-google-user', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SocialGoogleLoginResponse responseModel =
          SocialGoogleLoginResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<--------Find Account------->*/
  static Future<FindAccountResponse?> findAccount(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response =
          await APIClient.instance.requestPostMethodAsURLEncoded(
        url: '/api/user/find',
        requestBody: requestBody,
      );
      APIHelper.postAPICallCheck(response);
      final FindAccountResponse responseModel =
          FindAccountResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> readMessage(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/message',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ChatMessageListResponse?> getChatMessageList(
      int currentPageNumber, String id) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
        'with': id,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/message/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final ChatMessageListResponse responseModel =
          ChatMessageListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Get ride details from API -------->*/
  static Future<RideDetailsResponse?> getRideDetails(String rideId) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        '_id': rideId,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/ride',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RideDetailsResponse responseModel =
          RideDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Update ride status from API -------->*/
  static Future<RawAPIResponse?> updateRideStatus(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/ride',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  //-----------------------------------
  static Future<RawAPIResponse?> deleteUserAccount() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response =
          await APIClient.instance.requestDeleteMethodAsURLEncoded(
        url: '/api/user',
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<LoginResponse?> login(Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/user/login', requestBody: requestBody);
      APIHelper.postAPICallCheck(response);
      final LoginResponse responseModel =
          LoginResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Update trip status -------->*/
  static Future<RawAPIResponse?> updateTripStatus(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/ride',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Read all notification -------->*/
  static Future<RawAPIResponse?> readAllNotification(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/notification/read/all',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<-------Get ride history from API-------->*/
  static Future<RideHistoryResponse?> getRideHistoryList(
      int currentPageNumber, String key) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
        'status': key,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/ride/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RideHistoryResponse responseModel =
          RideHistoryResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Vehicle status online -------->*/
  static Future<RawAPIResponse?> vehicleStatusOnline(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/ride/driver/status',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<GetUserDataResponse?> getIdUserDetails(String id) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        '_id': id,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/user/details',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final GetUserDataResponse responseModel =
          GetUserDataResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> buySubscriptionPackageMethod(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/subscription/buy',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<--------Registration------->*/
  static Future<RegistrationResponse?> registration(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/user/registration', requestBody: requestBody);
      APIHelper.postAPICallCheck(response);
      final RegistrationResponse responseModel =
          RegistrationResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> updateUserProfile(dynamic requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      String contentType = 'multipart/form-data';
      if (requestBody is String) {
        contentType = 'application/json';
      }
      final Response response = await APIClient.instance.apiClient.patch(
          '/api/user/',
          body: requestBody,
          contentType: contentType,
          headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<-------Request Otp-------->*/
  static Future<OtpRequestResponse?> requestOTP(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/user/send-otp', requestBody: requestBody);

      APIHelper.postAPICallCheck(response);
      final OtpRequestResponse responseModel =
          OtpRequestResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<CarBrandResponse?> getCarBrands() async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/brand/elements',
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final CarBrandResponse responseModel =
          CarBrandResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SavedWithdrawMethodsResponse?> getSavedWithdrawMethods() async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/withdraw-method/user/list',
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final SavedWithdrawMethodsResponse responseModel =
          SavedWithdrawMethodsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SavedWithdrawMethodDetailsResponse?>
      getSavedWithdrawMethodsDetails(String id) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        '_id': id,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/withdraw-method/user',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final SavedWithdrawMethodDetailsResponse responseModel =
          SavedWithdrawMethodDetailsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SubscriptionListResponse?> getSubscriptionList(
      String id) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'category': id,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/subscription/category',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final SubscriptionListResponse responseModel =
          SubscriptionListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SubscriptionHistoryResponse?> getSubscriptionHistory() async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/subscription/history',
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final SubscriptionHistoryResponse responseModel =
          SubscriptionHistoryResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<CarBrandModelResponse?> getCarModels(String id) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'brand_model': id,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/brand/models',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final CarBrandModelResponse responseModel =
          CarBrandModelResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> updateVehicleDetails(
      FormData requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response
          response = /* await APIClient.instance.requestPostMethod(
          url: '/api/vehicle',
          requestBody: requestBody,
          headers: APIHelper.getAuthHeaderMap()); */
          await APIClient.instance.apiClient.patch('/api/vehicle',
              body: requestBody,
              contentType: 'multipart/form-data',
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<CarCategoriesResponse?> getCarCategories(String year) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'model_year': year,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/category/based-on-model-year',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final CarCategoriesResponse responseModel =
          CarCategoriesResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> addVehicle(FormData requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response
          response = /* await APIClient.instance.requestPostMethod(
          url: '/api/vehicle',
          requestBody: requestBody,
          headers: APIHelper.getAuthHeaderMap()); */
          await APIClient.instance.apiClient.post('/api/vehicle',
              body: requestBody,
              contentType: 'multipart/form-data',
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<--------Create new password------->*/
  static Future<RawAPIResponse?> createNewPassword(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/user/reset-password', requestBody: requestBody);
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Get support text from API -------->*/
/*<------- Get vehicle details from API -------->*/
  static Future<MyVehicleDetailsResponse?> getVehicleDetails(
      {required String productId}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': productId};

      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/vehicle',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final MyVehicleDetailsResponse responseModel =
          MyVehicleDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> removeVehicle(
      {required String vehicleId}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Map<String, String> requestBody = {
        '_id': vehicleId,
      };

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response =
          await APIClient.instance.requestDeleteMethodAsURLEncoded(
        url: '/api/vehicle',
        queries: requestBody,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }
}
