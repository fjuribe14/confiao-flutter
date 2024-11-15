import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:confiao/controllers/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:confiao/pages/auth/claim_username/claim_username.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PackageInfoController());
    AuthCtrl ctrl = Get.put(AuthCtrl(), permanent: true);

    // Set initial values
    ctrl.init();

    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: SingleChildScrollView(
        clipBehavior: Clip.hardEdge,
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        top: 16,
                        right: 16.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(100.0)),
                          child: Obx(() => Text('${ctrl.appVersion}',
                              style: const TextStyle(color: Colors.white))),
                        ),
                      ),
                      Positioned(
                        top: 16.0,
                        left: 16.0,
                        width: Responsive.width(12.0),
                        height: Responsive.width(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: SvgPicture.asset(AssetsDir.logo),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -16,
                        left: 20,
                        height: 100,
                        width: Get.width - 40,
                        child: Center(
                            child: Container(
                                decoration: BoxDecoration(
                          color: Colors.white70.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16 * 2),
                        ))),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0 * 2),
                                topRight: Radius.circular(16.0 * 2))),
                        child: Obx(() {
                          return Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  dotenv.env['APP_NAME']!,
                                  style: Get.theme.textTheme.headlineMedium
                                      ?.copyWith(
                                          color: Get.theme.primaryColor,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Center(
                                child: Text(
                                  'Inicia sesión para continuar',
                                  style: Get.theme.textTheme.titleMedium
                                      ?.copyWith(
                                          color: Get.theme.primaryColor
                                              .withOpacity(0.8)),
                                ),
                              ),
                              const SizedBox(height: 16.0 * 2),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color:
                                      Get.theme.primaryColor.withOpacity(0.1),
                                ),
                                child: TextFormField(
                                  cursorColor: Get.theme.primaryColor,
                                  controller: ctrl.usernameController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    hintText: '@gmail.com',
                                    border: InputBorder.none,
                                    label: Text('Correo electrónico'),
                                    contentPadding: EdgeInsets.all(16.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color:
                                      Get.theme.primaryColor.withOpacity(0.1),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        obscureText: !ctrl.textVisible.value,
                                        cursorColor: Get.theme.primaryColor,
                                        controller: ctrl.passwordController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: const InputDecoration(
                                          hintText: '**********',
                                          border: InputBorder.none,
                                          label: Text('Contraseña'),
                                          contentPadding: EdgeInsets.all(16.0),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        ctrl.textVisible.value =
                                            !ctrl.textVisible.value;
                                      },
                                      child: SizedBox(
                                          width: Responsive.width(16.0),
                                          height: Responsive.width(16.0),
                                          child: Icon(
                                            ctrl.textVisible.value
                                                ? Icons.visibility_off_outlined
                                                : Icons.remove_red_eye_outlined,
                                            color: Get.theme.primaryColor
                                                .withOpacity(0.5),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              ElevatedButton(
                                onPressed: () {
                                  Get.bottomSheet(
                                    const ClaimUsername(),
                                    enableDrag: true,
                                    isScrollControlled: true,
                                    backgroundColor:
                                        Get.theme.scaffoldBackgroundColor,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  padding: EdgeInsets.zero,
                                  shadowColor: Colors.transparent,
                                  overlayColor: Colors.transparent,
                                  visualDensity: VisualDensity.compact,
                                  backgroundColor: Colors.transparent,
                                ),
                                child: Text(
                                  '¿ Olvidaste la contraseña ?',
                                  style: Get.textTheme.titleSmall?.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              const Spacer(),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () async {
                                        await ctrl.login();
                                      },
                                      child: Container(
                                        height: Responsive.width(16.0),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Get.theme.primaryColor,
                                              Get.theme.colorScheme.secondary,
                                            ],
                                            end: Alignment.topRight,
                                            begin: Alignment.bottomLeft,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Ingresar',
                                            style: Get.textTheme.titleMedium
                                                ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (ctrl.biometricPermission.isTrue)
                                    const SizedBox(width: 16.0),
                                  if (ctrl.biometricPermission.isTrue)
                                    InkWell(
                                      onTap: () async =>
                                          await ctrl.loginLocalAuth(),
                                      child: Container(
                                        width: Responsive.width(16.0),
                                        height: Responsive.width(16.0),
                                        decoration: BoxDecoration(
                                          color: Get.theme.primaryColor
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Icon(
                                          Icons.fingerprint,
                                          size: Get.height * 0.035,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(AppRouteName.authRegister);
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: Responsive.width(16.0),
                                  decoration: BoxDecoration(
                                    color:
                                        Get.theme.primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Registrarse',
                                      style:
                                          Get.textTheme.titleMedium?.copyWith(
                                        color: Get.theme.primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
