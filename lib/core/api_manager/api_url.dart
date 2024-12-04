class GetUrl {
  static var superUsers = 'api/services/app/InstitutionMembersService/getNewMemberPatch';
  static const getPolicy = 'api/services/app/Settings/Getsettings';
  static const getReport = 'api/services/app/InstitutionAttendancesService/GetAll';

  static var home1 = 'api/services/app/InstitutionHomeService/Get';
}

class PostUrl {
  static var createSuperUsers = 'api/services/app/InstitutionSupervisorsService/Create';
  static const loginUrl = 'api/services/app/InstitutionSupervisorsService/Authenticate';

  static const postSingleReport =
      'api/services/app/InstitutionAttendancesService/AddAtendance';
  static const postListReport =
      'api/services/app/InstitutionAttendancesService/SyncAtendances';
}

class PutUrl {
  static var updateSuperUsers = 'api/services/app/InstitutionSupervisorsService/Update';
}

class DeleteUrl {
  static var deleteSuperUsers = 'api/services/app/InstitutionSupervisorsService/Delete';
}

String get baseUrl {
  // return testUrl;
  return liveUrl;
}

const liveUrl = '185.84.236.62';
const testUrl = 'qareeb-api.first-pioneers.com.tr';
