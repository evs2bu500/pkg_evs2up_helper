import '../helper/tenant_def.dart';

class Tenant {
  int? id;
  String? tenantLabel;
  String? tenantName;
  TenantType? tenantType;
  String? createdTimeStr;

  Tenant({
    this.id = 0,
    this.tenantLabel,
    this.tenantName,
    this.tenantType,
    this.createdTimeStr,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) {
    return Tenant(
      id: int.tryParse(json['id']) ?? -1,
      tenantLabel: json['tenant_label'] ?? '',
      tenantName: json['tenant_name'] ?? '',
      tenantType: TenantType.values.byName(json['type'] ?? ''),
      createdTimeStr: json['created_timestamp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tenant_label': tenantLabel,
      'tenant_name': tenantName,
      'tenant_type': tenantType?.name,
      'created_timestamp': createdTimeStr,
    };
  }
}
