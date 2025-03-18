import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _cepDigitado = TextEditingController();

  String _cepExibido = "";

  _recuperarDados() async {
    String cepao = _cepDigitado.text;
    String url = "https://viacep.com.br/ws/${cepao}/json/";
    http.Response response;
    response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String bairro = retorno["bairro"];

    print(logradouro);

    setState(() {
      _cepExibido = "${logradouro} e ${bairro}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.pink, title: Text("CEP")),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Digite o cep"),
              controller: _cepDigitado,
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.yellow),
              onPressed: () {
                _recuperarDados();
              },
              child: Text(
                "Aperte aqui",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Text(_cepExibido),
          ],
        ),
      ),
    );
  }
}
