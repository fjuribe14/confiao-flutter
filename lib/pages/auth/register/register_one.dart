import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:confiao/controllers/index.dart';

class RegisterOne extends StatelessWidget {
  const RegisterOne({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterCtrl ctrl = Get.find<RegisterCtrl>();

    return Obx(() {
      return SingleChildScrollView(
          clipBehavior: Clip.hardEdge,
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Get.theme.colorScheme.primary.withOpacity(0.5),
                          Get.theme.colorScheme.primary.withOpacity(0.2),
                        ])),
                child: SvgPicture.asset(
                  AssetsDir.setup1,
                  width: Responsive.width(80),
                  height: Responsive.width(80),
                ),
              ),
              const SizedBox(height: 20.0),
              Text('Te damos la bienvenida 👋',
                  textAlign: TextAlign.center,
                  style: Get.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5.0),
              Text(
                'Comencemos llenando tus datos',
                textAlign: TextAlign.center,
                style: Get.textTheme.bodyLarge,
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: ctrl.firstNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Nombres',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                    ctrl.errors.add({
                      'key': 'firstNameController',
                      'value': 'Nombres es obligatorio',
                    });
                  } else {
                    ctrl.errors.removeWhere(
                        (error) => error['key'] == 'firstNameController');
                  }

                  ctrl.firstNameController.text = value.toUpperCase();

                  ctrl.nameController.text =
                      '${ctrl.firstNameController.text} ${ctrl.lastNameController.text}';
                },
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: ctrl.lastNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Apellidos',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                    ctrl.errors.add({
                      'key': 'lastNameController',
                      'value': 'Apellidos es obligatorio',
                    });
                  } else {
                    ctrl.errors.removeWhere(
                        (error) => error['key'] == 'lastNameController');
                  }

                  ctrl.lastNameController.text = value.toUpperCase();

                  ctrl.nameController.text =
                      '${ctrl.firstNameController.text} ${ctrl.lastNameController.text}';
                },
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: ctrl.identificacionController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Cédula',
                  hintText: 'V1234567, J1234567, E1234567',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                    ctrl.errors.add({
                      'key': 'identificacionController',
                      'value': 'Cédula es obligatorio',
                    });
                  } else {
                    ctrl.errors.removeWhere(
                        (error) => error['key'] == 'identificacionController');
                  }

                  ctrl.identificacionController.text = value.toUpperCase();
                },
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: ctrl.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Correo',
                  hintText: 'correo@gmail.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                    ctrl.errors.add({
                      'key': 'emailController',
                      'value': 'Cédula es obligatorio',
                    });
                  } else {
                    ctrl.errors.removeWhere(
                        (error) => error['key'] == 'emailController');
                  }

                  ctrl.emailController.text = value;
                },
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: ctrl.phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Teléfono',
                  hintText: '04121234567, 04241234567',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                    ctrl.errors.add({
                      'key': 'phoneController',
                      'value': 'Teléfono es obligatorio',
                    });
                  } else {
                    ctrl.errors.removeWhere((error) =>
                        [null, 'phoneController'].contains(error['key']));
                  }

                  ctrl.phoneController.text = value;
                },
              ),
              const SizedBox(height: 20.0),
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
                      onChanged: (value) {
                        if (value.isEmpty) {
                          ctrl.errors.add({
                            'key': 'passwordController',
                            'value': 'La contraseña es obligatoria',
                          });
                        } else {
                          ctrl.errors.removeWhere((error) => [
                                null,
                                'passwordController'
                              ].contains(error['key']));
                        }

                        ctrl.passwordController.text = value;
                      },
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
                      obscureText: !ctrl.textVisibleConfirm.value,
                      decoration: InputDecoration(
                        hintText: '**********',
                        labelText: 'Confirmar contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          ctrl.errors.add({
                            'key': 'passwordConfirmController',
                            'value': 'La contraseña debe ser confirmada',
                          });
                        } else {
                          ctrl.errors.removeWhere((error) => [
                                null,
                                'passwordConfirmController'
                              ].contains(error['key']));
                        }

                        ctrl.passwordConfirmController.text = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  IconButton(
                      onPressed: () {
                        ctrl.textVisibleConfirm.value =
                            !ctrl.textVisibleConfirm.value;
                      },
                      icon: Icon(ctrl.textVisibleConfirm.value
                          ? Icons.visibility_off_outlined
                          : Icons.remove_red_eye_outlined))
                ],
              ),
              const SizedBox(height: 20.0),
              ...ctrl.errors
                  .where((error) => error['value'] != null)
                  .map((error) {
                return Text(
                  '${error['value']}',
                  style: const TextStyle(color: Colors.red),
                );
              })
            ],
          ));
    });
  }
}
