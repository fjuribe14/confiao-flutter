import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:intl/intl.dart';
import 'package:confiao/helpers/index.dart';

class Validations {
  //validar si es requerido en text
  String? validateRequired(String? value) =>
      (value?.isEmpty ?? false) ? 'validation_required'.tr : null;

  //validar si es requerido en select
  String? validateRequiredSelect(dynamic value) =>
      value == null ? 'validation_required'.tr : null;

  bool esFechaValida(String fecha, {String? format = 'dd-MM-yyyy'}) {
    try {
      var date = DateFormat(format).parse(fecha);

      if (date.year > DateTime.now().year ||
          date.year <= (DateTime.now().year - 100)) {
        throw Exception('>>>>> Año mayor al actual');
      }

      if (date.month > 12 || int.parse(fecha.split('-')[1]) > 12) {
        throw Exception('>>>>> Mes fuera del rango');
      }

      if (date.day > 31 || int.parse(fecha.split('-')[0]) > 31) {
        throw Exception('>>>>> Dia fuera del rango');
      }
      return true;
    } catch (e) {
      debugPrint("esFechaValida $e");
      return false;
    }
  }

  bool esFechaGreaterThanAge(String fecha, int age,
      {String? format = 'dd-MM-'
          'yyyy'}) {
    try {
      var fechaNacimiento = DateFormat(format).parse(fecha);
      DateTime fechaActual = DateTime.now();
      int diferenciaAnios =
          (fechaActual.difference(fechaNacimiento).inDays) ~/ 365;

      if (diferenciaAnios < 18) {
        debugPrint('El usuario es menor de 18 años');
        throw Exception(
            '>>>>> El usuario es menor de 18 años: $diferenciaAnios');
      } else {
        debugPrint('El usuario tiene 18 años o más: $diferenciaAnios');
        return true;
      }
    } catch (e) {
      debugPrint("esFechaValida $e");
      return false;
    }
  }

  //validar que sea requerido la cuenta con saldo suficiente
  String? validateRequiredAccountWithBalance(
      dynamic value, double balance, double monto) {
    if (value == null) {
      return 'validation_required'.tr;
    } else if (balance < monto) {
      return 'validate_required_account_with_balance'.tr;
    }
    return null;
  }

  String? validateRequiredAndEmail(String? value, {bool isRequired = true}) {
    if (value!.isEmpty && isRequired) {
      return 'validation_required'.tr;
    } else if (!value.isEmail && value.isNotEmpty) {
      return 'validation_required_and_email'.tr;
    }
    return null;
  }

  String? validateRequiredMatch(String value, String value1) {
    if (value.isEmpty /*|| value1!.isEmpty */) {
      return 'validation_required'.tr;
    } else if (value != value1) {
      return 'validation_required_match'.tr;
    }
    return null;
  }

  //saber si el schemeMame es SCID o SRIF
  bool isSchemeSrifOrScid(value) =>
      value.isNotEmpty && ['SCID', 'SRIF'].contains(value);

  // validar si acct is CELE
  bool isAcctCele(value) => value.isNotEmpty && ['CELE'].contains(value);

  String? validateRequiredAndMaxLengh(String? value, int maxLength) {
    if (value!.isEmpty) {
      return 'validation_required'.tr;
    } else if (value.length > maxLength) {
      return '${'validation_required_max_length'.tr} $maxLength caracteres';
    }
    return null;
  }

  String? validateRequiredAndMinLengh(String? value, int minLength) {
    if (value!.isEmpty) {
      return 'validation_required'.tr;
    } else if (value.length < minLength) {
      return '${'validation_required_min_length'.tr} $minLength caracteres';
    }
    return null;
  }

  String? validateRequiredAndMinAndMaxLengh(
      String? value, int minLength, int maxLength) {
    if (value!.isEmpty) {
      return 'validation_required'.tr;
    } else if (value.length < minLength) {
      return '${'validation_required_min_length'.tr} $minLength caracteres';
    } else if (value.length > maxLength) {
      return '${'validation_required_max_length'.tr} $maxLength caracteres';
    }
    return null;
  }

  String? validateMinAndMaxLengh(String? value, int minLength, int maxLength) {
    if (value!.isNotEmpty) {
      if (value.length < minLength) {
        return '${'validation_required_min_length'.tr} $minLength caracteres';
      } else if (value.length > maxLength) {
        return '${'validation_required_max_length'.tr} $maxLength caracteres';
      }
      return null;
    }
    return null;
  }

  /// val required and formatet 1,230.40
  String? validateAmountMaxAndMultipleOff(
      String? value, int max, int multiple) {
    final doubleNumber = Helper().getDoubleFromString(value ?? '0.00');

    if (doubleNumber > max || doubleNumber % multiple != 0) {
      return "${'validation_required_min_amount'.tr} $max\n"
          "${'validation_multiple_off'.tr} $multiple";
    }
    return null;
  }

  String? validateAmountMaxAndMinAndMultipleOff(
      String? value, double max, double min, num multiple) {
    final doubleNumber = Helper().getDoubleFromString(value ?? '0.00');

    if (doubleNumber > max || doubleNumber % multiple >= 1) {
      return "${'validation_required_min_amount'.tr} $max\n"
          "${'validation_multiple_off'.tr} $multiple";
    } else if (doubleNumber < min || doubleNumber % multiple >= 1) {
      return "${'validation_required_max_amount'.tr} $min\n"
          "${'validation_multiple_off'.tr} $multiple";
    }
    return null;
  }

  String? validateAmountRequiredAndMin(String? value, double min) {
    String val = (value?.contains(',') ?? false)
        ? value!.replaceAll('.', '').replaceAll(',', '.')
        : value ?? '0';

    final intNumber = double.tryParse(val);
    if (intNumber == null || intNumber < min) {
      return "${'validation_required_max_amount'.tr} $min ";
    }
    return null;
  }

  String? validateAmountandSaldo(String? value, String? balance) {
    final intNumber = int.tryParse(
        value?.replaceAll('.', '').replaceAll(',', '.').split('.')[0] ?? '0');
    final intBalance =
        int.tryParse(balance?.replaceAll(',', '.').split('.')[0] ?? '0');
    if (intNumber! > intBalance!) {
      return "El monto excede el saldo actual de la cuenta";
    }
    return null;
  }

  String? validateAccount(String? value, String? cuenta) {
    if (value!.isEmpty) {
      return 'validation_required'.tr;
    } else if (value.length >= 4 && (value.substring(0, 4) != cuenta)) {
      return 'Los primeros 4 dígitos no pertenecen a la institución seleccionada';
    } else if (value.removeAllWhitespace.replaceAll('-', '').length != 20) {
      return 'El número debe tener 20 dígitos';
    }
    return null;
  }

  String? validateRequiredAndDateFormat(String? value, String format) {
    if (value!.isEmpty) {
      return 'validation_required'.tr;
    } else if (esFechaValida(value, format: format) == false) {
      return 'validation_required_date_valid'.tr;
    }
    return null;
  }

  String? validateRequiredAndDateFormatAndGreaterThanAge(
      String? value, String format, int age) {
    if (value!.isEmpty) {
      return 'validation_required'.tr;
    } else if (esFechaGreaterThanAge(value, age, format: format) == false) {
      return "${'validation_required_date_greater_than_age'.tr} ($age)";
    } else {
      return validateRequiredAndDateFormat(value, format);
    }
    // return null;
  }

  String? validateRequiredAndTelephoneNumber(String? value) {
    // Definir los prefijos válidos en una lista
    List<String> validPrefixes = ['0412', '0414', '0424', '0416', '0426'];

    if (value!.isEmpty) {
      return 'validation_required'.tr;
    } else if (value.length != 11) {
      return 'El número debe tener 11 dígitos';
    } else if (!validPrefixes.contains(value.substring(0, 4))) {
      return 'El número debe empezar con uno de estos prefijos: ${validPrefixes.join(', ')}';
    }
    // Si el valor pasa todas las validaciones, devolver null
    return null;
  }

  String? validateRequiredAndMathWithPrefixAndMaxLength(
      String? value, List<String>? validPrefixes, int maxLength) {
    if (value!.isEmpty) {
      return 'validation_required'.tr;
    } else if (validPrefixes?.isNotEmpty ?? false) {
      if (value.length > maxLength) {
        return validateRequiredAndMaxLengh(value, maxLength);
      }

      for (var prefix in validPrefixes!) {
        if (value.startsWith(prefix)) {
          return null; // Retorna null si el valor es válido
        }
      }
      // Si ninguno coincide, retorna un mensaje de error
      return 'El número debe comenzar con : ${validPrefixes.join(", ")}';
    } else if (value.length > maxLength) {
      return validateRequiredAndMaxLengh(value, maxLength);
      // return '${'validation_required_max_length'.tr} $maxLength caracteres';
    }
    return null;
  }
}
