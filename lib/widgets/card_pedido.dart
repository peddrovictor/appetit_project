import 'package:appetit_app/utils/constants.dart';
import 'package:flutter/material.dart';

///
/// Created by Thasciano Carvalho on 29/10/2019.
/// thasciano@gmail.com
///
class CardPedido extends StatelessWidget {

  final String imagem;
  final String titulo;
  final String subTitulo;
  final double valor;
  final bool selecionado;
  final Function onPress;
  final bool hasTrailing;

  CardPedido(this.imagem, this.titulo, this.subTitulo, this.valor, this.hasTrailing, this.selecionado, this.onPress);

  TextStyle getEstiloTitulo(){
    return TextStyle(
        fontSize: 16,
        color: this.selecionado ? Colors.white : Constants.primary_text,
        fontWeight: FontWeight.w600
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      color: selecionado ? Constants.primary_color : Colors.white,
      elevation: 1.0,
      child: ListTile(
        onTap: onPress,
        leading: Image.network(imagem, width: 40, height: 40,),
        title: _titulo(),
        subtitle: subTitulo != null? Text(subTitulo,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, color: this.selecionado ? Colors.white : Constants.secondary_text, )) : null,
        trailing: valor == null ? null : hasTrailing ? Text("R\$ ${valor}",
            textAlign: TextAlign.end,
            style: getEstiloTitulo()) : null,
      ),
    );
  }

  Widget _titulo() {
    return hasTrailing ? Text(titulo,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: getEstiloTitulo()):
      Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(titulo, maxLines: 1, overflow: TextOverflow.ellipsis, style: getEstiloTitulo()),
          ),
          Expanded(
            flex: 2,
            child: Text("R\$ ${valor}", textAlign: TextAlign.end, style: getEstiloTitulo()),
          )
        ],
      );
  }
}
