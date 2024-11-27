import 'package:taxiappdriver/model/fakeModel/intro_content_model.dart';
import 'package:taxiappdriver/model/fakeModel/payment_option_model.dart';

class FakeData {
  static List<IntroContent> introContents = [
    IntroContent(
        localSVGImageLocation: 'assets/images/intro1.png',
        slogan: 'Discover Convenient Rides',
        content:
            'Find hassle-free transportation options tailored to your needs. Whether you\'re commuting to work, heading out for a night on the town, or planning a weekend getaway, our app connects you to reliable rides at your fingertips.'),
    IntroContent(
        localSVGImageLocation: 'assets/images/intro2.png',
        slogan: 'Customize Your Journey',
        content:
            'Personalize your ride experience with customizable options. Set your preferences for vehicle type, music, and more, ensuring every trip is comfortable and enjoyable. Your journey, your way.'),
    IntroContent(
        localSVGImageLocation: 'assets/images/intro3.png',
        slogan: 'Safety First, Always',
        content:
            'Your safety is our top priority. From thorough driver screenings to real-time trip monitoring, we\'ve implemented comprehensive safety measures to ensure peace of mind for every ride. Ride with confidence knowing that your well-being is our commitment.'),
  ];

  static var topupOptionList = <SelectPaymentOptionModel>[
    SelectPaymentOptionModel(
        paymentImage: 'https://cdn-icons-png.flaticon.com/512/174/174861.png',
        value: 'paypal',
        viewAbleName: 'PayPal'),
    SelectPaymentOptionModel(
        paymentImage: 'https://cdn-icons-png.flaticon.com/512/5968/5968382.png',
        value: 'stripe',
        viewAbleName: 'Stripe'),
  ];

  static List<FakePaymentOptionModel> subscriptionPaymentOptions = [
    FakePaymentOptionModel(
        key: 'paypal',
        name: 'Paypal',
        paymentImage:
            'https://cdn-icons-png.flaticon.com/512/174/174861.png'),
    FakePaymentOptionModel(
        key: 'stripe',
        name: 'Stripe',
        paymentImage: 
            'https://cdn-icons-png.flaticon.com/512/5968/5968382.png'),
  ];

  static var cancelRideReason = <FakeCancelRideReason>[
    FakeCancelRideReason(reasonName: 'Waiting for a long time '),
    FakeCancelRideReason(reasonName: 'Ride isn’t here '),
    FakeCancelRideReason(reasonName: 'Wrong address shown'),
    FakeCancelRideReason(reasonName: 'Don’t charge rider'),
    FakeCancelRideReason(reasonName: 'Other'),
  ];
}
