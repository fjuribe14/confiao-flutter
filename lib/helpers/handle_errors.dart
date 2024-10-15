// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';

class AppErrorRegister {
  final dynamic reason, exception;
  final StackTrace stack;
  final Iterable<Object>? information;
  bool? printDetails;
  bool? fatal;

  AppErrorRegister({
    required this.reason,
    required this.stack,
    required this.exception,
    this.information = const [],
    this.fatal = false,
  });
}

/// Register log in firebase crashlytics
class HandleErrors {
  setMetadataLogAndErrorTrace({
    String? key,
    String? value,
    String? log,
    String? userId,
    String? page,
    String? fnName,
    AppErrorRegister? recordError,
  }) async {
    try {
      // if ((key?.isNotEmpty ?? false) && (value?.isNotEmpty ?? false)) {
      //   FirebaseCrashlytics.instance.setCustomKey("$key", "$value");
      // }
      //
      // if (log?.isNotEmpty ?? false) {
      //   FirebaseCrashlytics.instance.log('$log');
      // }
      //
      // if (userId?.isNotEmpty ?? false) {
      //   FirebaseCrashlytics.instance.setUserIdentifier("$userId");
      // }
      //
      // if (page?.isNotEmpty ?? false) {
      //   FirebaseCrashlytics.instance.setCustomKey('screen', page ?? '');
      // }
      //
      // if (fnName?.isNotEmpty ?? false) {
      //   FirebaseCrashlytics.instance.setCustomKey('fn_name', value ?? '');
      // }
      //
      // if (log?.isNotEmpty ?? false) {
      //   FirebaseCrashlytics.instance.log('$log'); //log
      // }
      //
      // if (recordError?.stack.toString().isNotEmpty ?? false) {
      //   await FirebaseCrashlytics.instance.recordError(
      //     recordError?.exception,
      //     recordError?.stack,
      //     reason: recordError?.reason,
      //     fatal: recordError?.fatal ?? false,
      //     information: recordError?.information ?? [],
      //     printDetails: recordError?.printDetails,
      //   );
      // }
      printError(info: 'setMetadataLogAndErrorTrace');
      return true;
    } catch (e) {
      // print(e);
      printError(
          info: '${{
        key,
        value,
        log,
        userId,
        page,
        fnName,
        recordError,
      }}');
      return false;
    }
  }
}
