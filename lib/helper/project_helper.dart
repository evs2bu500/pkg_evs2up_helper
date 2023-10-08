import '../evs2up_helper.dart';

enum ProjectScope { NUS, SUTD, NTU, SMU, SIT, SUSS, NONE, SG_ALL }

enum SiteScope { NUS_PGPR, NUS_YNC, NUS_RVRC, SUTD_CAMPUS, NTU_MR, SG_ALL }

const evs2Projects = [
  ProjectScope.NUS,
  ProjectScope.SUTD,
  ProjectScope.NTU,
  ProjectScope.SG_ALL,
  ProjectScope.NONE,
];

// enum ProjectScope {
//   sg_global,
//   evs2_nus,
//   evs2_sutd,
//   evs2_ntu,
// }

// enum SiteScope {
//   nus_pgpr,
//   nus_ync,
//   nus_rvrc,
//   sutd_campus,
//   ntu_mr,
// }

// const List<ProjectScope> evs2Projects = [
//   ProjectScope.NUS,
//   ProjectScope.SUTD,
//   ProjectScope.NTU,
//   ProjectScope.ALL,
//   ProjectScope.NONE,
// ];

ScopeProfile? getActivePortalScopeProfile(ProjectScope activePortalProjectScope,
    List<Map<String, dynamic>> scopeProfiles) {
  for (var scopeProfile in scopeProfiles) {
    if (scopeProfile['project_scope'] == activePortalProjectScope) {
      return ScopeProfile.fromJson(scopeProfile);
    }
  }
  return null;
}

List<SiteScope> getProjectSites(
    ProjectScope? projectScope, List<Map<String, dynamic>> scopeProfiles) {
  if (projectScope == null) return [];
  for (var scopeProfile in scopeProfiles) {
    if (scopeProfile['project_scope'] == projectScope) {
      return scopeProfile['project_sites'];
    }
  }
  return [];
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

String getProjectString(ProjectScope project) {
  switch (project) {
    case ProjectScope.NUS:
      return 'evs2_nus';
    case ProjectScope.NTU:
      return 'evs2_ntu';
    case ProjectScope.SUTD:
      return 'evs2_sutd';
    case ProjectScope.SMU:
      return 'evs2_smu';
    case ProjectScope.SIT:
      return 'evs2_sit';
    case ProjectScope.SUSS:
      return 'evs2_suss';
    case ProjectScope.NONE:
      return 'none';
    case ProjectScope.SG_ALL:
      return 'global';
  }
}

AclScope getAclProjectScope(ProjectScope? evs2project) {
  switch (evs2project) {
    case ProjectScope.SG_ALL:
      return AclScope.global;
    case ProjectScope.NUS:
      return AclScope.evs2_nus;
    case ProjectScope.SUTD:
      return AclScope.evs2_sutd;
    case ProjectScope.NTU:
      return AclScope.evs2_ntu;
    default:
      return AclScope.self;
  }
}

AclScope getAclSiteScope(SiteScope? siteScope) {
  switch (siteScope) {
    case SiteScope.NUS_PGPR:
      return AclScope.site_nus_pgpr;
    case SiteScope.NUS_YNC:
      return AclScope.site_nus_ync;
    case SiteScope.NUS_RVRC:
      return AclScope.site_nus_rvrc;
    case SiteScope.SUTD_CAMPUS:
      return AclScope.site_sutd_campus;
    case SiteScope.NTU_MR:
      return AclScope.site_ntu_mr;
    default:
      return AclScope.self;
  }
}
