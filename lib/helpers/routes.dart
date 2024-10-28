import 'package:get/get.dart';
import 'package:confiao/pages/index.dart';

class AppRouteName {
  // Initial
  static const String home = '/';
  static const String setup = '/setup';
  static const String onboarding = '/onboarding';

  // Auth
  static const String authLogin = '/login';
  static const String authRegister = '/register';
  static const String authResetPassword = '/authResetPassword';

  // Protected
  static const String config = '/settings';
  static const String shoppingCart = '/shoppingCart';
  static const String tiendaDetail = '/tiendaDetail';
  static const String productoDetail = '/productoDetail';
  static const String cobroServicioList = '/cobroServicioList';
  static const String notificationsList = '/notificationsList';
  static const String financiamientoList = '/financiamientoList';
  static const String notificationsDetail = '/notificationsDetail';
  static const String financiamientoDetail = '/financiamientoDetail';
}

class AppRoutes {
  static final pages = [
    /** Initial */
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
      name: AppRouteName.authLogin,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRouteName.authRegister,
      page: () => const RegisterPage(),
    ),
    GetPage(
      name: AppRouteName.authResetPassword,
      page: () => const ResetPasswordPage(),
    ),

    /** Protected */
    GetPage(
      name: AppRouteName.home,
      page: () => const HomeLayoutPage(),
    ),
    GetPage(
      name: AppRouteName.tiendaDetail,
      page: () => const TiendaDetail(),
    ),
    GetPage(
      name: AppRouteName.productoDetail,
      page: () => const ProductoDetail(),
    ),
    GetPage(
      name: AppRouteName.shoppingCart,
      page: () => const ShoppingCartPage(),
    ),
    GetPage(
      name: AppRouteName.notificationsList,
      page: () => const NotificationsList(),
    ),
    GetPage(
      name: AppRouteName.cobroServicioList,
      page: () => const CobroServicioList(),
    ),
    GetPage(
      name: AppRouteName.financiamientoList,
      page: () => const FinanciamientoList(),
    ),
    GetPage(
      name: AppRouteName.notificationsDetail,
      page: () => const NotificationsDetail(),
    ),
    GetPage(
      name: '${AppRouteName.financiamientoDetail}/:id',
      page: () => const FinanciamientoDetail(),
    ),
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
