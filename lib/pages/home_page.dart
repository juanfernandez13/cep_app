import 'package:cep_app/models/endereco_model.dart';
import 'package:cep_app/repositories/endereco_repository.dart';
import 'package:cep_app/repositories/impl/dio_endereco_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController cepController = TextEditingController(text: "");
  TextEditingController ufController = TextEditingController(text: "");
  TextEditingController cidadeController = TextEditingController(text: "");
  TextEditingController logradouroController = TextEditingController(text: "");
  late EnderecoModel enderecoModel;
  EnderecoRepository enderecoRepository = DioEnderecoRepository();
  String valueDropdown = "Selecione um UF";
  List<EnderecoModel> results = [];
  final List<String> uf = [
    "Selecione um UF",
    "AC",
    "AL",
    "AP",
    "BA",
    "CE",
    "DF",
    "ES",
    "GO",
    "MA",
    "MT",
    "MS",
    "MG",
    "PR",
    "PB",
    "PE",
    "PI",
    "RJ",
    "RN",
    "RS",
    "RO",
    "RR",
    "SC",
    "SE",
    "SP",
    "TO",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 61, 134, 99),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 61, 134, 99),
        title: const Center(
            child: Text(
          "Pesquisar endereços",
          textAlign: TextAlign.center,
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.40,
              width: MediaQuery.of(context).size.height * 0.40,
              child: Card(
                child: PageView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Pesquisar com Cep"),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: cepController,
                            keyboardType: TextInputType.number,
                            decoration:
                                const InputDecoration(hintText: "Digite o cep"),
                            onChanged: (value) async {
                              if (cepController.text.length == 8) {
                                results.add(await enderecoRepository
                                    .obterEnderecoViaCep(cepController.text));
                                setState(() {});
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Pesquisar com endereço"),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButton(
                              menuMaxHeight:
                                  MediaQuery.of(context).size.height * 0.3,
                              value: valueDropdown,
                              items: uf
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (String? value) {
                                setState(() => valueDropdown = value!);
                              }),
                          TextField(
                            controller: cidadeController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: "Digite sua cidade"),
                          ),
                          TextField(
                            onChanged: (value) async {
                              if (logradouroController.text.length > 3 &&
                                  cidadeController.text.length > 3) {
                                print(ufController.text);
                                print(cidadeController.text);
                                print(logradouroController.text);
                                results =
                                    await enderecoRepository.obterEnderecoDados(
                                        valueDropdown,
                                        cidadeController.text,
                                        logradouroController.text);
                                setState(() {});
                              }
                            },
                            controller: logradouroController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: "Digite seu logradouro"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      leading: Text(results[index].logradouro),
                      trailing: Text(results[index].bairro),
                    );
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
