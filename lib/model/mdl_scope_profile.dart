import '../evs2up_helper.dart';

class ScopeProfile /*extends ChangeNotifier*/ {
  ProjectScope projectScope;
  List<SiteScope> projectSites = [];
  List<Map<String, dynamic>> projectSitesMap = [];
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
    this.projectSites = const [],
    this.projectSitesMap = const [],
  });

  factory ScopeProfile.fromJson(Map<String, dynamic> json) {
    List<PaymentModeSetting> paymentSetting = [];
    if (json['payment_mode_setting'] != null) {
      json['payment_mode_setting'].forEach((v) {
        paymentSetting.add(PaymentModeSetting.fromJson(v));
      });
    }
    List<SiteScope> projectSitesName = [];
    List<Map<String, dynamic>> projectSitesMap = [];
    if (json['project_sites'] != null) {
      for (var site in json['project_sites']) {
        if (site is SiteScope) {
          projectSitesName.add(site);
        } else {
          projectSitesMap.add({
            'key': site['key'],
            'name': site['name'],
            'color': site['color'],
          });
        }
      }
    }

    return ScopeProfile(
      projectScope: json['project_scope'],
      timezone: json['timezone'],
      currency: json['currency'],
      validateEntityName: json['validate_entity_name'],
      allowCustomAmount: json['allow_custom_amount'] ?? false,
      paymentSetting: paymentSetting,
      projectSites: projectSitesName,
      projectSitesMap: projectSitesMap,
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
