import 'package:get/get.dart';

class Responsive {
  static width(double porcent) {
    return porcent > 0 ? Get.width * (porcent / 100) : Get.width;
  }

  static height(double porcent) {
    return porcent > 0 ? Get.height * (porcent / 100) : Get.height;
  }
}
