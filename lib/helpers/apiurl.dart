import 'package:confiao/helpers/index.dart';

class ApiUrl {
  /// Auth
  static String authLogin = '/api/v3/auth/login';
  static String authSignup = '/api/v3/auth/signup';
  static String authLogout = '/api/v3/auth/logout';
  static String authCheckCredentials = '/api/v3/auth/user/credenciales/check';

  /// Reset password
  // Step 1
  static String authPasswordCreate = '/api/v3/auth/password/create';
  // Step 2
  static String authPasswordValidate = '/api/v3/auth/password/validate';
  // Step 3
  static String authPasswordReset = '/api/v3/auth/password/reset';

  /// Businness
  static String apiTienda = '/api/v1/public/tienda';

  /// Confiao
  static String apiCuota = '/api/v1/cuota';
  static String apiFinanciador = '/api/v1/financiador';
  static String apiFinanciamiento = '/api/v1/financiamiento';

  /// Notifications
  static String apiRegistrarDispositivo = '/api/v2/pna/registrar_dispositivo';

  static String apiRestEndPointActivateRegister =
      '${Environments.apiSeg}/api/v3/auth/signup';
  static String apiRestEndPointResentCodeRegister =
      '${Environments.apiSeg}/api/v3/auth/resend_code_register';
  static String apiRestEndPointPasswordReset =
      '${Environments.apiSeg}/api/v3/auth/password/reset';
  static String apiRestEndPointPasswordResetValidate =
      '${Environments.apiSeg}/api/v3/auth/password/validate';
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
