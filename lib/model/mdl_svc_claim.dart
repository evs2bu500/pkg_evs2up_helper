class SvcClaim {
  String? username = '';
  String? svcName = '';
  String? endpoint = '';
  String? scope = '';
  String? target = '';
  String? operation = '';

  SvcClaim(
      {this.username,
      this.svcName,
      this.endpoint,
      this.scope,
      this.target,
      this.operation});

  factory SvcClaim.fromJson(Map<String, dynamic> json) {
    return SvcClaim(
      username: json['username'],
      svcName: json['svc_name'],
      endpoint: json['endpoint'],
      scope: json['scope'],
      target: json['target'],
      operation: json['operation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'svcName': svcName,
      'endpoint': endpoint,
      'scope': scope,
      'target': target,
      'operation': operation,
    };
  }
}
