import '../evs2up_helper.dart';

enum ProjectScope {
  EVS2_NUS,
  EVS2_SUTD,
  EVS2_NTU,
  EVS2_SMU,
  EVS2_SIT,
  EVS2_SUSS,
  NONE,
  SG_ALL,
}

enum SiteScope {
  NUS_PGPR,
  NUS_YNC,
  NUS_RVRC,
  SUTD_CAMPUS,
  NTU_MR,
  SG_ALL,
}

const evs2Projects = [
  ProjectScope.EVS2_NUS,
  ProjectScope.EVS2_SUTD,
  ProjectScope.EVS2_NTU,
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

String getProjectDisplayString(ProjectScope project) {
  switch (project) {
    case ProjectScope.EVS2_NUS:
      return 'NUS';
    case ProjectScope.EVS2_NTU:
      return 'NTU';
    case ProjectScope.EVS2_SUTD:
      return 'SUTD';
    case ProjectScope.EVS2_SMU:
      return 'SMU';
    case ProjectScope.EVS2_SIT:
      return 'SIT';
    case ProjectScope.EVS2_SUSS:
      return 'SUSS';
    case ProjectScope.NONE:
      return 'none';
    case ProjectScope.SG_ALL:
      return 'all';
  }
}

AclScope getAclProjectScope(ProjectScope? evs2project) {
  switch (evs2project) {
    case ProjectScope.SG_ALL:
      return AclScope.global;
    case ProjectScope.EVS2_NUS:
      return AclScope.evs2_nus;
    case ProjectScope.EVS2_SUTD:
      return AclScope.evs2_sutd;
    case ProjectScope.EVS2_NTU:
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
