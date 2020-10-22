import 'package:appetit_app/domain/models/categoria_produto.dart';
import 'package:appetit_app/utils/constants.dart';
import 'package:appetit_app/utils/nav.dart';
import 'package:appetit_app/widgets/cabecalho_page.dart';
import 'package:flutter/material.dart';

class DetalhesPedidoPage extends StatefulWidget {
  Produtos produtos;
  DetalhesPedidoPage(this.produtos);
  @override
  _DetalhesPedidoPageState createState() {
    return _DetalhesPedidoPageState(this.produtos);
  }
}

class _DetalhesPedidoPageState extends State<DetalhesPedidoPage> {
  Produtos produtos;

  _DetalhesPedidoPageState(this.produtos);

  String tag;

  List<String> _texts = [
    "Cuscuz de milho",
    "Cuscuz de arroz",
  ];
  int _currentIndex = 0;

  OutlineInputBorder bordasInputText = new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(4.0),
      borderSide: new BorderSide(width: 1, color: Colors.white));

  @override
  Widget build(BuildContext context) {
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
            pop(context);
          },
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 68),
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CabecalhoPage("Detalhes do pedido",
                      "caso queira, aproveite para adicionar alguma observação para este pedido."),
                  Container(
                    margin: EdgeInsets.only(bottom: 24, top: 24),
                    height: 72,
                    child: Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: Image.asset(
                          "assets/images/logo.png",
                          width: 40,
                          height: 40,
                        ),
                        title: Text(produtos.nome,
                            style: TextStyle(
                                fontSize: 16,
                                color: Constants.primary_text,
                                fontWeight: FontWeight.w600)),
                        subtitle: produtos.descricao != null
                            ? Text(produtos.descricao,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Constants.secondary_text,
                                ))
                            : null,
                        trailing: Text("R\$ ${produtos.valor}",
                            style: TextStyle(
                                fontSize: 16,
                                color: Constants.primary_text,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.black12,
                  ),
                  Visibility(
                    visible: produtos.descricao != null ? true : false,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 24),
                          child: Text("Opções",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Constants.primary_text,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Container(
                            child: Text(
                                "Escolha uma das opções de massas disponíveis abaixo:",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Constants.secondary_text))),
                        Wrap(
                          children: <Widget>[
                            ListView.builder(
                                itemCount: _texts.length,
                                padding: EdgeInsets.all(0.0),
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    color: Colors.white,
                                    child: ListTile(
                                        title: RadioListTile(
                                      groupValue: _currentIndex,
                                      title: Text("${_texts[index]}"),
                                      value: index,
                                      onChanged: (val) {
                                        setState(() {
                                          _currentIndex = index;
                                        });
                                      },
                                      activeColor: Constants.primary_color,
                                    )),
                                  );
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Text("Observações",
                        style: TextStyle(
                            fontSize: 16,
                            color: Constants.primary_text,
                            fontWeight: FontWeight.w600)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 32),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Deseja adicionar alguma observação?',
                        hintText: "Deseja adicionar alguma observação?",
                        filled: true,
                        fillColor: Colors.white,
                        border: bordasInputText,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        __bottonOptions()
      ],
    );
  }

  Widget __bottonOptions() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        height: 68,
        decoration: BoxDecoration(
            color: Colors.white,
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
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          produtos.quantidade -= 1;
                        });
                      },
                      child: Text(
                        "-",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 32),
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "${produtos.quantidade}",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          produtos.quantidade += 1;
                        });
                      },
                      child: Icon(Icons.add))
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: RaisedButton(
                onPressed: () {
                  pop(context, produtos.quantidade);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(2.0)),
                color: Constants.primary_color,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Adicionar",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    Text(
                        "R\$ ${(produtos.valor * produtos.quantidade).toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
