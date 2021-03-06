import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_bloc.dart';

import '../resources/constants.dart' as Constants;
import '../modules/initial_module.dart';
import 'app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppBloc()),
        // Bind((i) => AgreementBloc()),
        // Bind((i) => LocationBloc()),
        // Bind((i) => NetworkConnectionMonitor()..listen()),
        // Bind((i) => ServicesMetaRespository(
        //       url: FlavorConfig.instance.values.servicesUpdateListUrl,
        //     )),
      ];

  @override
  List<Router> get routers => [
        Router(
          Constants.initalRoute,
          module: InitialModule(),
        ),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
