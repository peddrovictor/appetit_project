import 'package:appetit_app/utils/constants.dart';
import 'package:flutter/material.dart';

///
/// Created by Thasciano Carvalho on 01/11/2019.
/// thasciano@gmail.com
///
class CabecalhoPage extends StatelessWidget {

  String titulo;
  String descricao;

  CabecalhoPage(this.titulo, this.descricao);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 8),
          child: Text(titulo,
              style: TextStyle(fontSize: 24, color: Constants.primary_color)),
        ),
        Container(width: 240, height: 2,color: Constants.verde,),

        descricao.length > 0 ? Container(
            margin: EdgeInsets.only(top:16),
            child: Text(descricao, textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16, color: Constants.secondary_text))) : Container()
      ],
    );
  }
}
