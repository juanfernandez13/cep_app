import 'package:cep_app/models/endereco_model.dart';
import 'package:cep_app/repositories/endereco_repository.dart';
import 'package:dio/dio.dart';

class CustonDio {
  final _dio = Dio();
  Dio get dio => _dio;
  CustonDio() {
    _dio.options.baseUrl = "https://viacep.com.br/ws/";
  }
}

class DioEnderecoRepository implements EnderecoRepository {
  @override
  Future<EnderecoModel> obterEnderecoViaCep(String cep) async {
    var custonDio = CustonDio();
    var response = await custonDio.dio.get("/$cep/json");
    if (response.statusCode == 200 && response.data['cep'] != null) {
      return EnderecoModel.fromJson(response.data);
    }
    return EnderecoModel("", "", "", "", "", "");
  }

  @override
  Future<List<EnderecoModel>> obterEnderecoDados(
      String uf, String cidade, String logradouro) async {
    var custonDio = CustonDio();
    var response = await custonDio.dio.get("/$uf/$cidade/$logradouro/json");
    if (response.statusCode == 200 && response.data != null) {
      return (response.data as List)
          .map((e) => EnderecoModel.fromJson(e))
          .toList();
    }
    return <EnderecoModel>[];
  }
}
