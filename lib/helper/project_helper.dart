import '../enum/enum_item.dart';
import '../evs2up_helper.dart';

enum ProjectScope {
  EVS2_PA,
  EVS2_NUS,
  EVS2_SUTD,
  EVS2_NTU,
  EVS2_SMU,
  EVS2_SIT,
  EVS2_SUSS,
  NONE,
  SG_ALL,
  GLOBAL,
  EMS_SMRT,
  EMS_CW_NUS,
}

enum SiteScope {
  PA_ATP,
  NUS_PGPR,
  NUS_YNC,
  NUS_RVRC,
  NUS_UTOWN,
  SUTD_CAMPUS,
  NTU_MR,
  NONE,
  SG_ALL,
  GLOBAL,
  SMRT_Clementi,
  SMRT_Dover,
  SMRT_Buona_Vista,
  SMRT_Commonwealth,
  SMRT_Queenstown,

  CW_NUS_KRC,
  CW_NUS_BTC,
  CW_NUS_UTOWN,
}

const evs2Projects = [
  ProjectScope.EVS2_NUS,
  ProjectScope.EVS2_SUTD,
  ProjectScope.EVS2_NTU,
  ProjectScope.EVS2_PA,
  ProjectScope.SG_ALL,
  ProjectScope.NONE,
];
const emsProjects = [
  ProjectScope.EMS_SMRT,
  ProjectScope.EMS_CW_NUS,
  ProjectScope.NONE,
];

const evs2Sites = [
  SiteScope.NUS_PGPR,
  SiteScope.NUS_YNC,
  SiteScope.NUS_RVRC,
  SiteScope.NUS_UTOWN,
  SiteScope.SUTD_CAMPUS,
  SiteScope.NTU_MR,
  SiteScope.SG_ALL,
  SiteScope.PA_ATP,
  SiteScope.NONE,
];

const emsSites = [
  SiteScope.SMRT_Clementi,
  SiteScope.SMRT_Dover,
  SiteScope.SMRT_Buona_Vista,
  SiteScope.SMRT_Commonwealth,
  SiteScope.SMRT_Queenstown,
  SiteScope.SG_ALL,
  SiteScope.NONE,
];

const cwNusSites = [
  SiteScope.CW_NUS_KRC,
  SiteScope.CW_NUS_BTC,
  SiteScope.CW_NUS_UTOWN,
  SiteScope.SG_ALL,
  SiteScope.NONE,
];

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
      projectScopes.add(getProjectScopeFromStr2(scope));
    } else if (scope.contains('site_')) {
      siteScopes.add(getSiteScopeFromStr2(scope));
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

ProjectScope getProjectScopeFromStr2(String scopeStr) {
  for (ProjectScope projectScope in ProjectScope.values) {
    if (scopeStr.toLowerCase().contains(projectScope.name.toLowerCase())) {
      return projectScope;
    }
  }
  return ProjectScope.NONE;
}

SiteScope getSiteScopeFromStr2(String scopeStr) {
  for (SiteScope siteScope in SiteScope.values) {
    // if (scopeStr.toLowerCase().contains(siteScope.name.toLowerCase())) {
    if (scopeStr.toLowerCase() == 'site_${siteScope.name.toLowerCase()}') {
      return siteScope;
    }
  }
  return SiteScope.NONE;
}

List<SiteScope> getProjectSites(
    ProjectScope? projectScope, List<Map<String, dynamic>> scopeProfiles) {
  if (projectScope == null) return [];
  for (var scopeProfile in scopeProfiles) {
    if (scopeProfile['project_scope'] == projectScope) {
      List<SiteScope> projectSites = [];
      if (scopeProfile['project_sites'] != null) {
        for (var site in scopeProfile['project_sites']) {
          if (site is SiteScope) {
            projectSites.add(site);
          } else {
            projectSites.add(site['key']);
          }
        }
      }
      return projectSites;
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
  if (scopeStr.contains('pa')) {
    return 'evs2_pa';
  }
  return 'none';
}

String? getSiteDisplayString(SiteScope? site) {
  if (site == null) return null;
  switch (site) {
    case SiteScope.PA_ATP:
      return 'ATP';
    case SiteScope.NUS_PGPR:
      return 'PGPR';
    case SiteScope.NUS_YNC:
      return 'YNC';
    case SiteScope.NUS_RVRC:
      return 'RVRC';
    case SiteScope.NUS_UTOWN:
      return 'UTown';
    case SiteScope.SUTD_CAMPUS:
      return 'SUTD';
    case SiteScope.NTU_MR:
      return 'MR';
    case SiteScope.SMRT_Clementi:
      return 'Clementi';
    case SiteScope.SMRT_Dover:
      return 'Dover';
    case SiteScope.SMRT_Buona_Vista:
      return 'Buona Vista';
    case SiteScope.SMRT_Commonwealth:
      return 'Commonwealth';
    case SiteScope.SMRT_Queenstown:
      return 'Queenstown';
    case SiteScope.CW_NUS_KRC:
      return 'KRC';
    case SiteScope.CW_NUS_BTC:
      return 'BTC';
    case SiteScope.CW_NUS_UTOWN:
      return 'UTown';
    default:
      return 'NONE';
  }
}

SiteScope? getSiteScopeFromStr(String? scopeStr) {
  if (scopeStr == null || scopeStr.isEmpty) return null;

  String scopeStrLower = scopeStr.toLowerCase();
  if (scopeStrLower.contains('site_')) {
    scopeStrLower = scopeStrLower.replaceAll('site_', '');
  }
  switch (scopeStrLower.toUpperCase()) {
    case 'PA_ATP':
      return SiteScope.PA_ATP;
    case 'NUS_PGPR':
      return SiteScope.NUS_PGPR;
    case 'NUS_YNC':
      return SiteScope.NUS_YNC;
    case 'NUS_RVRC':
      return SiteScope.NUS_RVRC;
    case 'NUS_UTOWN':
      return SiteScope.NUS_UTOWN;
    case 'SUTD_CAMPUS':
      return SiteScope.SUTD_CAMPUS;
    case 'NTU_MR':
      return SiteScope.NTU_MR;
    case 'SMRT_Clementi':
      return SiteScope.SMRT_Clementi;
    case 'SMRT_Dover':
      return SiteScope.SMRT_Dover;
    case 'SMRT_Buona_Vista':
      return SiteScope.SMRT_Buona_Vista;
    case 'SMRT_Commonwealth':
      return SiteScope.SMRT_Commonwealth;
    case 'SMRT_Queenstown':
      return SiteScope.SMRT_Queenstown;
    case 'CW_NUS_KRC':
      return SiteScope.CW_NUS_KRC;
    case 'CW_NUS_BTC':
      return SiteScope.CW_NUS_BTC;
    case 'CW_NUS_UTOWN':
      return SiteScope.CW_NUS_UTOWN;
    default:
      return SiteScope.NONE;
  }
}

String getProjectDisplayString(ProjectScope project) {
  switch (project) {
    case ProjectScope.EVS2_PA:
      return 'PA';
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
    case ProjectScope.EMS_SMRT:
      return 'EMS_SMRT';
    case ProjectScope.EMS_CW_NUS:
      return 'EMS_CW_NUS';
  }
}

ItemType getProjectMeterType(ProjectScope project) {
  switch (project) {
    case ProjectScope.EVS2_PA:
      return ItemType.meter;
    case ProjectScope.EVS2_NUS:
      return ItemType.meter;
    case ProjectScope.EVS2_NTU:
      return ItemType.meter;
    case ProjectScope.EVS2_SUTD:
      return ItemType.meter;
    case ProjectScope.EVS2_SMU:
      return ItemType.meter;
    case ProjectScope.EVS2_SIT:
      return ItemType.meter;
    case ProjectScope.EVS2_SUSS:
      return ItemType.meter;
    case ProjectScope.NONE:
      return ItemType.meter;
    case ProjectScope.SG_ALL:
      return ItemType.meter;
    case ProjectScope.GLOBAL:
      return ItemType.meter;
    case ProjectScope.EMS_SMRT:
      return ItemType.meter_3p;
    case ProjectScope.EMS_CW_NUS:
      return ItemType.meter_iwow;
  }
}

AclScope getAclProjectScope(ProjectScope? evs2project) {
  switch (evs2project) {
    case ProjectScope.EVS2_PA:
      return AclScope.project_evs2_pa;
    case ProjectScope.SG_ALL:
      return AclScope.global;
    case ProjectScope.EVS2_NUS:
      return AclScope.project_evs2_nus;
    case ProjectScope.EVS2_SUTD:
      return AclScope.project_evs2_sutd;
    case ProjectScope.EVS2_NTU:
      return AclScope.project_evs2_ntu;
    case ProjectScope.EMS_SMRT:
      return AclScope.project_ems_smrt;
    case ProjectScope.EMS_CW_NUS:
      return AclScope.project_ems_cw_nus;
    default:
      return AclScope.self;
  }
}

AclScope getAclSiteScope(SiteScope? siteScope) {
  switch (siteScope) {
    case SiteScope.PA_ATP:
      return AclScope.site_pa_atp;
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
    case SiteScope.SMRT_Clementi:
      return AclScope.site_smrt_clementi;
    case SiteScope.SMRT_Dover:
      return AclScope.site_smrt_dover;
    case SiteScope.SMRT_Buona_Vista:
      return AclScope.site_smrt_buona_vista;
    case SiteScope.SMRT_Commonwealth:
      return AclScope.site_smrt_commonwealth;
    case SiteScope.SMRT_Queenstown:
      return AclScope.site_smrt_queenstown;
    default:
      return AclScope.self;
  }
}
