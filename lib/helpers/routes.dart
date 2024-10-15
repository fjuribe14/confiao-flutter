import 'package:get/get.dart';
import 'package:confiao/pages/index.dart';

class AppRouteName {
  // Initial
  static const String home = '/';
  static const String setup = '/setup';
  static const String onboarding = '/onboarding';

  // Auth
  static const String login = '/login';
  static const String authRegister = '/register';

  // Protected
  static const String config = '/settings';
  static const String socketPage = '/socketPage';
  static const String cuentaForm = '/cuentaForm';
  static const String payQuickPage = '/payQuickPage';
  static const String checkoutPage = '/checkoutPage';
  static const String authRegisterCode = '/register_code';
  static const String bpayPaymentPage = '/bpayPaymentPage';
  static const String authPasswordReset = '/password_reset';
  static const String permissionDevice = '/permissionDevice';
}

class AppRoutes {
  static final pages = [
    /** Initial */
    GetPage(
      name: AppRouteName.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRouteName.setup,
      page: () => const SetupPage(),
    ),
    GetPage(
      name: AppRouteName.onboarding,
      page: () => const OnboardingPage(),
    ),

    /** Auth */
    GetPage(
      name: AppRouteName.login,
      page: () => const LoginPage(),
    ),

    /** Protected */
    // GetPage(
    //   name: AppRouteName.config,
    //   page: () => const ConfigPage(),
    // ),
    // GetPage(
    //   name: AppRouteName.checkoutPage,
    //   page: () => const CheckoutPage(),
    // ),
    // GetPage(
    //   name: AppRouteName.cuentaForm,
    //   page: () => const CuentaForm(),
    // ),
  ];
}
