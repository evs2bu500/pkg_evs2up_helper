import 'mdl_acl_setting.dart';
import 'package:flutter/material.dart';

// enum PortalPage {
//   userDashBoard,
//   publicFront,
//   userService,
//   aclService,
//   login,
//   meterKiv,
//   meterService,
//   transactionService,
//   creditService,
// }

enum PortalPage {
  userDashBoard,
  publicFront,
  userService,
  aclService,
  login,
  meterKiv,
  meterService,
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

enum EVS2sec { Empty, Default, Create, Search, Detail }

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
const meterManager = 'Meter Manager';
const transactionService = 'Transaction Service';
const transactionHistory = 'Transaction History';
const tariffHistory = 'Tariff History';
const creditService = 'Credit Service';
const topupCredit = 'Topup Credit';
const adjCredit = 'Adjust Credit';
const meterInfo = 'Meter Info';
const listSearchMeter = 'List/Search Meter';
const meterCommissioning = 'Meter Commissioning';
const meterMassSet = 'Meter Mass Set';
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
  double _screenWidth = 0;
  double get screenWidth => _screenWidth;
  // set screenWidth(double screenWidth) {
  //   _screenWidth = screenWidth;
  //   notifyListeners();
  // }
  double _screenHeight = 0;
  double get screenHeight => _screenHeight;
  // set screenHeight(double screenHeight) {
  //   _screenHeight = screenHeight;
  //   notifyListeners();
  // }

  // bool _splashed = false;
  // bool get splashed => _splashed;
  // set splashed(bool splashed) {
  //   _splashed = splashed;
  //   // notifyListeners();
  // }

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

  // bool _canSeeOpsDrawer = false;
  // bool get canSeeOpsDrawer => _canSeeOpsDrawer;
  // set canSeeOpsDrawer(bool canSeeOpsDrawer) {
  //   _canSeeOpsDrawer = canSeeOpsDrawer;
  //   notifyListeners();
  // }

  PortalPage _pgCur = PortalPage.publicFront;
  EVS2sec _secCur = EVS2sec.Empty;

  AppModel() {
    _pgCur = PortalPage.publicFront;
    _secCur = EVS2sec.Empty;
  }

  PortalPage get curPage => _pgCur;

  EVS2sec get curSec => _secCur;

  set curPage(PortalPage curPage) {
    _pgCur = curPage;
    notifyListeners();
  }

  set curSec(EVS2sec curSec) {
    _secCur = curSec;
    notifyListeners();
  }
}
