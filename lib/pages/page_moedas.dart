import 'package:criptomoedas/config/app_settings.dart';
import 'package:criptomoedas/models/moeda.dart';
// ignore: unused_import
import 'package:criptomoedas/pages/page_favoritas.dart';
import 'package:criptomoedas/pages/page_moedas_detalhes.dart';
import 'package:criptomoedas/repositorio/repositorio_favoritos.dart';
import 'package:criptomoedas/repositorio/repositorio_moedas.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({super.key});

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabela = MoedaRepositorio().tabela;
  late NumberFormat real;
  late Map<String, String> loc;
  List<Moeda> selecionadas = [];
  late FavoritasRepository favoritas;

  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name ']);
  }

  changeLanguageButton() {
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name   = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    return PopupMenuButton(
      icon: const Icon(Icons.language),
      itemBuilder: (context) => [
        PopupMenuItem(
            child: ListTile(
          leading: const Icon(Icons.swap_vert),
          title: Text('Usar $locale'),
          onTap: () {
            context.read<AppSettings>().setLocale(locale, name);
            Navigator.pop(context);
          },
        ))
      ],
    );
  }

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: const Text(
          'Cripto Bay',
          style: TextStyle(color: Colors.black45),
        ),
        titleSpacing: 20,
        actions: [
          changeLanguageButton(),
        ],
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          alignment: Alignment.topRight,
          onPressed: (() {
            setState(() {
              selecionadas = [];
            });
          }),
        ),
        title: Text(
          '${selecionadas.length}  Selecionadas',
          style: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey[50],
        iconTheme: const IconThemeData(color: Colors.black87),
      );
    }
  }

  mostrarDetalhes(Moeda moeda) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => MoedasDetalhesPage(moeda: moeda))));
  }

  limparSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    //favoritas = Provider.of<FavoritasRepository>(context);
    favoritas = context.watch<FavoritasRepository>();
    readNumberFormat();
    return Scaffold(
        appBar: appBarDinamica(),
        body: ListView.separated(
            itemBuilder: ((context, int moeda) {
              return ListTile(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                leading: (selecionadas.contains(tabela[moeda]))
                    ? const CircleAvatar(
                        child: Icon(Icons.check),
                      )
                    : SizedBox(
                        width: 40,
                        child: Image.asset(
                          tabela[moeda].icone,
                        )),
                title: Row(
                  children: [
                    Text(
                      tabela[moeda].nome,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    if (favoritas.lista
                        .any(((fav) => fav.sigla == tabela[moeda].sigla)))
                      const Icon(Icons.circle, color: Colors.amber, size: 10),
                  ],
                ),
                trailing: Text(real.format(tabela[moeda].preco)),
                selectedTileColor: Colors.indigo[50],
                selected: selecionadas.contains(tabela[moeda]),
                onLongPress: () {
                  setState(() {
                    (selecionadas.contains(tabela[moeda]))
                        ? selecionadas.remove(tabela[moeda])
                        : selecionadas.add(tabela[moeda]);
                  });
                },
                onTap: () => mostrarDetalhes(tabela[moeda]),
              );
            }),
            padding: const EdgeInsets.all(16),
            separatorBuilder: ((context, index) => const Divider()),
            itemCount: tabela.length),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: (selecionadas.isNotEmpty)
            ? FloatingActionButton.extended(
                onPressed: () {
                  favoritas.saveAll(selecionadas);
                  limparSelecionadas();
                },
                label: const Text(
                  'FAVORITAR',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0),
                ),
                icon: const Icon(Icons.star))
            : null);
  }
}
