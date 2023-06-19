import 'mdl_acl_target_ops.dart';

enum AclScope {
  self,
  global,
}

enum AclTarget {
  meter,
  meter_info,
  meter_rls,
  meter_comm,
  evs2user,
  evs2_acl_role,
  evs2_acl_permission,
  meter_last_reading,
  meter_kwh_history,
  meter_reading_daily,
  evs2user_profile,
  credit_balance,
  meter_month_to_date_usage,
  meter_consumer_transaction_history,
  meter_consumer_tariff_history,
  evs2_acl_role_p_profile,
  evs2_acl_role_p_permission,
  evs2user_p_role,
  evs2user_p_profile,
  meter_p_reading,
  meter_p_info,
  meter_p_credit_balance,
  meter_p_month_to_date_usage,
}

enum AclOperation {
  create,
  read,
  update,
  delete,
  list,
  full,
}

//scope target ops
class Permission {
  Map<String, TargetOps> permissions;

  Permission({required this.permissions});

  factory Permission.fromJson(Map<String, dynamic> json) {
    Map<String, TargetOps> permissions = {};
    json.forEach((key, value) {
      permissions[key] = TargetOps.fromJson(value);
    });

    return Permission(permissions: permissions);
  }

  Map<String, dynamic> toJson() {
    return permissions;
  }

  bool checkPermission(String xScope, String xTarget, String xOp) {
    if (permissions.containsKey(xScope)) {
      TargetOps targetOps = permissions[xScope]!;
      if (targetOps.targetOps.containsKey(xTarget)) {
        List<String> ops = targetOps.targetOps[xTarget]!;
        if (ops.contains(xOp)) {
          return true;
        }
      }
    }

    return false;
  }
}
