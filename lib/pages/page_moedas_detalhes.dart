import 'package:criptomoedas/models/moeda.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class MoedasDetalhesPage extends StatefulWidget {
  Moeda moeda;

  MoedasDetalhesPage({super.key, required this.moeda});

  @override
  State<MoedasDetalhesPage> createState() => _MoedasDetalhesPageState();
}

class _MoedasDetalhesPageState extends State<MoedasDetalhesPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double quantidade = 0;

  compra() {
    if (_form.currentState!.validate()) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Compra efetuada!',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          widget.moeda.nome,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: Image.asset(widget.moeda.icone),
                    ),
                    Container(width: 10),
                    Text(real.format(widget.moeda.preco),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 26,
                            color: Colors.grey))
                  ],
                ),
              ),
              (quantidade > 0)
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(40)),
                        child: Text(
                          "$quantidade ${widget.moeda.sigla}",
                          style: const TextStyle(
                              fontSize: 17,
                              color: Colors.teal,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(bottom: 24),
                    ),
              Form(
                key: _form,
                child: TextFormField(
                  controller: _valor,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Valor',
                      prefixIcon: Icon(Icons.monetization_on_outlined),
                      suffix: Text('reais')),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o valor da compra!';
                    } else if (double.parse(value) < 50) {
                      return 'Compra minima e R\$ 50,00';
                    }
                    return null;
                  },
                  onChanged: ((value) {
                    setState(() {
                      quantidade = (value.isEmpty)
                          ? 0
                          : double.parse(value) / widget.moeda.preco;
                    });
                  }),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(top: 24),
                child: ElevatedButton(
                  onPressed: compra,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.check),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Comprar',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
