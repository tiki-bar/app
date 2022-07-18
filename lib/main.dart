import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:tiki_login/tiki_login.dart';

import 'app.dart';
import 'provide.dart' as provide;
import 'src/config/config_amplitude.dart';
import 'src/config/config_log.dart';
import 'src/config/config_sentry.dart';
import 'src/config/config_updates.dart';
import 'src/home/home_service.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    await _libsInit();
    TikiLogin login = await _loginInit();
    FlutterError.onError = (FlutterErrorDetails details) {
      Logger("Flutter Error")
          .severe(details.summary, details.exception, details.stack);
    };
    runApp(App(login.routerDelegate));
  }, (exception, stackTrace) async {
    Logger("Uncaught Exception")
        .severe("Caught by runZoneGuarded", exception, stackTrace);
  });
}

Future<void> _libsInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ConfigLog();
  await ConfigSentry.init();
  await ConfigAmplitude.init();
  await Firebase.initializeApp();
}

Future<TikiLogin> _loginInit() async {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  Httpp httpp = Httpp(useClient: () => SentryHttpClient());
  HomeService home = HomeService();
  TikiLogin login = TikiLogin(
      httpp: httpp, secureStorage: secureStorage, home: home.presenter);
  await login.init();
  if(login.user?.isLoggedIn != null ? !login.user!.isLoggedIn! : true){
    provide.checkFirstRun(secureStorage);
  }
  home.presenter.inject(() => provide.init(home,
      login: login, secureStorage: secureStorage, httpp: httpp));
  return login;
}
