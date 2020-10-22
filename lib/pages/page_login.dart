import 'package:appetit_app/pages/historico_de_pedidos.dart';
import 'package:appetit_app/utils/constants.dart';
import 'package:appetit_app/utils/nav.dart';
import 'package:appetit_app/widgets/main_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool obscureText = true;
  var _textPasswordController = TextEditingController();
  var _textEmailController = TextEditingController();

  @override
  void initState() {
    _textPasswordController.addListener(() {
      setState(() {
        password = _textPasswordController.text;
      });
    });
    _textEmailController.addListener(() {
      setState(() {
        email = _textEmailController.text;
      });
    });
    super.initState();
  }

  OutlineInputBorder bordasInputText = new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(4.0),
      borderSide: new BorderSide(width: 1, color: Constants.primary_color));

  void _showPassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 80),
              child: Image.asset("assets/images/logo.png",
                  width: 112, height: 80)),
          Container(
            margin: EdgeInsets.only(top: 72),
            child: Text("Seja bem-vindo!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Constants.primary_color)),
          ),
          Container(
              margin: EdgeInsets.only(top: 16),
              child: Text(
                  "Nós sabemos a importância de estar sempre de barriga cheia e o quanto isso pode ajudar no seu dia.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16, color: Constants.secondary_text))),
          _formulario(context),
        ],
      ),
    );
  }

  Form _formulario(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 32),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              controller: _textEmailController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por Favor, Entre com algum texto';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'E-mail',
                hintText: "Insira seu e-mail aqui",
                filled: true,
                fillColor: Colors.white,
                border: bordasInputText,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 32),
            child: TextFormField(
              obscureText: obscureText,
              controller: _textPasswordController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Insira um texto, por favor';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Senha',
                hintText: 'Insira a sua senha aqui',
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                    icon: obscureText
                        ? Icon(
                            Icons.remove_red_eye,
                            color: Constants.primary_color,
                          )
                        : Image.asset("assets/images/password.png"),
                    onPressed: () {
                      _showPassword();
                    }),
                border: bordasInputText,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            width: MediaQuery.of(context).size.width,
            child: OrangeButton(
                'ENTRAR',
                20.0,
                (email.isNotEmpty && password.isNotEmpty)
                    ? Constants.primary_color
                    : Constants.primary_color_opacite, () {
              if (_formKey.currentState.validate())
                push(context, HistoricoPedidosPage(), true);
            }),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textPasswordController.dispose();
    _textEmailController.dispose();
    super.dispose();
  }
}
