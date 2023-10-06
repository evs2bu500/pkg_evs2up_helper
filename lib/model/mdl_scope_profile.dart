import 'package:evs2up_helper/model/mdl_payment_mode_setting.dart';

enum ProjectScope {
  sg_global,
  evs2_nus,
  evs2_sutd,
  evs2_ntu,
}

enum SiteScope {
  nus_pgpr,
  nus_ync,
  nus_rvrc,
  sutd_campus,
  ntu_mr,
}

class ScopeProfile {
  ProjectScope projectScope;
  int timezone;
  String? currency = 'SGD';
  Function? validateEntityName;
  bool? allowCustomAmount = false;
  List<PaymentModeSetting>? paymentSetting = [];

  ScopeProfile({
    required this.projectScope,
    required this.timezone,
    this.currency,
    this.validateEntityName,
    this.allowCustomAmount,
    this.paymentSetting,
  });

  factory ScopeProfile.fromJson(Map<String, dynamic> json) {
    List<PaymentModeSetting> paymentSetting = [];
    if (json['payment_mode_setting'] != null) {
      json['payment_mode_setting'].forEach((v) {
        paymentSetting.add(PaymentModeSetting.fromJson(v));
      });
    }

    return ScopeProfile(
      projectScope: json['project_scope'],
      timezone: json['timezone'],
      currency: json['currency'],
      validateEntityName: json['validate_entity_name'],
      allowCustomAmount: json['allow_custom_amount'],
      paymentSetting: paymentSetting,
    );
  }

  PaymentModeSetting? getStripePaymentSetting() {
    for (var setting in paymentSetting!) {
      if (setting.paymentMode == PaymentMode.stripe) {
        return setting;
      }
    }
    return null;
  }
}
