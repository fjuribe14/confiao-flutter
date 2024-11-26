class ApiUrl {
  static String uriVersion =
      'https://confiao.sencillo.com.ve/environments/environment.json';

  /// Auth
  static String authProfile = '/api/v3/users';
  static String authLogin = '/api/v3/auth/login';
  static String authSignup = '/api/v3/auth/signup';
  static String authLogout = '/api/v3/auth/logout';
  static String authRefreshSession = '/api/v3/auth/refresh-session';
  static String authCheckCredentials = '/api/v3/auth/user/credenciales/check';

  /// Reset password
  static String authPasswordReset = '/api/v3/auth/password/reset';
  static String authPasswordCreate = '/api/v3/auth/password/create';
  static String authPasswordValidate = '/api/v3/auth/password/validate';

  /// Businness
  static String apiTienda = '/api/v1/public/tienda';
  static String apiFactura = '/api/v1/public/factura';
  static String apiTiendas = '/api/v1/public/mis_tiendas';
  static String apiCheckout = '/api/v1/public/confiao/checkout';

  /// Notifications
  static const String apiRestEndpointDevices = '/api/v3/dispositivo';
  static String apiRegistrarDispositivo = '/api/v2/pna/registrar_dispositivo';
  static const String apiResgistrarDispositivoReciente =
      '/api/v3/dispositivo_reciente';

  /// Confiao
  static String apiCuota = '/api/v1/cuota';
  static String apiFinanciador = '/api/v1/financiador';
  static String apiFinanciamiento = '/api/v1/financiamiento';
  static String apiFinanciamientoPublic = '/api/v1/public/financiamiento';
  static String apiModeloFinanciamiento =
      '/api/v1/public/modelo_financiamiento';

  /// Pagar
  static String apiClavePago = "/api/v1/servicios/pagar/clave_pago";
  static String apiCobrarCredito = "/api/v1/servicios/cobrar/credito";
  static String apiPagarPersonal = "/api/v1/servicios/pagar/personal";
  static String apiEstatusRequest = "/coremfibp/api/v1/json/bcorec/stsrqt";

  /// Comunes
  static const String apiTasaValor = '/api/v1/tasa_valor';
  static const String apiParticipantes = '/api/v1/participante';
}
