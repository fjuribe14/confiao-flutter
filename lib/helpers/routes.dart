import 'package:get/get.dart';
import 'package:confiao/pages/index.dart';

class AppRouteName {
  static const String home = '/';
  static const String login = '/login';
  static const String config = '/settings';
  static const String onboarding = '/onboarding';
  static const String authRegister = '/register';
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
    GetPage(
      name: AppRouteName.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRouteName.onboarding,
      page: () => const OnboardingPage(),
    ),
    GetPage(
      name: AppRouteName.login,
      page: () => const LoginPage(),
    ),
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
