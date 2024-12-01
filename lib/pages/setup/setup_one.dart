import 'package:confiao/helpers/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/controllers/auth/auth_ctrl.dart';
import 'package:confiao/controllers/setup/setup_ctrl.dart';

class SetupOne extends StatelessWidget {
  const SetupOne({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCtrl authCtrl = Get.find<AuthCtrl>();
    SetupCtrl ctrl = Get.find<SetupCtrl>();

    ctrl.firstNameController.text =
        '${authCtrl.currentUser?.txAtributo?.txNombre}';
    ctrl.lastNameController.text =
        '${authCtrl.currentUser?.txAtributo?.txApellido}';
    ctrl.nameController.text =
        '${ctrl.firstNameController.text} ${ctrl.lastNameController.text}';

    ctrl.phoneController.text =
        '${authCtrl.currentUser?.txAtributo?.txTelefono}';
    ctrl.identificacionController.text =
        '${authCtrl.currentUser?.txAtributo?.coIdentificacion}';
    ctrl.emailController.text = '${authCtrl.currentUser?.email}';
    ctrl.usernameController.text = '${authCtrl.currentUser?.email}';

    return Obx(() {
      return SingleChildScrollView(
        clipBehavior: Clip.hardEdge,
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            SvgPicture.asset(
              AssetsDir.setup1,
              height: Responsive.width(60),
            ),
            Text(
                'Te damos la bienvenida ${authCtrl.currentUser?.name?.split(' ')[0].toCapitalized()} 👋',
                textAlign: TextAlign.center,
                style: Get.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20.0),
            Text(
              'En esta etapa nos encargaremos de configurar tu cuenta, verifica si los datos son correctos',
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyLarge,
            ),
            const SizedBox(height: 30.0),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: ctrl.firstNameController,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      ctrl.firstNameController.text = value.toUpperCase();

                      ctrl.nameController.text =
                          '${ctrl.firstNameController.text} ${ctrl.lastNameController.text}';
                    },
                    decoration: InputDecoration(
                      enabled: ctrl.firstNameDisabled.value,
                      labelText: 'Nombres',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                IconButton(
                    onPressed: () {
                      ctrl.firstNameDisabled.value =
                          !ctrl.firstNameDisabled.value;
                    },
                    icon: Icon(
                      ctrl.firstNameDisabled.value ? Icons.check : Icons.edit,
                    ))
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: ctrl.lastNameController,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      ctrl.lastNameController.text = value.toUpperCase();

                      ctrl.nameController.text =
                          '${ctrl.firstNameController.text} ${ctrl.lastNameController.text}';
                    },
                    decoration: InputDecoration(
                      enabled: ctrl.lastNameDisabled.value,
                      labelText: 'Apellidos',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                IconButton(
                    onPressed: () {
                      ctrl.lastNameDisabled.value =
                          !ctrl.lastNameDisabled.value;
                    },
                    icon: Icon(
                      ctrl.lastNameDisabled.value ? Icons.check : Icons.edit,
                    ))
              ],
            ),
            const SizedBox(height: 20.0),
            // Row(
            //   children: [
            //     Expanded(
            //       flex: 1,
            //       child: TextField(
            //         controller: ctrl.identificacionController,
            //         keyboardType: TextInputType.text,
            //         decoration: InputDecoration(
            //           enabled: false,
            //           labelText: 'Cédula',
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(10.0),
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(width: 10.0),
            //     IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
            //   ],
            // ),
            // const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: ctrl.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabled: ctrl.emailDisabled.value,
                      labelText: 'Correo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                IconButton(
                    onPressed: () {
                      ctrl.emailDisabled.value = !ctrl.emailDisabled.value;
                    },
                    icon: Icon(
                      ctrl.emailDisabled.value ? Icons.check : Icons.edit,
                    ))
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: ctrl.phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabled: ctrl.phoneDisabled.value,
                      labelText: 'Teléfono',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                IconButton(
                    onPressed: () {
                      ctrl.phoneDisabled.value = !ctrl.phoneDisabled.value;
                    },
                    icon: Icon(
                      ctrl.phoneDisabled.value ? Icons.check : Icons.edit,
                    ))
              ],
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      );
    });
  }
}
