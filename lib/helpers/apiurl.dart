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
  static String apiTienda = '/api/v2/public/tienda';
  static String apiFactura = '/api/v2/public/factura';
  static String apiTiendas = '/api/v2/public/mis_tiendas';
  static String apiCheckout = '/api/v2/public/confiao/checkout';

  /// Notifications
  static const String apiRestEndpointDevices = '/api/v3/dispositivo';
  static String apiRegistrarDispositivo = '/api/v2/pna/registrar_dispositivo';
  static const String apiResgistrarDispositivoReciente =
      '/api/v3/dispositivo_reciente';

  /// Confiao
  static String apiCuota = '/api/v2/cuota';
  static String apiFinanciador = '/api/v2/public/mis_financiadores';
  // static String apiFinanciador = '/api/v2/financiador';
  static String apiFinanciamiento = '/api/v2/financiamiento';
  static String apiFinanciamientoPublic = '/api/v2/public/financiamiento';
  static String apiModeloFinanciamiento =
      '/api/v2/public/modelo_financiamiento';

  /// Pagar
  static String apiClavePago = "/api/v2/servicios/pagar/clave_pago";
  static String apiCobrarCredito = "/api/v2/servicios/cobrar/credito";
  static String apiPagarPersonal = "/api/v2/servicios/pagar/personal";
  static String apiEstatusRequest = "/coremfibp/api/v2/json/bcorec/stsrqt";

  /// Comunes
  static const String apiTasaValor = '/api/v1/tasa_valor';
  static const String apiParticipantes = '/api/v1/participante';
}
