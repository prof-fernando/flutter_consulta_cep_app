import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Consulta extends StatefulWidget {
  final String cep;

  const Consulta({super.key, required this.cep});

  @override
  State<Consulta> createState() => _ConsultaState();
}

class _ConsultaState extends State<Consulta> {
  String localidade = '';

  String ibge = '';

  @override
  void initState() {
    // volta a pagina anterior de forma explicita
    String url = 'http://viacep.com.br/ws/${widget.cep}/json/';
    http.get(Uri.parse(url)).then((response) {
      // converter o a resposta para um map
      Map dados = jsonDecode(response.body);

      //print(dados['localidade']);
      localidade = dados['localidade'];
      ibge = dados['ibge'];

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes ${widget.cep}'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('CEP digitado: ${widget.cep}'),
            Text('Código IBGE: $ibge'),
            Text('Cidade: $localidade'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
