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
  GLOBAL,
}

enum SiteScope {
  NUS_PGPR,
  NUS_YNC,
  NUS_RVRC,
  SUTD_CAMPUS,
  NTU_MR,
  NONE,
  SG_ALL,
  GLOBAL,
}

const evs2Projects = [
  ProjectScope.EVS2_NUS,
  ProjectScope.EVS2_SUTD,
  ProjectScope.EVS2_NTU,
  ProjectScope.SG_ALL,
  ProjectScope.NONE,
];
const evs2Sites = [
  SiteScope.NUS_PGPR,
  SiteScope.NUS_YNC,
  SiteScope.NUS_RVRC,
  SiteScope.SUTD_CAMPUS,
  SiteScope.NTU_MR,
  SiteScope.SG_ALL,
  SiteScope.NONE,
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

// get list of scopes and sort them into project and site scopes
// the scope strings must be in the format of
// "project_nus" or "site_nus_pgpr"
Map<String, dynamic> getSortedScope(List<String>? scopes) {
  if (scopes == null || scopes.isEmpty) {
    return {
      'project_scopes': [],
      'site_scopes': [],
    };
  }

  List<ProjectScope> projectScopes = [];
  List<SiteScope> siteScopes = [];

  for (var scope in scopes) {
    if (scope.toLowerCase().contains('global')) {
      projectScopes.add(ProjectScope.GLOBAL);
      siteScopes.add(SiteScope.GLOBAL);
      break;
    } else if (scope.toLowerCase().contains('sg_all')) {
      projectScopes.add(ProjectScope.SG_ALL);
      siteScopes.add(SiteScope.SG_ALL);
      break;
    }

    if (scope.contains('project_')) {
      projectScopes.add(getProjectScopeFromStr(scope));
    } else if (scope.contains('site_')) {
      siteScopes.add(getSiteScopeFromStr(scope));
    }
  }
  // if project scope is global or sg_all,
  // add all projects and sites
  // filter out NONE
  if (projectScopes.contains(ProjectScope.GLOBAL) ||
      projectScopes.contains(ProjectScope.SG_ALL)) {
    projectScopes = [];
    projectScopes.addAll(evs2Projects.where((e) =>
        e != ProjectScope.NONE &&
        e != ProjectScope.GLOBAL &&
        e != ProjectScope.SG_ALL));
    //sort alphabetically
    projectScopes.sort((a, b) => a.toString().compareTo(b.toString()));
    //add sg_all to the firt position
    projectScopes.insert(0, ProjectScope.SG_ALL);

    siteScopes = [];
    siteScopes.addAll(evs2Sites.where((e) =>
        e != SiteScope.NONE && e != SiteScope.GLOBAL && e != SiteScope.SG_ALL));
    //sort alphabetically
    siteScopes.sort((a, b) => a.toString().compareTo(b.toString()));
    //add sg_all to the firt position
    // siteScopes.insert(0, SiteScope.SG_ALL);
  }

  return {
    'project_scopes': projectScopes,
    'site_scopes': siteScopes,
  };
}

ProjectScope getProjectScopeFromStr(String scopeStr) {
  if (scopeStr.toLowerCase().contains(ProjectScope.GLOBAL.name.toLowerCase())) {
    return ProjectScope.GLOBAL;
  }
  if (scopeStr.toLowerCase().contains(ProjectScope.SG_ALL.name.toLowerCase())) {
    return ProjectScope.SG_ALL;
  }
  if (scopeStr
      .toLowerCase()
      .contains(ProjectScope.EVS2_NUS.name.toLowerCase())) {
    return ProjectScope.EVS2_NUS;
  }
  if (scopeStr
      .toLowerCase()
      .contains(ProjectScope.EVS2_SUTD.name.toLowerCase())) {
    return ProjectScope.EVS2_SUTD;
  }
  if (scopeStr
      .toLowerCase()
      .contains(ProjectScope.EVS2_NTU.name.toLowerCase())) {
    return ProjectScope.EVS2_NTU;
  }
  if (scopeStr
      .toLowerCase()
      .contains(ProjectScope.EVS2_SMU.name.toLowerCase())) {
    return ProjectScope.EVS2_SMU;
  }
  if (scopeStr
      .toLowerCase()
      .contains(ProjectScope.EVS2_SIT.name.toLowerCase())) {
    return ProjectScope.EVS2_SIT;
  }
  if (scopeStr
      .toLowerCase()
      .contains(ProjectScope.EVS2_SUSS.name.toLowerCase())) {
    return ProjectScope.EVS2_SUSS;
  }
  return ProjectScope.NONE;
}

SiteScope getSiteScopeFromStr(String scopeStr) {
  if (scopeStr.toLowerCase().contains(SiteScope.GLOBAL.name.toLowerCase())) {
    return SiteScope.GLOBAL;
  }
  if (scopeStr.toLowerCase().contains(SiteScope.SG_ALL.name.toLowerCase())) {
    return SiteScope.SG_ALL;
  }
  if (scopeStr.toLowerCase().contains(SiteScope.NUS_PGPR.name.toLowerCase())) {
    return SiteScope.NUS_PGPR;
  }
  if (scopeStr.toLowerCase().contains(SiteScope.NUS_YNC.name.toLowerCase())) {
    return SiteScope.NUS_YNC;
  }
  if (scopeStr.toLowerCase().contains(SiteScope.NUS_RVRC.name.toLowerCase())) {
    return SiteScope.NUS_RVRC;
  }
  if (scopeStr
      .toLowerCase()
      .contains(SiteScope.SUTD_CAMPUS.name.toLowerCase())) {
    return SiteScope.SUTD_CAMPUS;
  }
  if (scopeStr.toLowerCase().contains(SiteScope.NTU_MR.name.toLowerCase())) {
    return SiteScope.NTU_MR;
  }
  return SiteScope.NONE;
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
      return 'NONE';
    case ProjectScope.SG_ALL:
      return 'SG_ALL';
    case ProjectScope.GLOBAL:
      return 'GLOBAL';
  }
}

AclScope getAclProjectScope(ProjectScope? evs2project) {
  switch (evs2project) {
    case ProjectScope.SG_ALL:
      return AclScope.global;
    case ProjectScope.EVS2_NUS:
      return AclScope.project_evs2_nus;
    case ProjectScope.EVS2_SUTD:
      return AclScope.project_evs2_sutd;
    case ProjectScope.EVS2_NTU:
      return AclScope.project_evs2_ntu;
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