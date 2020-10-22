import 'dart:convert';

class Cliente {
  int id;
  String nome;
  String imagem;
  bool selecionado;

  Cliente({
    this.id,
    this.nome,
    this.imagem,
    this.selecionado,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json["id"],
      nome: json["nome"],
      imagem: json["imagem"],
      selecionado: json["selecionado"],
    );
  }

  String toJson() => json.encode(toMap());

  factory Cliente.fromMap(Map<String, dynamic> json) => Cliente(
        id: json["id"] == null ? null : json["id"],
        nome: json["nome"] == null ? null : json["nome"],
        imagem: json["imagem"] == null ? null : json["imagem"],
        selecionado: json["selecionado"] == null ? null : json["selecionado"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "nome": nome == null ? null : nome,
        "imagem": imagem == null ? null : imagem,
        "selecionado": selecionado == null ? null : selecionado,
      };
}
