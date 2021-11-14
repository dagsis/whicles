import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:vehicles_app/components/loader_component.dart';
import 'package:vehicles_app/helpers/constans.dart';

import 'package:http/http.dart' as http;
import 'package:vehicles_app/models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _emailError = '';
  bool _emailShowError = false;

  String _password = '';
  String _passwordError = '';
  bool _passwordShowError = false;

  bool _rememberme = true;
  bool _viewPassword = false;

  bool _showLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Color(0xFFFFEB3B),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                _showLogo(),
                SizedBox(
                  height: 20,
                ),
                _showEmail(),
                _showPassword(),
                _showRememberme(),
                //  _showForgotPassword(),
                _showButtons(),
              ],
            ),
          ),
          _showLoader
              ? LoaderComponent(text: 'Por favor espere...')
              : Container(),
        ],
      ),
    );
  }

  Widget _showLogo() {
    return Image(
      image: AssetImage('assets/vehicles_logo.png'),
      width: 300,
    );
  }

  Widget _showEmail() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        autofocus: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Ingrese su email...',
            labelText: 'Email',
            errorText: _emailShowError ? _emailError : null,
            prefixIcon: Icon(Icons.alternate_email),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: Icon(Icons.email)),
        onChanged: (value) {
          _email = value;
        },
      ),
    );
  }

  Widget _showPassword() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        obscureText: !_viewPassword,
        decoration: InputDecoration(
          hintText: 'Ingrese su password...',
          labelText: 'Password',
          prefixIcon: Icon(Icons.lock),
          errorText: _passwordShowError ? _passwordError : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: IconButton(
            icon: _viewPassword
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                _viewPassword = !_viewPassword;
              });
            },
          ),
        ),
        onChanged: (value) {
          _password = value;
        },
      ),
    );
  }

  Widget _showRememberme() {
    return CheckboxListTile(
        title: Text('Recordarme'),
        value: _rememberme,
        onChanged: (value) {
          setState(() {
            _rememberme = value!;
          });
        });
  }

  Widget _showButtons() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                _login();
              },
              child: Text('Iniciar Sesión'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return Color(0xFF120E43);
                }),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Nuevo Usuario'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return Color(0xFFE03B8B);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _login() async {
    setState(() {
      // _viewPassword = true;
    });

    if (!_validateFields()) {
      return;
    }

    setState(() {
      _showLoader = true;
    });

    Map<String, dynamic> request = {
      'email': _email,
      'password': _password,
    };

    var url = Uri.parse('${Constans.apiUrl}v1/identity/authentication');
    var response = await http.post(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
      body: jsonEncode(request),
    );

    setState(() {
      _showLoader = false;
    });

    if (response.statusCode >= 400) {
      setState(() {
        _passwordShowError = true;
        _passwordError = "Email o contraseña incorrectos";
      });
      return;
    }

    var body = response.body;

    var decodedJson = jsonDecode(body);
    var token = Token.fromJson(decodedJson);
  }

  bool _validateFields() {
    bool isValid = true;
    _emailShowError = false;

    if (_email.isEmpty) {
      isValid = false;
      _emailShowError = true;
      _emailError = "Ingrese su email";
    } else if (!EmailValidator.validate(_email)) {
      isValid = false;
      _emailShowError = true;
      _emailError = "Ingrese un mail valido";
    }

    if (_password.isEmpty) {
      isValid = false;
      _passwordShowError = true;
      _passwordError = "Ingrese su contraseña";
    } else if (_password.length < 6) {
      isValid = false;
      _passwordShowError = true;
      _passwordError = "Debe ingresar una contrasela de al menos 6 caracteres";
    } else {
      _passwordShowError = false;
    }

    setState(() {});
    return isValid;
  }
}
