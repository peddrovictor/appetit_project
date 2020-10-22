import 'dart:async';
import 'dart:convert';

import 'package:appetit_app/domain/models/categoria_produto.dart';
import 'package:appetit_app/domain/models/cliente.dart';
import 'package:flutter/material.dart';

class PedidoBloc {
  final _clientesSC = StreamController<List<Cliente>>();
  final _qtdClientesSC = StreamController<String>();
  final _categoriaProdutosSC = StreamController<List<Categoria>>();
  final _pageSC = StreamController<int>();
  final _progressoSC = StreamController<double>();
  final _optionsSC = StreamController<bool>();
  final _marginBottonSC = StreamController<double>();

  Stream<List<Cliente>> get getClientes => _clientesSC.stream;

  List<Categoria> _listCategorias;
  Stream<List<Categoria>> get getCategoriasProdutos =>
      _categoriaProdutosSC.stream;
  List<Cliente> _listClientes;
  Stream<String> get getQtdClientesSelecionados => _qtdClientesSC.stream;

  get setQtdClientesSelecionados => _qtdClientesSC.sink.add;
  int page = 1;
  get getPage => _pageSC.stream;
  get setPage => _pageSC.sink.add;

  Stream<double> get getProgresso => _progressoSC.stream;

  Stream<bool> get getOptions => _optionsSC.stream;

  Stream<double> get getMarginBotton => _marginBottonSC.stream;
  get setMarginBotton => _marginBottonSC.sink.add;

  void fetch(BuildContext context) {
    _progressoSC.add(0.33);
    _pageSC.add(1);
    DefaultAssetBundle.of(context)
        .loadString('assets/json/clientes.json')
        .then((clientesString) {
      final data = json.decode(clientesString);
      _listClientes =
          data.map<Cliente>((json) => Cliente.fromJson(json)).toList();
      _clientesSC.add(_listClientes);
    });

    DefaultAssetBundle.of(context)
        .loadString('assets/json/produtos.json')
        .then((clientesString) {
      final data = json.decode(clientesString);
      _listCategorias =
          data.map<Categoria>((json) => Categoria.fromJson(json)).toList();
      _categoriaProdutosSC.add(_listCategorias);
    });
  }

  void setOptions(bool ative) {
    if (ative)
      setMarginBotton(56.0);
    else
      setMarginBotton(0.0);
    _optionsSC.sink.add(ative);
  }

  void selecionarProduto(int categoriaIndex, int produtoIndex, int quantidade) {
    _listCategorias[categoriaIndex].listProdutos[produtoIndex].selecionado =
        !_listCategorias[categoriaIndex].listProdutos[produtoIndex].selecionado;
    _listCategorias[categoriaIndex].listProdutos[produtoIndex].quantidade =
        quantidade;
    List<Produtos> _listProdutosSelecionados = List<Produtos>();
    double valorPagar = 0.0;
    for (var i = 0; i < _listCategorias.length; i++) {
      for (var j = 0; j < _listCategorias[i].listProdutos.length; j++) {
        if (_listCategorias[i].listProdutos[j].quantidade <= 0)
          _listCategorias[i].listProdutos[j].selecionado = false;

        if (_listCategorias[i].listProdutos[j].selecionado &&
            _listCategorias[i].listProdutos[j].quantidade > 0) {
          _listProdutosSelecionados.add(_listCategorias[i].listProdutos[j]);
          valorPagar += (_listCategorias[i].listProdutos[j].valor *
              _listCategorias[i].listProdutos[j].quantidade);
        }
      }
    }
    if (_listProdutosSelecionados.length > 0) {
      setOptions(true);
      _qtdClientesSC.add("Total: R\$ ${valorPagar.toStringAsFixed(2)}");
    } else
      setOptions(false);
    _categoriaProdutosSC.add(_listCategorias);
  }

  int changePage(int aux) {
    if (aux < 0) setOptions(true);
    this.page += aux;
    if (this.page < 1) return 0;
    _pageSC.add(this.page);

    switch (this.page) {
      case 1:
        _progressoSC.add(0.33);
        break;
      case 2:
        _progressoSC.add(0.66);
        break;
      case 3:
        _progressoSC.add(1);
        break;
    }
  }

  void selecionarCliente(int index) {
    _listClientes[index].selecionado = !_listClientes[index].selecionado;
    _clientesSC.add(_listClientes);
    int qtd = _listClientes.where((c) => c.selecionado == true).length;
    if (qtd > 0) {
      setOptions(true);
      _qtdClientesSC.add("$qtd cliente(s) selecionado(s)");
    } else {
      setOptions(false);
      _qtdClientesSC.add("0 cliente(s) selecionado(s)");
    }
  }

  void dispose() {
    _clientesSC.close();
    _categoriaProdutosSC.close();
    _qtdClientesSC.close();
    _clientesSC.close();
    _pageSC.close();
    _progressoSC.close();
    _optionsSC.close();
  }
}
