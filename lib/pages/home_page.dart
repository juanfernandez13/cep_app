import 'package:cep_app/models/endereco_model.dart';
import 'package:cep_app/pages/cep_back4app_page.dart';
import 'package:cep_app/repositories/back4app/back4app_repository.dart';
import 'package:cep_app/repositories/back4app/impl/dio_back4app_repository.dart';
import 'package:cep_app/repositories/back4app/impl/http_back4app_repository.dart';
import '../repositories/endereco/endereco_repository.dart';
import 'package:cep_app/repositories/endereco/impl/dio_endereco_repository.dart';
import 'package:flutter/material.dart';

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
  int currentPage = 0;
  PageController pageController = PageController();
  late EnderecoModel enderecoModel;
  EnderecoRepository enderecoRepository = DioEnderecoRepository();
  Back4AppRepository back4appRepository = HttpBack4AppRepository();
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
      backgroundColor: const Color(0xFFDBDBDB),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CepBack4AppPage())
                );
              },
              icon: const Icon(Icons.save))
        ],
        backgroundColor: const Color(0xFF001CBE),
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
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width * 0.90,
              child: Card(
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        onPageChanged: (page) {
                          currentPage = int.parse(
                              pageController.page!.floor().toString());
                          setState(() {});
                        },
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
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
                                  maxLength: 8,
                                  decoration: const InputDecoration(
                                    labelText: "Digite o cep",
                                    labelStyle:
                                        TextStyle(color: Color(0xFF001CBE)),
                                    suffixIcon: Icon(
                                      Icons.map,
                                      color: Color(0xFF001CBE),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF001CBE)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF001CBE)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                  onChanged: (value) async {
                                    if (cepController.text.length == 8) {
                                      List<EnderecoModel> pesquisa = [];
                                      pesquisa.add(await enderecoRepository
                                          .obterEnderecoViaCep(
                                              cepController.text));
                                      results = pesquisa;
                                      setState(() {});
                                    }
                                  },
                                ),
                                TextButton(
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(Color(0xFF001CBE))),
                                    onPressed: () {
                                      currentPage++;
                                      setState(() {
                                        pageController.animateToPage(
                                            currentPage,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeInCubic);
                                      });
                                    },
                                    child: const Text("Esqueceu o cep?", style: TextStyle(color: Colors.white),))
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Pesquisar com endereço"),
                                const SizedBox(
                                  height: 20,
                                ),
                                DropdownButtonFormField(
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xFF001CBE),
                                    ),
                                    decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF001CBE)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF001CBE)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    menuMaxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.3,
                                    value: valueDropdown,
                                    items: uf
                                        .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                  color: Color(0xFF001CBE)),
                                            )))
                                        .toList(),
                                    onChanged: (String? value) {
                                      setState(() => valueDropdown = value!);
                                    }),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextField(
                                  controller: cidadeController,
                                  decoration: const InputDecoration(
                                    labelText: "Digite sua cidade",
                                    labelStyle:
                                        TextStyle(color: Color(0xFF001CBE)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF001CBE)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF001CBE)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextField(
                                  controller: logradouroController,
                                  decoration: const InputDecoration(
                                    labelText: "Digite seu logradouro",
                                    labelStyle:
                                        TextStyle(color: Color(0xFF001CBE)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF001CBE)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF001CBE)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextButton(
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(Color(0xFF001CBE))),
                                    onPressed: () async {
                                      if (logradouroController.text.length >
                                              3 &&
                                          cidadeController.text.length > 3) {
                                        results = await enderecoRepository
                                            .obterEnderecoDados(
                                                valueDropdown,
                                                cidadeController.text,
                                                logradouroController.text);
                                        setState(() {});
                                      }
                                    },
                                    child: const Text("Pesquisar cep", style: TextStyle(color: Colors.white),))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.37,
                child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(results[index].logradouro),
                                Text(results[index].bairro),
                              ],
                            ),
                            leading: const CircleAvatar(
                                backgroundColor: Color(0xFF001CBE),
                                child: Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white,
                                )),
                            trailing: IconButton(
                              onPressed: () async => back4appRepository
                                  .cadastrarEndereco(results[index]),
                              icon: const Icon(Icons.save),
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
