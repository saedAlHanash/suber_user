class GetUrl {
  static const superUsers = 'api/services/app/InstitutionMembersService/getMembers';
  static const getPolicy = 'api/services/app/Settings/Getsettings';
  static const getReport = 'api/services/app/InstitutionAttendancesService/GetAll';
  static var buses = 'api/services/app/InstitutionBusesService/GetAll';

  static const home1 = 'api/services/app/InstitutionHomeService/Get';

}

class PostUrl {
  static const createSuperUsers = 'api/services/app/InstitutionSupervisorsService/Create';
  static const login = 'api/TokenAuth/Authenticate';
  static const checkActiveTrip = 'api/services/app/InstitutionInspectorService/BusActiveTrip';
  static const getPermissions = 'api/services/app/Role/GetUserPermissions';

  static const postSingleReport = 'api/services/app/InstitutionInspectorService/Inspect';
  static const postListReport = 'api/services/app/InstitutionAttendancesService/SyncAtendances';


}

class PutUrl {
  static const updateSuperUsers = 'api/services/app/InstitutionSupervisorsService/Update';

}

class DeleteUrl {
  static const deleteSuperUsers = 'api/services/app/InstitutionSupervisorsService/Delete';

}


// const baseUrl = '192.168.1.30:44311';
const baseUrl = 'live.qareeb-maas.com';
