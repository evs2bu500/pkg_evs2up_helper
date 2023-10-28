enum Evs2HistoryType {
  meter_reading,
  meter_reading_daily,
  active_meter_count_history,
  active_kwh_consumption_history,
  total_topup_history,
  top_kwh_consumption_by_building,
  // tariff,
  meter_tariff,
  transaction_log,
  meter_reading_3p,
  meter_reading_3p_daily,
}

class Evs2HistoryModel {
  List<Map<String, dynamic>> history = [];
  Map<String, dynamic> historyMeta = {};
}
