class EnderecoModel {
  String _cep = "";
  String _logradouro = "";
  String _bairro = "";
  String _localidade = "";
  String _uf = "";
  String _ddd = "";

  EnderecoModel(
      cep,
      logradouro,
      bairro,
      localidade,
      uf,
      ddd);

  String get cep => _cep;
  set cep(String cep) => _cep = cep;
  String get logradouro => _logradouro;
  set logradouro(String logradouro) => _logradouro = logradouro;
  String get bairro => _bairro;
  set bairro(String bairro) => _bairro = bairro;
  String get localidade => _localidade;
  set localidade(String localidade) => _localidade = localidade;
  String get uf => _uf;
  set uf(String uf) => _uf = uf;
  String get ddd => _ddd;
  set ddd(String ddd) => _ddd = ddd;

  EnderecoModel.fromJson(Map<String, dynamic> json) {
    _cep = json['cep'];
    _logradouro = json['logradouro'];
    _bairro = json['bairro'];
    _localidade = json['localidade'];
    _uf = json['uf'];
    _ddd = json['ddd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cep'] = _cep;
    data['logradouro'] = _logradouro;
    data['bairro'] = _bairro;
    data['localidade'] = _localidade;
    data['uf'] = _uf;
    data['ddd'] = _ddd;
    return data;
  }
}
