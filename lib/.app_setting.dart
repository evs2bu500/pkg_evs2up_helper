import 'package:evs2up_helper/evs2up_helper.dart';

// const String activeScope = 'evs2_ntu';

enum Evs2Project { NUS, SUTD, NTU, SMU, SIT, SUSS, NONE, ALL }

final scopeProfile = [
  {
    'project_scope': ProjectScope.sg_global,
    'timezone': 8,
    'currency': 'SGD',
    'validate_entity_displayname': (displayname) {
      //8 digits, start with '1'
      RegExp exp1 = RegExp(r'^1\d{7}$');
      RegExp exp1 = RegExp(r'^2\d{7}$');
      RegExp exp1 = RegExp(r'^3\d{7}$');
      if (exp.hasMatch(displayname) ||
          exp1.hasMatch(displayname) ||
          exp2.hasMatch(displayname)) {
        return null;
      } else {
        return 'Invalid displayname';
      }
    },
  },
  {
    'project_scope': ProjectScope.evs2_nus,
    'timezone': 8,
    'currency': 'SGD',
    'validate_entity_displayname': (displayname) {
      //8 digits, start with '1'
      RegExp exp = RegExp(r'^1\d{7}$');
      if (exp.hasMatch(displayname)) {
        return null;
      } else {
        return 'Invalid displayname';
      }
    },
  },
  {
    'project_scope': ProjectScope.evs2_sutd,
    'timezone': 8,
    'currency': 'SGD',
    'validate_meter_displayname': (displayname) {
      //8 digits, start with '2'
      RegExp exp = RegExp(r'^2\d{7}$');
      if (exp.hasMatch(displayname)) {
        return null;
      } else {
        return 'Invalid displayname';
      }
    },
  },
  {
    'project_scope': ProjectScope.evs2_ntu,
    'timezone': 8,
    'currency': 'SGD',
    'validate_entity_displayname': (displayname) {
      //8 digits, start with '3'
      RegExp exp = RegExp(r'^3\d{7}$');
      if (exp.hasMatch(displayname)) {
        return null;
      } else {
        return 'Invalid displayname';
      }
    },
  },
];

final the24 = [
  '10010001',
  '10010002',
  '10010003',
  '10010004',
  '10010005',
  '10010006',
  '10010007',
  '10010008',
  '10010009',
  '10010010',
  '10010011',
  '10010012',
  '10010013',
  '10010014',
  '10010015',
  '10010016',
  '10010017',
  '10010018',
  '10010019',
  '10010020',
  '10010021',
  '10010022',
  '10010023',
  '10010024',
];
