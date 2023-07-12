import 'package:criptomoedas/pages/page_home.dart';
import 'package:flutter/material.dart';

class MeuAplicativo extends StatefulWidget {
  const MeuAplicativo({super.key});

  @override
  State<MeuAplicativo> createState() => _MeuAplicativoState();
}

class _MeuAplicativoState extends State<MeuAplicativo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CriptoMoedas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomePage(),
    );
  }
}
