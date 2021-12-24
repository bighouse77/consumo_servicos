// ignore_for_file: file_names, deprecated_member_use, prefer_const_constructors, unused_local_variable, unnecessary_brace_in_string_interps

/* 
  *********************************** OBSERVAÇÃO *******************************
  Em pubspec.yaml, colar em "dependencies: flutter:", acabaxo do cupertino_icons,
  a versão do http. Exemplo utilizado:

      http: ^0.13.0-nullsafety.0

*/

// pacote htttp
import 'package:http/http.dart' as http;

// pacote para conversão (json)
import 'dart:convert';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // async, pois eu não sei quanto tempo o servidor irá demorar para responder
  // comunicação assincrona
  _recuperarCep() async {
    String cep = "13606662";
    String url = "https://viacep.com.br/ws/${cep}/json/";

    http.Response response;

    // await, quer dizer que iremos aguardar a resposta do servidor quando
    // fizermos a aquisição via get
    /* 
      Uri.parse() é para pegarmos String. Só o get não funciona mais!!!!
      Maneira errada => response = await http.get(url);
    */
    //Maneira correta:
    response = await http.get(Uri.parse(url));

    // json.decode(), converterá Stringe em objeto json

    /*
      ************************** RELEMBANDO: MAP *******************************
      Map<String, dynamic> : String e dynamic são os tipos, no caso:

        - String = retorno 
        - dynamic = json.decode() *dinamico pois o valor dele irá se alterar, 
        diferente da String.
    */
    Map<String, dynamic> retorno = json.decode(response.body);

    // Recuperando valors pela String:
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    print(
      "Logradouro: ${logradouro}, Bairro: ${bairro}, Localidade: ${localidade}"
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Consumo de serviço Web")),
        body: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            children: [
              RaisedButton(
                child: Text("Clique aqui!"),
                onPressed: _recuperarCep,
              )
            ],
          ),
        ));
  }
}
