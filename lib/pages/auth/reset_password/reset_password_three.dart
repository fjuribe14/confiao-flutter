import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:confiao/controllers/index.dart';

class ResetPasswordThree extends StatelessWidget {
  const ResetPasswordThree({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCtrl ctrl = Get.find<AuthCtrl>();

    return Obx(
      () {
        return SingleChildScrollView(
          clipBehavior: Clip.hardEdge,
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Get.theme.colorScheme.primary.withOpacity(0.5),
                      Get.theme.colorScheme.primary.withOpacity(0.2),
                    ],
                  ),
                ),
                child: SvgPicture.asset(
                  AssetsDir.authResetPassword3,
                  height: Responsive.width(80),
                  width: Responsive.width(80),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Por favor ingresa tu nueva contraseña',
                textAlign: TextAlign.center,
                style: Get.textTheme.bodyLarge,
              ),
              const SizedBox(height: 30.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: ctrl.passwordController,
                      obscureText: !ctrl.textVisible.value,
                      decoration: InputDecoration(
                        hintText: '**********',
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  IconButton(
                      onPressed: () {
                        ctrl.textVisible.value = !ctrl.textVisible.value;
                      },
                      icon: Icon(ctrl.textVisible.value
                          ? Icons.visibility_off_outlined
                          : Icons.remove_red_eye_outlined))
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: ctrl.passwordConfirmController,
                      obscureText: !ctrl.textVisibleComfirm.value,
                      decoration: InputDecoration(
                        hintText: '**********',
                        labelText: 'Confirmar contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  IconButton(
                      onPressed: () {
                        ctrl.textVisibleComfirm.value =
                            !ctrl.textVisibleComfirm.value;
                      },
                      icon: Icon(ctrl.textVisibleComfirm.value
                          ? Icons.visibility_off_outlined
                          : Icons.remove_red_eye_outlined))
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
