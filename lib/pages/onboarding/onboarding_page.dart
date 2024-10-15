import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:confiao/controllers/onboarding/onboarding_ctrl.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingCtrl>(
      init: OnboardingCtrl(),
      builder: (ctrl) => Scaffold(
        body: SafeArea(
          child: Obx(() {
            if (ctrl.loading.isTrue && ctrl.viewed.isTrue) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  height: Responsive.width(20),
                ),
                Expanded(
                  flex: 1,
                  child: PageView.builder(
                    controller: ctrl.pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: ctrl.onboardingItems.length,
                    itemBuilder: (context, index) =>
                        ctrl.onboardingItems[index],
                    onPageChanged: (index) => ctrl.index.value = index,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SmoothPageIndicator(
                        controller: ctrl.pageController,
                        count: ctrl.onboardingItems.length,
                        effect: WormEffect(
                          dotWidth: Responsive.width(2.5),
                          dotHeight: Responsive.width(1.5),
                          activeDotColor: Get.theme.primaryColor,
                          dotColor: Get.theme.colorScheme.secondaryFixedDim,
                        ),
                      ),
                      const Spacer(),

                      // Skip
                      if (ctrl.index.value >= 1)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: ctrl.skip,
                          child: Text(
                            'Omitir'.tr,
                            style: TextStyle(
                              color: Get.theme.colorScheme.secondary,
                            ),
                          ),
                        ),

                      const SizedBox(width: 24),

                      // Next
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Get.theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: ctrl.next,
                        child: Icon(
                          Icons.arrow_forward_outlined,
                          color: Get.theme.colorScheme.onPrimary,
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
