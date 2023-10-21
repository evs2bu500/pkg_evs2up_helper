import '../enum/enum_acl.dart';
import '../evs2up_helper.dart';

// enum ProjectScope {
//   sg_global,
//   evs2_nus,
//   evs2_sutd,
//   evs2_ntu,
// }

// enum SiteScope {
//   nus_pgpr,
//   nus_ync,
//   nus_rvrc,
//   sutd_campus,
//   ntu_mr,
// }

class ScopeProfile /*extends ChangeNotifier*/ {
  ProjectScope projectScope;
  List<SiteScope>? projectSites = [];
  int timezone;
  String? currency = 'SGD';
  Function? validateEntityName;
  bool? allowCustomAmount = false;
  List<PaymentModeSetting>? paymentSetting = [];

  ProjectScope? _selectedProjectScope;
  SiteScope? _selectedSiteScope;
  void setScope(ProjectScope? projectScope, SiteScope? siteScope) {
    _selectedProjectScope = projectScope;
    _selectedSiteScope = siteScope;
    // notifyListeners();
  }

  ProjectScope? get selectedProjectScope => _selectedProjectScope;
  // set selectedProjectScope(ProjectScope? projectScope) {
  //   _selectedProjectScope = projectScope;
  //   notifyListeners();
  // }

  SiteScope? get selectedSiteScope => _selectedSiteScope;
  // set selectedSiteScope(SiteScope? siteScope) {
  //   _selectedSiteScope = siteScope;
  //   notifyListeners();
  // }

  String getEffectiveScopeStr() {
    if (_selectedSiteScope != null) {
      return _selectedSiteScope!.name;
    } else {
      return _selectedProjectScope!.name;
    }
  }

  AclScope getEffectiveScope() {
    if (_selectedSiteScope != null) {
      return AclScope.values
          .byName('site_${selectedSiteScope!.name.toLowerCase()}');
    } else {
      if (_selectedProjectScope == ProjectScope.SG_ALL) {
        return AclScope.values.byName('sg_all');
      }
      return AclScope.values
          .byName('project_${selectedProjectScope!.name.toLowerCase()}');
    }
  }

  ScopeProfile({
    required this.projectScope,
    required this.timezone,
    this.currency,
    this.validateEntityName,
    this.allowCustomAmount,
    this.paymentSetting,
    this.projectSites,
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
      projectSites: json['project_sites'],
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
