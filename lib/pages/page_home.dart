import 'package:criptomoedas/pages/as.dart';
import 'package:criptomoedas/pages/page_favoritas.dart';
import 'package:criptomoedas/pages/page_moedas.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;
  
  onPaginaAtual(pagina){
  setState(() {
    paginaAtual = pagina;
  });
  }

  @override
  void initState() {
    pc = PageController(initialPage : paginaAtual);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: onPaginaAtual ,
        children: const [MoedasPage(), FavoritasPage(),RodaAi()],
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todas'),
          BottomNavigationBarItem(icon: Icon(Icons.star),label: 'Favoritas')
        ],
        onTap: (pagina) {
          pc.animateToPage(pagina, duration: const Duration(milliseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}
