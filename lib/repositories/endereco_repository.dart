import 'package:cep_app/models/endereco_model.dart';

abstract class EnderecoRepository {
  Future<EnderecoModel> obterEnderecoViaCep(String cep);
  Future<List<EnderecoModel>> obterEnderecoDados(String uf, String cidade, String logradouro);

}
