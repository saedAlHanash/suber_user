class GetUrl {

  static const superUsers = 'api/services/app/InstitutionMembersService/getNewMemberPatch';
  static const getPolicy = 'api/services/app/Settings/Getsettings';
  static const getReport = 'api/services/app/InstitutionAttendancesService/GetAll';

  static const home1 = 'api/services/app/InstitutionHomeService/Get';

  static const buses = 'api/services/app/InstitutionBusesService/GetAll';
}

class PostUrl {
  static const createSuperUsers = 'api/services/app/InstitutionSupervisorsService/Create';
  static const loginUrl = 'api/services/app/InstitutionSupervisorsService/Authenticate';

  static const postSingleReport =
      'api/services/app/InstitutionSupervisorCheckService/recordCheck';
  static const postListReport =
      'api/services/app/InstitutionSupervisorCheckService/syncChecks';
}

class PutUrl {
  static const updateSuperUsers = 'api/services/app/InstitutionSupervisorsService/Update';
}

class DeleteUrl {
  static const deleteSuperUsers = 'api/services/app/InstitutionSupervisorsService/Delete';
}

String get baseUrl {
  // return testUrl;
  return liveUrl;
}

const liveUrl = 'live.qareeb-maas.com';
const testUrl = 'qareeb-api.first-pioneers.com.tr';
