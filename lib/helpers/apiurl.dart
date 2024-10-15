import 'package:confiao/helpers/index.dart';

class ApiUrl {
  /// api seg
  static String apiRestEndPointLogin =
      '${Environments.apiSeg}/api/v3/auth/login';
  static String apiRestEndPointActivateRegister =
      '${Environments.apiSeg}/api/v3/auth/signup';
  static String apiRestEndPointResentCodeRegister =
      '${Environments.apiSeg}/api/v3/auth/resend_code_register';
  static String apiRestEndPointPasswordResetRequest =
      '${Environments.apiSeg}/api/v3/auth/password/create';
  static String apiRestEndPointPasswordReset =
      '${Environments.apiSeg}/api/v3/auth/password/reset';
  static String apiRestEndPointPasswordResetValidate =
      '${Environments.apiSeg}/api/v3/auth/password/validate';
  static String apiRestEndPointLogout =
      '${Environments.apiSeg}/api/v3/auth/logout';
  static String apiRestEndPointUserCheckCredentials =
      '${Environments.apiSeg}/api/v3/auth/user/credenciales/check';
  static String apiRestEndPointLoginRefresh =
      '${Environments.apiSeg}/api/v3/auth/refresh-session';
  static String apiSegEndPointLoginRefreshProfile =
      '${Environments.apiSeg}/api/v3/users';
  static const String apiRestEndPointRegisterDeviceRecent =
      '${Environments.apiSeg}/api/v3/dispositivo_reciente';
  static const String apiRestEndpointDevices =
      '${Environments.apiSeg}/api/v3/dispositivo';

  /// api comunes
  static const String apiComunesTasaValor =
      '${Environments.apiComunes}/api/v1/tasa_valor';
  static const String apiComunesParticipantes =
      '${Environments.apiComunes}/api/v1/participante';
}
