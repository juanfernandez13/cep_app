import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../back4app_repository.dart';
import '../../../models/endereco_model.dart';
import 'package:http/http.dart' as http;

class HttpBack4AppRepository implements Back4AppRepository {
  final baseUrl = dotenv.get("BASEURLBACK4APP");
  Map<String, String> headers = {
    "X-Parse-Application-Id": dotenv.get("XPARSEAPPLICATIONID"),
    "X-Parse-REST-API-Key": dotenv.get("XPARSERESTAPIKEY"),
    "Content-Type": dotenv.get("CONTENTTYPE"),
  };

  @override
  Future<List<EnderecoModel>> obterEnderecoCadastrado() async {
    var response = await http.get(Uri.parse("$baseUrl/Cep"), headers: headers);
    var responseDecode = json.decode(response.body);
    if (response.statusCode == 200) {
      return (responseDecode["results"] as List)
          .map((e) => EnderecoModel.fromJson(e))
          .toList();
    }
    return <EnderecoModel>[];
  }

  @override
  Future<void> cadastrarEndereco(EnderecoModel enderecoModel) async {
   http.Response response = await http.post(Uri.parse("$baseUrl/Cep"),
        headers: headers, body: jsonEncode(enderecoModel.toJson()));
    debugPrint(response.statusCode.toString());
  }

  @override
  Future<void> atualizarEndereco(EnderecoModel enderecoModel, String id) async {
    http.Response response = await http.put(Uri.parse("$baseUrl/Cep/$id"),
        headers: headers, body: enderecoModel);
    debugPrint(response.statusCode.toString());
  }

  @override
  Future<void> deletarEndereco(String id) async {
    http.Response response = await http.delete(Uri.parse("$baseUrl/Cep/$id"), headers: headers);
    debugPrint(response.statusCode.toString());
  }
}
