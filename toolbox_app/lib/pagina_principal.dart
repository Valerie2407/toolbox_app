import 'package:flutter/material.dart';
import 'vista_genero.dart';
import 'vista_edad.dart';
import 'vista_universidades.dart';
import 'vista_clima.dart';
import 'vista_wordpress.dart';
import 'vista_acerca_de.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({Key? key}) : super(key: key);

  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  int _paginaActual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toolbox App'),
        actions: [
          // Agrega acciones a la barra de aplicaciones si es necesario
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: IndexedStack(
            index: _paginaActual,
            children: [
              VistaGenero(),
              VistaEdad(),
              VistaUniversidades(),
              VistaClima(),
              VistaWordPress(),
              VistaAcercaDe(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _paginaActual,
        onTap: (index) {
          setState(() {
            _paginaActual = index;
          });
        },
        selectedItemColor: Color.fromARGB(255, 25, 89, 114),
        unselectedItemColor: Color.fromARGB(255, 93, 187, 211),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Género',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Edad',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Universidades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Clima',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.web),
            label: 'WordPress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Acerca de',
          ),
        ],
      ),
    );
  }
}
