import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:confiao/controllers/index.dart';

class RegisterOne extends StatelessWidget {
  const RegisterOne({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterCtrl>(
        init: RegisterCtrl(),
        builder: (ctrl) {
          return SingleChildScrollView(
            clipBehavior: Clip.hardEdge,
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SvgPicture.asset(
                    AssetsDir.setup1,
                    height: Responsive.width(60),
                  ),
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
                        ctrl.errors.removeWhere((error) =>
                            error['key'] == 'identificacionController');
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
                  ...ctrl.errors
                      .where((error) => error['value'] != null)
                      .map((error) {
                    return Text(
                      '${error['value']}',
                      style: const TextStyle(color: Colors.red),
                    );
                  })
                ],
              );
            }),
          );
        });
  }
}
