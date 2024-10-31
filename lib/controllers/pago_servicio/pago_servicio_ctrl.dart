import 'package:get/get.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PagoServicioCtrl extends GetxController {
  String url = ApiUrl.apiPagarPersonal;

  RxDouble moTotal = 0.0.obs;
  RxDouble moSubTotal = 0.0.obs;

  procesarPago() async {
    Http().http(showLoading: true).then((value) =>
        value.post('${dotenv.env['URL_API_SERVICIO']}$url', data: {}));
  }
}
