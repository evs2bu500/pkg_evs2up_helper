enum Evs2HistoryType {
  meter_reading,
  meter_reading_daily,
  active_meter_count_history,
  active_kwh_consumption_history,
  total_topup_history,
  top_kwh_consumption_by_building,
  // tariff,
  meter_tariff,
  transaction_log
}

class Evs2HistoryModel {
  List<Map<String, dynamic>> history = [];
  Map<String, dynamic> historyMeta = {};
}
