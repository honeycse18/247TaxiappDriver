class FakePaymentOptionModel {
  String name;
  String key;
  String paymentImage;
  FakePaymentOptionModel({
    this.name = '',
    this.key = '',
    this.paymentImage = '',
  });

  bool get isEmpty => key.isEmpty;
  bool get isNotEmpty => isEmpty == false;
}

class SelectPaymentOptionModel {
  String viewAbleName;
  String value;
  String paymentImage;
  SelectPaymentOptionModel({
    this.viewAbleName = '',
    this.value = '',
    this.paymentImage = '',
  });
}
