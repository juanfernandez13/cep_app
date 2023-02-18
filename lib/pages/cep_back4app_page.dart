import 'package:cep_app/models/endereco_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../repositories/back4app/back4app_repository.dart';
import '../repositories/back4app/impl/dio_back4app_repository.dart';

class CepBack4AppPage extends StatefulWidget {
  const CepBack4AppPage({super.key});

  @override
  State<CepBack4AppPage> createState() => _CepBack4AppPageState();
}

class _CepBack4AppPageState extends State<CepBack4AppPage> {
  List<EnderecoModel> results = [];
  Back4AppRepository back4appRepository = DioBack4AppRepository();
  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  carregarDados() async {
    results = await back4appRepository.obterEnderecoCadastrado();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF001CBE),
        title: const Text("Endereços salvos"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          results.isEmpty
              ? const Center(child: CircularProgressIndicator(),)
              : Expanded(
                child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (_, index) {
                      EnderecoModel result = results[index];
                      return Dismissible(
                        key: Key(result.id),
                        onDismissed: (DismissDirection direction) async {
                          await back4appRepository.deletarEndereco(result.id);
                          carregarDados();
                        },
                        direction: DismissDirection.startToEnd,
                        background: Container(
                          color: Colors.red,
                          child: const Align(
                            alignment: Alignment(-0.9, 0.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ), 
                        child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(result.logradouro),
                                  Text(result.bairro),
                                ],
                              ),
                              leading: const CircleAvatar(
                                  backgroundColor: Color(0xFF001CBE),
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.white,
                                  )),
                                  trailing: Icon(Icons.arrow_forward_ios),
                            ));
                    }),
              )
        ],
      ),
    ));
  }
}
