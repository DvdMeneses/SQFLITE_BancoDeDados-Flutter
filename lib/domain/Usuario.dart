class Usuario {
  static const String usuarioTable = "usuario_table";

  static const String idColumn = "id";

  static const String nomeColumn = "nome";
  static const String nacionalidadeColumn = "nacionalidade";
  static const String sexoColumn = "sexo";
  static const String idadeColumn = "idade";
  static const String racaColumn = "raca";
  static const String pesoColumn = "peso";

  int id = 0;

  String nome = '';
  String nacionalidade = '';
  String sexo = '';
  String raca = '';
  int peso = 0;
  int idade = 0;

  Usuario(this.nome, this.nacionalidade, this.idade, this.raca, this.peso,
      this.sexo);

  Usuario.fromMap(Map map) {
    id = map[idColumn];
    nome = map[nomeColumn];
    nacionalidade = map[nacionalidadeColumn];
    sexo = map[sexoColumn];
    raca = map[racaColumn];
    peso = map[pesoColumn];
    idade = map[idadeColumn];
  }

  Map<String, dynamic> toMap() {
    return {
      nomeColumn: nome,
      nacionalidadeColumn: nacionalidade,
      sexoColumn: sexo,
      racaColumn: raca,
      pesoColumn: peso,
      idadeColumn: idade
    };
  }

  @override
  String toString() {
    return 'Usuario{nome: $nome, nacionalidade: $nacionalidade, sexo: $sexo, raca: $raca, peso: $peso, idadeColumn: $idadeColumn}';
  }
}
