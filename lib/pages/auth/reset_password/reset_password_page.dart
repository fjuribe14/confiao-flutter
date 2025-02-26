import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthCtrl>(
      init: AuthCtrl(),
      builder: (ctrl) {
        ctrl.indexResetPassword.value = 0;
        ctrl.update();

        return Obx(() {
          return Scaffold(
            body: SafeArea(
                child: SizedBox(
              width: Get.width,
              height: Get.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: PageView(
                        onPageChanged: (index) =>
                            ctrl.indexResetPassword.value = index,
                        allowImplicitScrolling: false,
                        scrollDirection: Axis.horizontal,
                        scrollBehavior: const ScrollBehavior(),
                        controller: ctrl.pageControllerResetPassword,
                        physics: const NeverScrollableScrollPhysics(),
                        children: ctrl.pagesResetPassword,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SmoothPageIndicator(
                            count: ctrl.pagesResetPassword.length,
                            controller: ctrl.pageControllerResetPassword,
                            effect: WormEffect(
                              dotWidth: Responsive.width(2.5),
                              dotHeight: Responsive.width(1.5),
                              activeDotColor: Get.theme.colorScheme.primary,
                              dotColor: Get.theme.colorScheme.onPrimaryContainer
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          const Spacer(),

                          // Skip
                          if (ctrl.indexResetPassword.value == 0)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              onPressed: ctrl.skipResetPassword,
                              child: Text(
                                'Quizás más tarde'.tr,
                                style: TextStyle(
                                  color: Get.theme.colorScheme.primary,
                                ),
                              ),
                            ),

                          // Back
                          if (ctrl.indexResetPassword.value >= 1)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              onPressed: ctrl.backResetPassword,
                              child: Text(
                                'Volver'.tr,
                                style: TextStyle(
                                  color: Get.theme.colorScheme.primary,
                                ),
                              ),
                            ),

                          if (ctrl.indexResetPassword.value > 1)
                            const SizedBox(width: 24),

                          // Next
                          if (ctrl.indexResetPassword.value != 1)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Get.theme.colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: ctrl.nextResetPassword,
                              child: Icon(
                                Icons.arrow_forward_outlined,
                                color: Get.theme.colorScheme.onPrimary,
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
                //   Column(
                //     children: [
                //       Container(
                //         padding: const EdgeInsets.all(20.0),
                //         margin: const EdgeInsets.symmetric(horizontal: 20.0),
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(20),
                //             gradient: LinearGradient(
                //                 begin: Alignment.topLeft,
                //                 end: Alignment.bottomRight,
                //                 colors: [
                //                   Get.theme.colorScheme.primary.withValues(alpha:0.5),
                //                   Get.theme.colorScheme.primary.withValues(alpha:0.2),
                //                 ])),
                //         child: SvgPicture.asset(
                //           AssetsDir.authResetPassword1,
                //           height: Responsive.width(80),
                //           width: Responsive.width(80),
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(20.0),
                //         child: Text.rich(
                //           textAlign: TextAlign.center,
                //           TextSpan(
                //             children: [
                //               TextSpan(
                //                 text: 'Por favor ingresa el correo ',
                //                 style: Get.textTheme.titleMedium,
                //               ),
                //               TextSpan(
                //                 text: '${ctrl.currentUser?.email}',
                //                 style: Get.textTheme.titleMedium?.copyWith(
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //               TextSpan(
                //                 text: ' para restablecer tu contraseña.',
                //                 style: Get.textTheme.titleMedium,
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // bottomNavigationBar: BottomAppBar(
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: ElevatedButton(
                //             onPressed: () async {
                //               await ctrl.resetPasswordStepOne();
                //             },
                //             child: const Text('Enviar')),
                //       )
                //     ],
                //   ),
                // ),
                ),
          );
        });
      },
    );
  }
}
