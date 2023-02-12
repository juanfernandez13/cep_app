import 'package:cep_app/models/endereco_model.dart';
import 'package:cep_app/repositories/back4app/back4app_repository.dart';
import 'dio_back4app_custon.dart';

class DioBack4AppRepository implements Back4AppRepository {
  final _custonDio = Back4AppCustonDio();
  @override
  Future<EnderecoModel> obterEnderecoCadastrado() async {
    var response = await _custonDio.dio.get("/Cep");
    return EnderecoModel.fromJson(response.data);
  }

  @override
  Future<void> cadastrarEndereco(EnderecoModel enderecoModel) async {
    try {
      var response =
          await _custonDio.dio.post("/Cep", data: enderecoModel.toJson());
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> atualizarEndereco(EnderecoModel enderecoModel, String id) async {
    try {
      await _custonDio.dio.put("/Cep/$id", data: enderecoModel.toJson());
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> deletarEndereco(String id) async {
    try {
      await _custonDio.dio.delete("/Cep/$id");
    } catch (e) {
      throw e;
    }
  }
}
