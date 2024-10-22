import 'package:get/get.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PagoservicioCtrl extends GetxController {
  String url = ApiUrl.apiPagarPersonal;

  procesarPago() async {
    Http().http(showLoading: true).then((value) =>
        value.post('${dotenv.env['URL_API_SERVICIO']}$url', data: {}));
  }
}
