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
  //acl v1
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

  //acl v2
  meter_p_entity,
  meter_p_reading,
  meter_p_info,
  meter_p_rls,
  meter_p_credit_balance,
  meter_p_month_to_date_kwh_usage,
  meter_p_bypass_policy,
  meter_p_conc,
  meter_p_kiv,
  meter_p_tariff,
  meter_p_reading_daily,
  meter_p_daily_reading_history_full,
  meter_p_last_reading,
  meter_p_comm_status,

  evs2user_p_entity,
  evs2user_p_role,
  evs2user_p_profile,
  evs2user_p_password,
  evs2user_p_credit_balance,
  evs2user_p_topup_history_3months,
  evs2user_p_transaction_history_3months,

  evs2_acl_role_p_entity,
  evs2_acl_scope_p_entity,

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