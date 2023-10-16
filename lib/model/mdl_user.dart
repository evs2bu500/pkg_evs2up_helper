// import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

import 'mdl_acl_permission.dart';

enum UserKey {
  none,
  fullname,
  username,
  email,
  emailVerified,
  identifier,
  phone,
  password,
  confirmPassword,
  destPortal,
  enabled,
  sendVerificationEmail,
  fcmRegToken,
  address,
  projectScope,
  siteScope,
}

enum AclRole {
  Administrator,
  EVS2_Reserved_1995,
  EVS2_Reserved_1996,
  EVS2_Reserved_1997,
  EVS2_Reserved_1998,
  EVS2_Reserved_1999,
  EVS2_Reserved_2000,
  EVS2_Owner,
  EVS2_Reserved_2002,
  EVS2_Reserved_2003,
  EVS2_Reserved_2004,
  EVS2_Reserved_2005,
  EVS2_Reserved_2006,
  EVS2_Super_Admin,
  EVS2_Reserved_2008,
  EVS2_Reserved_2009,
  EVS2_Reserved_2010,
  EVS2_Admin,
  EVS2_Reserved_2012,
  EVS2_Reserved_2013,
  EVS2_Reserved_2014,
  EVS2_Sub_Admin,
  EVS2_Reserved_2016,
  EVS2_Reserved_2017,
  EVS2_Ops1,
  EVS2_Ops2,
  EVS2_Ops3,
  EVS2_Ops_Basic,
  Sl_NUS_Project_Host,
  EVS2_Reserved_2023,
  EVS2_Reserved_2024,
  EVS2_Basic_Meter_Consumer,
  EVS2_Reserved_2026,
  EVS2_Registered_User,
  EVS2_Reserved_2028,
  EVS2_Basic_User,
}

enum DestPortal {
  evs2op,
  evs2cp,
  bmsup,
  none,
}

enum PushType {
  none,
  fcm, //firebase cloud messaging
  apns, //apple push notification service
  longPolling, //long polling
}

class User {
  int? id = 0;
  String? username = '';
  String? email = '';
  bool? emailVerified = false;
  String? fullName = '';
  String? password = '';
  String? phone = '';
  int? role = 0;
  bool? enabled = false;
  bool? prefDarkMode = false;
  bool? isLoggedin = false;
  Map<String, Permission>? rolePermMap;
  int maxRank = 0;
  List<String>? roles;
  List<String>? permissions;
  String? address;
  String? fcmRegToken;
  PushType? pushType;
  String? scopeStr;
  Map<String, String>? stripeEpts;
  String? destPortal;
  List<String>? scopes;

  User({
    this.id,
    this.username,
    this.email,
    this.emailVerified,
    this.password,
    this.fullName,
    this.phone,
    this.role,
    this.enabled,
    this.prefDarkMode,
    this.rolePermMap,
    this.maxRank = 0,
    this.roles,
    this.permissions,
    this.address,
    this.fcmRegToken,
    this.pushType,
    this.scopeStr,
    this.stripeEpts,
    this.destPortal,
    this.scopes,
  });

  factory User.fromJson(Map<String, dynamic> respJson) {
    try {
      Map<String, dynamic> userJson = respJson['userInfo'];

      Map<String, dynamic> rolePermProfile = userJson['role_perm_profile'];

      Map<String, dynamic>? _rolePermMap;
      _rolePermMap = rolePermProfile['role_perm_map'];

      return User(
        id: userJson['id'],
        username: userJson['username'],
        email: userJson['email'] ?? '',
        emailVerified: userJson['email_verified'] ?? false,
        // password: userJson['password'],
        fullName: userJson['fullname'] ?? '',
        phone: userJson['contact_number'] ?? '',
        // role: userJson['role'],
        enabled: userJson['enabled'],
        // prefDarkMode: userJson['prefDarkMode'],
        rolePermMap: _rolePermMap?.map(
          (key, value) => MapEntry(
            key,
            Permission.fromJson(value),
          ),
        ),
        address: userJson['address'] ?? '',
        fcmRegToken: userJson['fcm_reg_token'] ?? '',
        scopeStr: userJson['scope_str'] ?? '',
        // paySvcUrl: userJson['pay_svc_url'] ?? {},
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return User();
    }
  }
  factory User.fromJson2(Map<String, dynamic> respJson) {
    try {
      Map<String, dynamic> userJson = respJson['userInfo'];
      List<String> roles = [...userJson['roles'].map((e) => e.toString())];
      List<String> permissions = [
        ...userJson['permissions'].map((e) => e.toString())
      ];

      //split scopeStr into scopes list with ";" as delimiter
      String scopeStrDelimiter = ';';
      List<String> scopes = [];
      if (userJson['scope_str'] != null && userJson['scope_str'] != '') {
        scopes = [...userJson['scope_str'].split(scopeStrDelimiter)];
      }

      return User(
        id: userJson['id'],
        username: userJson['username'],
        email: userJson['email'] ?? '',
        emailVerified: userJson['email_verified'] ?? false,
        // password: userJson['password'],
        fullName: userJson['fullname'] ?? '',
        phone: userJson['contact_number'] ?? '',
        // role: userJson['role'],
        enabled: userJson['enabled'],
        // prefDarkMode: userJson['prefDarkMode'],
        maxRank: userJson['max_rank'],
        roles: roles,
        permissions: permissions,
        address: userJson['address'] ?? '',
        fcmRegToken: userJson['fcm_reg_token'] ?? '',
        scopeStr: userJson['scope_str'] ?? '',
        destPortal: userJson['dest_portal'] ?? '',
        scopes: scopes,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return User();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'email_verified': emailVerified,
      'password': password,
      'fullname': fullName,
      'contact_number': phone,
      'role': role,
      'enabled': enabled,
      'pref_dark_mode': prefDarkMode,
      'role_perm_profile': rolePermMap,
      'address': address,
      'fcm_reg_token': fcmRegToken,
      'scope_str': scopeStr,
      'dest_portal': destPortal,
    };
  }

  Map<String, dynamic> toJson2() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'email_verified': emailVerified,
      'password': password,
      'fullname': fullName,
      'contact_number': phone,
      'role': role,
      'max_rank': maxRank,
      'enabled': enabled,
      'pref_dark_mode': prefDarkMode,
      'role_perm_profile': rolePermMap,
      'address': address,
      'fcm_reg_token': fcmRegToken,
      'scope_str': scopeStr,
      'dest_portal': destPortal,
    };
  }

  static List<dynamic> getKeyList() {
    return [
      'id',
      'username',
      'email',
      'email_verified',
      // 'password',
      'fullname',
      'contact_number',
      // 'role',
      'is_enabled',
    ];
  }

  List<dynamic> getValueStringList() {
    return [
      id.toString(),
      username,
      email,
      emailVerified.toString(),
      // password,
      fullName,
      phone,
      // role,
      enabled.toString(),
    ];
  }

  // bool checkPermission(AclScope scope, AclTarget target, AclOperation op) {
  //   for (var role in rolePermMap!.keys) {
  //     if (rolePermMap![role]!
  //         .checkPermission(scope.name, target.name, op.name)) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }
  bool checkPermission2(AclScope scope, AclTarget target, AclOperation op) {
    return permissions!
        .contains('${scope.name}:${target.name}:${op.name}'.toLowerCase());
  }

  // bool hasRole(AclRole role) {
  //   return rolePermMap!.containsKey(role.name);
  // }

  bool hasRole2(AclRole role) {
    //roles is a list of [{name: EVS2_Admin, rank: 55}]
    bool hasRole = roles!.any((element) => element.contains(role.name));
    // print('hasRole2: $hasRole - ${role.name}');
    return hasRole;
  }

  bool isAdminAndUp() {
    return hasRole2(AclRole.EVS2_Owner) ||
        hasRole2(AclRole.Administrator) ||
        hasRole2(AclRole.EVS2_Super_Admin) ||
        hasRole2(AclRole.EVS2_Admin);
  }

  bool useOpsDashboard() {
    return isAdminAndUp() || hasRole2(AclRole.EVS2_Ops_Basic);
  }

  bool canSeeOpsDrawer() {
    return isAdminAndUp() || hasRole2(AclRole.EVS2_Ops_Basic);
  }

  DestPortal getDestPortal() {
    switch (destPortal) {
      case 'evs2op':
        return DestPortal.evs2op;
      case 'evs2cp':
        return DestPortal.evs2cp;
      case 'bmsup':
        return DestPortal.bmsup;
      default:
        return DestPortal.none;
    }
  }

  bool isEmpty() {
    return username == '' || username == null;
  }
}
