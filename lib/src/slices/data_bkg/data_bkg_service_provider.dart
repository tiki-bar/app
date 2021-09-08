import '../api_auth_service/model/api_auth_service_account_model.dart';

abstract class DataBkgServiceProvInterface {
  ApiAuthServiceAccountModel get account;

  String? get displayName;

  logIn();

  logOut();

  isConnected();
}
