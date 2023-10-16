import 'mdl_acl_target_ops.dart';

enum AclScope {
  self,
  global,

  sg_all,
  project_evs2_nus,
  project_evs2_sutd,
  project_evs2_ntu,

  site_nus_pgpr,
  site_nus_ync,
  site_nus_rvrc,
  site_sutd_campus,
  site_ntu_mr,
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
  evs2user_p_password,
  evs2user_p_credit_balance,
  meter_p_reading,
  meter_p_info,
  meter_p_credit_balance,
  meter_p_month_to_date_usage,
  meter_p_bypass_policy,
  meter_p_conc,

  evs2_ops_dashboard_p_topup_history,
  evs2_ops_dashboard_p_top_kwh_rank,
  evs2_ops_dashboard_p_recent_total_topup,
  evs2_ops_dashboard_p_recent_total_kwh,
  evs2_ops_dashboard_p_recent_total_comm_data,
  evs2_ops_dashboard_p_active_count,
  evs2_ops_dashboard_p_mms_stat,
  evs2_ops_dashboard_p_kwh_history,
  evs2_ops_dashboard_p_comm_stat,
  evs2_ops_dashboard_p_active_count_history,
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
