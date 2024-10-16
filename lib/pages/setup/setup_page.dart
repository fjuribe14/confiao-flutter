import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetupCtrl>(
        init: SetupCtrl(),
        builder: (ctrl) => Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: PageView(
                        allowImplicitScrolling: false,
                        controller: ctrl.pageController,
                        scrollDirection: Axis.horizontal,
                        scrollBehavior: const ScrollBehavior(),
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (index) => ctrl.index.value = index,
                        children: ctrl.pages,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SmoothPageIndicator(
                          count: ctrl.pages.length,
                          controller: ctrl.pageController,
                          effect: WormEffect(
                            dotWidth: Responsive.width(2.5),
                            dotHeight: Responsive.width(1.5),
                            activeDotColor: Get.theme.primaryColor,
                            dotColor: Get.theme.colorScheme.secondaryFixedDim,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            ctrl.pageController.nextPage(
                              curve: Curves.easeInOut,
                              duration: const Duration(milliseconds: 300),
                            );
                          },
                          child: const Text('Proximo'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            ctrl.pageController.nextPage(
                              curve: Curves.easeInOut,
                              duration: const Duration(milliseconds: 300),
                            );
                          },
                          child: const Text('Proximo'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
