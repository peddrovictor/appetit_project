import 'package:appetit_app/utils/constants.dart';
import 'package:appetit_app/utils/nav.dart';
import 'package:appetit_app/widgets/cabecalho_page.dart';
import 'package:appetit_app/widgets/card_pedido.dart';
import 'package:flutter/material.dart';

import 'realizar_pedido.dart';

class HistoricoPedidosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.background,
        elevation: 0.0,
      ),
      body: SafeArea(child: _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CabecalhoPage("Olá, Alessandra!", ""),
            GestureDetector(
                onTap: () {
                  push(context, NovoPedidoPage(), false);
                },
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 24),
                  elevation: 4.0,
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(
                      Icons.add,
                      size: 24,
                      color: Constants.primary_color,
                    ),
                    title: Text(
                      "Realizar novo pedido:",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                )),
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
            Wrap(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 16, top: 24),
                  child: Text("Em 23/10 você vendeu R\$ 11,00",
                      style: TextStyle(
                          fontSize: 16,
                          color: Constants.primary_text,
                          fontWeight: FontWeight.w600)),
                ),
                ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0.0),
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return CardPedido(
                          "https://www.publicdomainpictures.net/pictures/300000/nahled/woman-with-coffee-1557828816sIl.jpg",
                          "Hanna Montana",
                          "1 Cuscuz com carne seca e queijo",
                          5.50,
                          false,
                          false,
                          null);
                    }),
                Container(
                  margin: EdgeInsets.only(bottom: 16, top: 24),
                  child: Text("Em 22/10 você vendeu R\$ 22,00",
                      style: TextStyle(
                          fontSize: 16,
                          color: Constants.primary_text,
                          fontWeight: FontWeight.w600)),
                ),
                ListView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0.0),
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return CardPedido(
                          "https://www.publicdomainpictures.net/pictures/300000/nahled/woman-with-coffee-1557828816sIl.jpg",
                          "Hanna Montana",
                          "2x salgado, 1x pão de queijo",
                          5.50,
                          false,
                          false,
                          null);
                    }),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
