import '../.app_setting.dart';
import '../evs2up_helper.dart';

const List<Evs2Project> evs2Projects = [
  Evs2Project.NUS,
  Evs2Project.SUTD,
  Evs2Project.NTU,
  Evs2Project.ALL,
  Evs2Project.NONE,
];

String getProjectString(Evs2Project project) {
  switch (project) {
    case Evs2Project.NUS:
      return 'evs2_nus';
    case Evs2Project.NTU:
      return 'evs2_ntu';
    case Evs2Project.SUTD:
      return 'evs2_sutd';
    case Evs2Project.SMU:
      return 'evs2_smu';
    case Evs2Project.SIT:
      return 'evs2_sit';
    case Evs2Project.SUSS:
      return 'evs2_suss';
    case Evs2Project.NONE:
      return 'none';
    case Evs2Project.ALL:
      return 'global';
  }
}

ScopeProfile? getActiveScopeProfile(String activeScope) {
  for (var scopeProfile in scopeProfile) {
    if ((scopeProfile['project_scope'] as ProjectScope).name == activeScope) {
      return ScopeProfile.fromJson(scopeProfile);
    }
  }
  return null;
}

ScopeProfile? getUserScopeProfile(User user) {
  String scopeStr = user.scopeStr ?? '';
  if (scopeStr.isEmpty) {
    return null;
  }
  String projectScopeStr = getProjectScopeStrFromScopeStr(scopeStr);
  if (projectScopeStr.isEmpty) {
    return null;
  }
  for (var scopeProfile in scopeProfile) {
    if ((scopeProfile['project_scope'] as ProjectScope).name ==
        projectScopeStr) {
      return ScopeProfile.fromJson(scopeProfile);
    }
  }
  return null;
}

String getProjectScopeStrFromScopeStr(String scopeStr) {
  if (scopeStr.contains('nus')) {
    return 'evs2_nus';
  }
  if (scopeStr.contains('ntu')) {
    return 'evs2_ntu';
  }
  if (scopeStr.contains('sutd')) {
    return 'evs2_sutd';
  }
  return 'none';
}

AclScope getAclScope(Evs2Project evs2project) {
  switch (evs2project) {
    case Evs2Project.ALL:
      return AclScope.global;
    case Evs2Project.NUS:
      return AclScope.evs2_nus;
    case Evs2Project.SUTD:
      return AclScope.evs2_sutd;
    case Evs2Project.NTU:
      return AclScope.evs2_ntu;
    default:
      return AclScope.self;
  }
}
