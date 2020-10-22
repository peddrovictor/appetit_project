class Categoria {
    int id;
    List<Produtos> listProdutos;
    String nome;

    Categoria({this.id, this.listProdutos, this.nome});

    factory Categoria.fromJson(Map<String, dynamic> json) {
        return Categoria(
            id: json['id'],
            listProdutos: json['list_produtos'] != null ? (json['list_produtos'] as List).map((i) => Produtos.fromJson(i)).toList() : null,
            nome: json['nome'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['nome'] = this.nome;
        if (this.listProdutos != null) {
            data['list_produtos'] = this.listProdutos.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Produtos {
    String descricao;
    int id;
    int quantidade;
    String imagem;
    String nome;
    List<Opcao> opcao;
    bool selecionado;
    double valor;

    Produtos({this.descricao, this.id, this.quantidade, this.imagem, this.nome, this.opcao, this.selecionado, this.valor});

    factory Produtos.fromJson(Map<String, dynamic> json) {
        return Produtos(
            descricao: json['descricao'],
            id: json['id'],
            quantidade: json['quantidade'],
            imagem: json['imagem'],
            nome: json['nome'],
            opcao: json['opcao'] != null ? (json['opcao'] as List).map((i) => Opcao.fromJson(i)).toList() : null,
            selecionado: json['selecionado'],
            valor: json['valor'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['descricao'] = this.descricao;
        data['id'] = this.id;
        data['quantidade'] = this.quantidade;
        data['imagem'] = this.imagem;
        data['nome'] = this.nome;
        data['selecionado'] = this.selecionado;
        data['valor'] = this.valor;
        if (this.opcao != null) {
            data['opcao'] = this.opcao.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Opcao {
    String nome;

    Opcao({this.nome});

    factory Opcao.fromJson(Map<String, dynamic> json) {
        return Opcao(
            nome: json['nome'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['nome'] = this.nome;
        return data;
    }
}