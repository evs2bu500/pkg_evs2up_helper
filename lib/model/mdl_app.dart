import 'package:evs2up_helper/model/mdl_scope_profile.dart';

import 'mdl_acl_setting.dart';
import 'package:flutter/material.dart';

enum PortalPage {
  userDashBoard,
  publicFront,
  userService,
  aclService,
  login,
  meterKiv,
  meterService,
  sensorService,
  transactionService,
  creditService,
  projectService,
  buildingService,
  levelService,
  levelDevices,
  equipmentService,
  alarmService,
  paymentSuccess,
}

//page titles
const dashboard = 'Dashboard';
const opsDashboard = 'Ops Dashboard';
const publicFront = 'Public Front';
const userService = 'User Service';
const aclService = 'ACL Service';
const listSearchUser = 'List/Search User';
const listRoles = 'List Roles';
const listPermissions = 'List Permissions';
const createNewAccount = 'Create New Account';
const configACL = 'Configure ACL';
const meterService = 'Meter Service';
const sensorManager = 'Sensor Manager';
const sensorService = 'Sensor Service';
const meterManager = 'Meter Manager';
const siteManager = 'Site Manager';
const transactionService = 'Transaction Service';
const transactionHistory = 'Transaction History';
const topupHistory = 'Topup History';
const tariffHistory = 'Tariff History';
const creditService = 'Credit Service';
const topupCredit = 'Topup Credit';
const adjCredit = 'Adjust Credit';
const creditOps = 'Credit Ops';
const batchCrditOps = 'Batch Credit Ops';
const meterInfo = 'Meter Info';
const sensorInfo = 'Sensor Info';
const listSearchMeter = 'List/Search Meter';
const meterCommissioning = 'Commissioning';
const meterBatchOps = 'Meter Batch Ops';
const meterOps = 'Meter Ops';
const meterKiv = 'Meter KIV';
const meterAlarm = 'Meter Alarm';
const paymentSuccess = 'Payment Success';
const login = 'Login';
const createUser = 'Create User';
const userProfile = 'User Profile';
const projectService = 'Project Service';
const buildingService = 'Building Service';
const buildingLevels = 'Building Levels';
const levelService = 'Level Service';
const levelDevices = 'Level Devices';
const equipmentService = 'Equipment Service';
const alarmService = 'Alarm Service';

class AppModel extends ChangeNotifier {
  String? subDomain;
  ScopeProfile portalScopeProfile;
  String? appName;
  String? appVer;
  // int aa = 0;

  AppModel({
    required this.subDomain,
    required this.portalScopeProfile,
    this.appName,
    this.appVer,
  }) {
    // print('AppModel constructor');
    // _portalScopeProfile = portalScopeProfile;
  }

  // ScopeProfile? get portalScopeProfile => _portalScopeProfile;
  // set scopeProfile(ScopeProfile portalScopeProfile) {
  //   _portalScopeProfile = portalScopeProfile;
  //   notifyListeners();
  // }

  // set ax(int a) {
  //   aa = a;
  //   notifyListeners();
  // }

  PortalPage _pgCur = PortalPage.publicFront;
  PortalPage get curPage => _pgCur;

  set curPage(PortalPage curPage) {
    _pgCur = curPage;
    notifyListeners();
  }

  AclSetting? aclSetting;
  AclSetting? get acl => aclSetting;
  set acl(AclSetting? acl) {
    aclSetting = acl;
    notifyListeners();
  }

  List<dynamic> _pgks = [];
  List<dynamic> get pgks => _pgks;
  set pgks(List<dynamic> pgks) {
    _pgks = pgks;
    notifyListeners();
  }
}
