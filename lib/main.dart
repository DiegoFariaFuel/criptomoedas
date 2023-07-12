import 'package:criptomoedas/config/app_settings.dart';
import 'package:criptomoedas/config/hive_config.dart';
import 'package:criptomoedas/repositorio/repositorio_favoritos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'meu_aplicativo.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => AppSettings(),
      ),
      ChangeNotifierProvider(
        create: (context) => FavoritasRepository(),
      )
    ], child: const MeuAplicativo()),
  );
}
