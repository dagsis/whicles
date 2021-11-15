import 'package:flutter/material.dart';
import 'package:vehicles_app/models/user.dart';

class HomePage extends StatefulWidget {
  final Token token;

  HomePage({required this.token});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Veicles'),
      ),
      body: _getBody(),
      drawer: _getAdminMenu(),
    );
  }

  Widget _getBody() {
    return Container(
      margin: EdgeInsets.all(30),
      child: Center(
        child: Text(
          'Bienvenido ${widget.token.name}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _getAdminMenu() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Image(
              image: AssetImage('assets/vehicles_logo.png'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.two_wheeler),
            title: const Text('Marcas'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => BrandsScreen(token: widget.token,)
              //   )
              // );
            },
          ),
        ],
      ),
    );
  }
}
