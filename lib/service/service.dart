import 'package:weorganize/service/services.dart';

final UserApiService _userService = UserApiService();

class ApiService{

  static UserApiService get userService => _userService;

}
