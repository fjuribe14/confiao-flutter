import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:confiao/controllers/index.dart';

class SetupTwo extends StatelessWidget {
  const SetupTwo({super.key});

  @override
  Widget build(BuildContext context) {
    SetupCtrl setupCtrl = Get.find<SetupCtrl>();

    return Obx(() {
      return SingleChildScrollView(
        clipBehavior: Clip.hardEdge,
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            SvgPicture.asset(
              AssetsDir.setup2,
              height: Responsive.width(60),
            ),
            Text('Necesitas cambiar tu contraseña',
                textAlign: TextAlign.center,
                style: Get.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
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
                    controller: setupCtrl.passwordController,
                    obscureText: !setupCtrl.textVisible.value,
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
                      setupCtrl.textVisible.value =
                          !setupCtrl.textVisible.value;
                    },
                    icon: Icon(setupCtrl.textVisible.value
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
                    controller: setupCtrl.passwordConfirmController,
                    obscureText: !setupCtrl.textVisibleComfirm.value,
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
                      setupCtrl.textVisibleComfirm.value =
                          !setupCtrl.textVisibleComfirm.value;
                    },
                    icon: Icon(setupCtrl.textVisibleComfirm.value
                        ? Icons.visibility_off_outlined
                        : Icons.remove_red_eye_outlined))
              ],
            ),
          ],
        ),
      );
    });
  }
}
