import 'package:country_code_picker/country_code_picker.dart';

class SignUpScreenParameter {
  bool isEmail;
  String emailOrPhone;
  String theValue;
  CountryCode? countryCode;
  SignUpScreenParameter(
      {this.isEmail = false,
      this.countryCode,
       this.theValue='',
       this.emailOrPhone=''});
}
