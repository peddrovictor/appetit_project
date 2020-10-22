import 'package:appetit_app/pages/historico_de_pedidos.dart';
import 'package:appetit_app/pages/realizar_pedido.dart';
import 'package:appetit_app/utils/constants.dart';
import 'package:appetit_app/utils/nav.dart';
import 'package:appetit_app/widgets/main_button.dart';
import 'package:flutter/material.dart';

class FinalizarPedidoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.all(16),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/pedido_finalizado.png",
                      width: 230,
                      height: 200,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 24),
                      child: Text("Pedido realizado!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24, color: Constants.primary_text)),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
//                      margin: EdgeInsets.only(top:84),
                      child: OrangeButton(
                          'FAZER UM NOVO PEDIDO', 14.0, Constants.primary_color,
                          () {
                        push(context, NovoPedidoPage(), true);
                      }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      width: MediaQuery.of(context).size.width,
                      child: OrangeButton(
                          'VOLTAR PARA PÁGINA INICIAL', 14.0, Constants.verde,
                          () {
                        push(context, HistoricoPedidosPage(), true);
                      }),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
