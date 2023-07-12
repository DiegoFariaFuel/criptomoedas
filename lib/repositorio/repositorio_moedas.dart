import '../models/moeda.dart';

class MoedaRepositorio {
  // ignore: non_constant_identifier_names

  List<Moeda> tabela = [
    Moeda(
        nome: 'Bitcoin',
        icone: 'assets/bitcoin-512.png',
        preco: 2324554,
        sigla: 'BTC'),
    Moeda(
        nome: 'Ethereum',
        icone: 'assets/ethereum-240.png',
        preco: 3423423,
        sigla: 'ETH'),
    Moeda(
        nome: 'Tether',
        icone: 'assets/tether-240.png',
        preco: 5234,
        sigla: 'TE'),
    Moeda(
        nome: 'Viacoin',
        icone: 'assets/viacoin-240.png',
        preco: 3441,
        sigla: 'VI'),
    Moeda(
        nome: 'Vertcoin',
        icone: 'assets/vertcoin-240.png',
        preco: 12142,
        sigla: 'VE'),
    Moeda(
        nome: 'Monero',
        icone: 'assets/monero-240.png',
        preco: 24452,
        sigla: 'MO'),
    Moeda(nome: 'Iota', icone: 'assets/iota-240.png', preco: 2323, sigla: 'IO'),
    Moeda(
        nome: 'Feathercoin',
        icone: 'assets/feathercoin-240.png',
        preco: 2322,
        sigla: 'FE'),
    Moeda(
        nome: 'Peercoin',
        icone: 'assets/peercoin-240.png',
        preco: 232324,
        sigla: 'PE'),
    Moeda(
        nome: 'Litecoin',
        icone: 'assets/litecoin-240.png',
        preco: 215144,
        sigla: 'LI')
  ];
}
