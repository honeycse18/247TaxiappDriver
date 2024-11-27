import 'package:get/get.dart';
import 'package:taxiappdriver/screens/about_us.dart';
import 'package:taxiappdriver/screens/accept_trip_request.dart';
import 'package:taxiappdriver/screens/add_vehicle_screen.dart';
import 'package:taxiappdriver/screens/auth/forgot_password_screen.dart';
import 'package:taxiappdriver/screens/auth/login_password_screen.dart';
import 'package:taxiappdriver/screens/auth/login_screen.dart';
import 'package:taxiappdriver/screens/auth/verification_screen.dart';
import 'package:taxiappdriver/screens/bottom_sheet/recieve_ride_bottomsheet.dart';
import 'package:taxiappdriver/screens/bottom_sheet/start_trip_bottomsheet.dart';
import 'package:taxiappdriver/screens/buy_package_screen.dart';
import 'package:taxiappdriver/screens/chat_screen_details.dart';
import 'package:taxiappdriver/screens/delete_account_screen.dart';
import 'package:taxiappdriver/screens/edit_document_screen.dart';
import 'package:taxiappdriver/screens/faqa_screen.dart';
import 'package:taxiappdriver/screens/help_support.dart';
import 'package:taxiappdriver/screens/home_navigator/home_screen.dart';
import 'package:taxiappdriver/screens/home_navigator/wallet_screen.dart';
import 'package:taxiappdriver/screens/home_navigator_screen.dart';
import 'package:taxiappdriver/screens/intro_screen.dart';
import 'package:taxiappdriver/screens/menu_screen_pages/add_withdraw_methods_screen.dart';
import 'package:taxiappdriver/screens/menu_screen_pages/add_withdraw_methods_secreen2.dart';
import 'package:taxiappdriver/screens/menu_screen_pages/change_password_screen.dart';
import 'package:taxiappdriver/screens/menu_screen_pages/saved_withdraw_methods.dart';
import 'package:taxiappdriver/screens/menu_screen_pages/settings_screen.dart';
import 'package:taxiappdriver/screens/menu_screens/documents_screen.dart';
import 'package:taxiappdriver/screens/menu_screens/edit_profile_screen.dart';
import 'package:taxiappdriver/screens/menu_screens/photo_view.dart';
import 'package:taxiappdriver/screens/menu_screens/my_trip_history.dart';
import 'package:taxiappdriver/screens/menu_screens/select_location_screen.dart';
import 'package:taxiappdriver/screens/my_vehicle_1.dart';
import 'package:taxiappdriver/screens/my_vehicle_screen.dart';
import 'package:taxiappdriver/screens/notification_screen.dart';
import 'package:taxiappdriver/screens/package_details_screen.dart';
import 'package:taxiappdriver/screens/privacy_policy_screen.dart';
import 'package:taxiappdriver/screens/profile.dart';
import 'package:taxiappdriver/screens/registration/create_new_password_screen.dart';
import 'package:taxiappdriver/screens/registration/signup_screen.dart';
import 'package:taxiappdriver/screens/splash_screen.dart';
import 'package:taxiappdriver/screens/start_ride_request_screen.dart';
import 'package:taxiappdriver/screens/subscription_screen.dart';
import 'package:taxiappdriver/screens/terms_and_condition_screen.dart';
import 'package:taxiappdriver/screens/topup_screen.dart';
import 'package:taxiappdriver/screens/transaction_history_screen.dart';
import 'package:taxiappdriver/screens/unknown_screen.dart';
import 'package:taxiappdriver/screens/withrow_screen.dart';
import 'package:taxiappdriver/screens/zoom_drawer/zoom_drawer_screen.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';

class AppPages {
  static final List<GetPage<dynamic>> pages = [
    GetPage(name: AppPageNames.rootScreen, page: () => const SplashScreen()),
    GetPage(name: AppPageNames.introScreen, page: () => const IntroScreen()),
    GetPage(name: AppPageNames.loginScreen, page: () => const LoginScreen()),
    GetPage(name: AppPageNames.signUpScreen, page: () => const SignUpScreen()),
    GetPage(
        name: AppPageNames.transactionHistoryScreen,
        page: () => const TransactionHistoryScreen()),
    GetPage(
        name: AppPageNames.packageDetailsScreen,
        page: () => const PackageDetailsScreen()),
    GetPage(
        name: AppPageNames.buyPackageScreen,
        page: () => const BuyPackageScreen()),
    GetPage(
        name: AppPageNames.subscriptionScreen,
        page: () => const SubscriptionScreen()),
    // GetPage(
    //     name: AppPageNames.homeNavigatorScreen,
    //     page: () => const HomeNavigatorScreen()),
    GetPage(
        name: AppPageNames.verificationScreen,
        page: () => const VerificationScreen()),
    GetPage(
        name: AppPageNames.forgotPasswordScreen,
        page: () => const ForgotPasswordScreen()),
    GetPage(
        name: AppPageNames.createNewPasswordScreen,
        page: () => const CreateNewPasswordScreen()),
    GetPage(
        name: AppPageNames.zoomDrawerScreen,
        page: () => const ZoomDrawerScreen()),
    GetPage(
        name: AppPageNames.withdrawScreen, page: () => const WithdrawScreen()),
    GetPage(name: AppPageNames.topUpScreen, page: () => const TopUpScreen()),
    GetPage(
        name: AppPageNames.editProfileScreen,
        page: () => const EditProfileScreen()),
    GetPage(
        name: AppPageNames.profileScreen, page: () => const ProfileScreen()),
    GetPage(name: AppPageNames.walletScreen, page: () => const WalletScreen()),
    GetPage(
        name: AppPageNames.photoViewScreen,
        page: () => const PhotoViewScreen()),
    GetPage(
        name: AppPageNames.documentsScreen,
        page: () => const DocumentsScreen()),
    GetPage(
        name: AppPageNames.addVehicleScreen,
        page: () => const AddVehicleScreen()),
    GetPage(
        name: AppPageNames.editDocumentsScreen,
        page: () => const EditDocumentScreen()),
    GetPage(
        name: AppPageNames.loginPasswordScreen,
        page: () => const LoginPasswordScreen()),
    GetPage(
      name: AppPageNames.selectLocationScreen,
      page: () => SelectLocationScreen(),
    ),
    GetPage(name: AppPageNames.unknownPage, page: () => const UnknownPage()),
    GetPage(
        name: AppPageNames.savedWithdrawMethodsScreen,
        page: () => const SavedWithdrawMethodsScreen()),
    GetPage(
        name: AppPageNames.addWithdrawMethodsScreen,
        page: () => const AddWithdrawMethodsScreen()),
    GetPage(name: AppPageNames.chatScreen, page: () => const ChatScreen()),
    GetPage(
        name: AppPageNames.addWithdrawMethodSecondScreen,
        page: () => const AddWithdrawMethodSecondScreen()),
    GetPage(name: AppPageNames.homeScreen, page: () => const HomeScreen()),
    // GetPage(
    //     name: AppPageNames.homeNavigatorScreen,
    //     page: () => const HomeNavigatorScreen()),
    GetPage(
        name: AppPageNames.aboutUsScreen, page: () => const AboutUsScreen()),
    GetPage(
        name: AppPageNames.privacyPolicyScreen,
        page: () => const PrivacyPolicyScreen()),
    GetPage(
        name: AppPageNames.termsConditionScreen,
        page: () => const TermsConditionScreen()),
    GetPage(
        name: AppPageNames.deleteAccountScreen,
        page: () => const DeleteAccountScreen()),
    GetPage(
        name: AppPageNames.helpSupport, page: () => const HelpSupportScreen()),
    GetPage(
        name: AppPageNames.settingsScreen, page: () => const SettingsScreen()),
    GetPage(name: AppPageNames.faqaScreen, page: () => const FaqaScreen()),
    GetPage(
        name: AppPageNames.scheduleRideListScreen,
        page: () => const MyTripList()),
    GetPage(
        name: AppPageNames.acceptTripRequestScreen,
        page: () => const AcceptTripRequest()),
    GetPage(
        name: AppPageNames.startRideRequestScreen,
        page: () => const StartRideRequestScreen()),
    GetPage(
        name: AppPageNames.notificationScreen,
        page: () => const NotificationScreen()),
    GetPage(
        name: AppPageNames.receiveRideBottomSheetScreen,
        page: () => const ReceiveRideBottomSheetScreen()),
    GetPage(
        name: AppPageNames.startRideBottomSheetScreen,
        page: () => const StartRideBottomSheetScreen()),
    GetPage(
        name: AppPageNames.myVehicleScreen,
        page: () => const MyVehicleInformationScreen()),
    // GetPage(
    //     name: AppPageNames.myVehicle1Screen, page: () => const MyVehicle1()),
    GetPage(
        name: AppPageNames.changePasswordPromptScreen,
        page: () => const ChangePasswordPromptScreen()),
  ];
  static final GetPage<dynamic> unknownScreenPageRoute = GetPage(
    name: AppPageNames.unknownScreen,
    page: () => const UnknownPage(),
  );
}
