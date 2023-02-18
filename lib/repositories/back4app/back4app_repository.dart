import 'package:cep_app/models/endereco_model.dart';

abstract class Back4AppRepository {
  Future<List<EnderecoModel>> obterEnderecoCadastrado();
  Future<void> cadastrarEndereco(EnderecoModel enderecoModel);
  Future<void> atualizarEndereco(EnderecoModel enderecoModel,String id);
  Future<void> deletarEndereco(String id);

}