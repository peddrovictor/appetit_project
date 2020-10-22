import 'package:appetit_app/domain/blocs/pedido_bloc.dart';
import 'package:appetit_app/domain/models/categoria_produto.dart';
import 'package:appetit_app/domain/models/cliente.dart';
import 'package:appetit_app/pages/detalhes_pedido.dart';
import 'package:appetit_app/pages/finalizar_pedido.dart';
import 'package:appetit_app/utils/constants.dart';
import 'package:appetit_app/utils/nav.dart';
import 'package:appetit_app/widgets/cabecalho_page.dart';
import 'package:appetit_app/widgets/card_pedido.dart';
import 'package:appetit_app/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NovoPedidoPage extends StatefulWidget {
  @override
  _NovoPedidoPageState createState() => _NovoPedidoPageState();
}

class _NovoPedidoPageState extends State<NovoPedidoPage> {
  int _clientePagou = 0;
  DateTime dt = null;

  final _blocPedido = PedidoBloc();

  @override
  void initState() {
    super.initState();
    _blocPedido.fetch(context);
  }

  @override
  void dispose() {
    _blocPedido.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _blocPedido.getPage,
        initialData: 1,
        builder: (context, page) {
          return StreamBuilder(
              stream: _blocPedido.getMarginBotton,
              initialData: 0.0,
              builder: (context, snapshotMarginBotton) {
                return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Constants.background,
                      elevation: 0.0,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Constants.primary_color,
                        ),
                        onPressed: () {
                          var teste = _blocPedido.changePage(-1);
                          if (teste == 0) return pop(context);
                        },
                      ),
                    ),
                    body: SafeArea(
                      child: _body(page.data, snapshotMarginBotton.data),
                    ),
                    floatingActionButton: _floatingActionButtonPageTwo(
                        page.data, snapshotMarginBotton.data));
              });
        });
  }

  Widget _floatingActionButtonPageTwo(int page, double marginBotton) {
    if (page == 2) {
      return Container(
        margin: EdgeInsets.only(bottom: marginBotton), //56
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
          backgroundColor: Constants.primary_color,
        ),
      );
    } else
      return null;
  }

  Widget _body(int page, double marginBotton) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: marginBotton), //56
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              Column(
                children: <Widget>[
                  CabecalhoPage("Informações para o pedido",
                      "Preencha as informações abaixo para concluir o pedido."),
                  _progress(page),
                  _getCategoriasProdutosStream(page),
                ],
              ),
            ],
          ),
        ),
        _bottonOptions()
      ],
    );
  }

  /// Container
  Column _progress(int page) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 8, top: 24),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Text("O que você está vendendo?",
                    style: TextStyle(
                        fontSize: 16,
                        color: Constants.primary_text,
                        fontWeight: FontWeight.w600)),
              ),
              Expanded(
                  flex: 1,
                  child: Text("${page ?? 1} de 3",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 16, color: Constants.secondary_text)))
            ],
          ),
        ),
        StreamBuilder(
            stream: _blocPedido.getProgresso,
            initialData: 33.0,
            builder: (context, snapshotProg) {
              return LinearProgressIndicator(
                backgroundColor: Colors.black12,
                value: snapshotProg.data,
                valueColor:
                    AlwaysStoppedAnimation<Color>(Constants.primary_color),
              );
            }),
      ],
    );
  }

  StreamBuilder<List<Categoria>> _getCategoriasProdutosStream(int page) {
    return StreamBuilder(
        stream: _blocPedido.getCategoriasProdutos,
        builder: (context, snapshotCatPro) {
          if (snapshotCatPro.hasData) {
            return _getClienteStream(page, snapshotCatPro);
          } else if (snapshotCatPro.hasError) {
            return Text("Erro ao converter!");
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  StreamBuilder<List<Cliente>> _getClienteStream(
      int page, AsyncSnapshot snapshotCatPro) {
    return StreamBuilder(
        stream: _blocPedido.getClientes,
        builder: (context, snapshotClien) {
          if (snapshotClien.hasData) {
            return _getPage(page, snapshotCatPro.data, snapshotClien.data);
          } else if (snapshotClien.hasError) {
            return Text("Erro ao converter!");
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget _getPage(
      int page, List<Categoria> categorias, List<Cliente> clientes) {
    switch (page) {
      case 1:
        return _pageItensPedido(categorias);
      case 2:
        return _pageClientes(clientes);
      case 3:
        return _pageFinalizarPedido();
    }
  }

  Widget _bottonOptions() {
    return StreamBuilder(
        stream: _blocPedido.getOptions,
        initialData: false,
        builder: (context, snapshotOptions) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              height: snapshotOptions.data ? 56.0 : 0.0,
              decoration: BoxDecoration(
                  color: Constants.primary_color,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4.0,
                    )
                  ]),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: StreamBuilder(
                          stream: _blocPedido.getQtdClientesSelecionados,
                          initialData: "",
                          builder: (context, snapshotCliSel) {
                            return Text(
                              snapshotCliSel.data,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            );
                          })),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        _blocPedido.changePage(1);
                        _blocPedido.setOptions(false);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("Avançar",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _pageItensPedido(List<Categoria> categoria) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Digite a sua busca aqui',
            fillColor: Colors.orange,
            prefixIcon: Icon(
              Icons.search,
              color: Constants.primary_color,
            ),
          ),
        ),
        _listCategoria(categoria)
      ],
    );
  }

  Wrap _listCategoria(List<Categoria> categorias) {
    return Wrap(
      children: <Widget>[
        ListView.builder(
            itemCount: categorias.length,
            padding: EdgeInsets.all(0.0),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int indexC) {
              return Wrap(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 16, top: 24),
                    child: Text(categorias[indexC].nome,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16,
                            color: Constants.primary_text,
                            fontWeight: FontWeight.w600)),
                  ),
                  ListView.builder(
                      itemCount: categorias[indexC].listProdutos.length,
                      padding: EdgeInsets.all(0.0),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int indexP) {
                        return CardPedido(
                            categorias[indexC].listProdutos[indexP].imagem,
                            categorias[indexC].listProdutos[indexP].nome,
                            categorias[indexC].listProdutos[indexP].descricao,
                            categorias[indexC].listProdutos[indexP].valor,
                            true,
                            categorias[indexC].listProdutos[indexP].selecionado,
                            () async {
                          push(
                                  context,
                                  DetalhesPedidoPage(
                                      categorias[indexC].listProdutos[indexP]),
                                  false)
                              .then((result) {
                            _blocPedido.selecionarProduto(
                                indexC, indexP, result);
                          });
                        });
                      }),
                  if (indexC + 1 != categorias.length)
                    Container(
                        margin: EdgeInsets.only(top: 24),
                        child: Divider(
                          height: 1,
                          color: Colors.black12,
                        )),
                ],
              );
            }),
      ],
    );
  }

  Widget _pageClientes(List<Cliente> clientes) {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Digite a sua busca aqui',
            fillColor: Colors.orange,
            prefixIcon: Icon(
              Icons.search,
              color: Constants.primary_color,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 16, top: 24),
          alignment: Alignment.centerLeft,
          child: Text("Meus Clientes",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 16,
                  color: Constants.primary_text,
                  fontWeight: FontWeight.w600)),
        ),
        Wrap(
          children: <Widget>[_listaClientes(clientes)],
        ),
      ],
    );
  }

  ListView _listaClientes(List<Cliente> clientes) {
    return ListView.builder(
        itemCount: clientes.length,
        padding: EdgeInsets.all(0.0),
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return CardPedido(clientes[index].imagem, clientes[index].nome, null,
              null, true, clientes[index].selecionado, () {
            _blocPedido.selecionarCliente(index);
            _blocPedido.setOptions(true);
            return true;
          });
        });
  }

  Widget _pageFinalizarPedido() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 16, top: 24),
          child: Text("O cliente já pagou?",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 16,
                  color: Constants.primary_text,
                  fontWeight: FontWeight.w600)),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
              title: RadioListTile(
            groupValue: _clientePagou,
            title: Text("Sim"),
            value: 1,
            onChanged: (val) {
              setState(() {
                _clientePagou = 1;
              });
            },
            activeColor: Constants.primary_color,
          )),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
              title: RadioListTile(
            groupValue: _clientePagou,
            title: Text("Não"),
            value: 0,
            onChanged: (val) {
              setState(() {
                _clientePagou = 0;
              });
            },
            activeColor: Constants.primary_color,
          )),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 16, top: 24),
          child: Text("Em que data o pedido foi realizado?",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 16,
                  color: Constants.primary_text,
                  fontWeight: FontWeight.w600)),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: Icon(
              Icons.calendar_today,
              size: 20,
              color: Constants.primary_text,
            ),
            title: Text(dt != null
                ? DateFormat('dd/MM/yyyy').format(dt)
                : "Selecione uma data"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Constants.primary_color,
            ),
            onTap: () async {
              final DateTime picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: new DateTime(1999),
                lastDate: new DateTime.now(),
              );
              setState(() {
                dt = picked;
              });
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 78),
          width: MediaQuery.of(context).size.width,
          child:
              OrangeButton('FINALIZAR PEDIDO', 14, Constants.primary_color, () {
            push(context, FinalizarPedidoPage(), false);
          }),
        ),
      ],
    );
  }
}
