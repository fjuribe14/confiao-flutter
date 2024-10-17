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
    SetupCtrl setupCtrl = Get.find<SetupCtrl>();

    setupCtrl.firstNameController.text =
        authCtrl.currentUser?.txAtributo['tx_nombre'] ?? '';
    setupCtrl.lastNameController.text =
        authCtrl.currentUser?.txAtributo['tx_apellido'] ?? '';
    setupCtrl.phoneController.text =
        authCtrl.currentUser?.txAtributo['tx_telefono'] ?? '';
    setupCtrl.identificacionController.text =
        authCtrl.currentUser?.txAtributo['co_identificacion'] ?? '';
    setupCtrl.emailController.text = authCtrl.currentUser?.email ?? '';
    setupCtrl.usernameController.text = authCtrl.currentUser?.email ?? '';

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
                  controller: setupCtrl.firstNameController,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    setupCtrl.firstNameController.text = value.toUpperCase();

                    setupCtrl.nameController.text =
                        '${setupCtrl.firstNameController.text} ${setupCtrl.lastNameController.text}';
                  },
                  decoration: InputDecoration(
                    enabled: false,
                    labelText: 'Nombres',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  controller: setupCtrl.lastNameController,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    setupCtrl.lastNameController.text = value.toUpperCase();

                    setupCtrl.nameController.text =
                        '${setupCtrl.firstNameController.text} ${setupCtrl.lastNameController.text}';
                  },
                  decoration: InputDecoration(
                    enabled: false,
                    labelText: 'Apellidos',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  controller: setupCtrl.identificacionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabled: false,
                    labelText: 'Cédula',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  controller: setupCtrl.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    enabled: false,
                    labelText: 'Correo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  controller: setupCtrl.phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    enabled: false,
                    labelText: 'Teléfono',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
            ],
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
