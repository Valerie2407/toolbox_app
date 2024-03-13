import 'package:flutter/material.dart';
import 'pagina_principal.dart';  // Asegúrate de importar el archivo de la página principal

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaginaPrincipal(), 
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();

    // Ocultar la imagen después de 4 segundos
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Contenido principal de la aplicación
          Container(
            color: Colors.white, // Puedes ajustar el color de fondo
            child: Center(
              child: Text(
                'Contenido principal de la aplicación',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),

          // Imagen de presentación (mostrada solo durante 4 segundos)
          Visibility(
            visible: _showSplash,
            child: Container(
              color: Colors.black, // Puedes ajustar el color de fondo de la imagen de presentación
              child: Center(
                child: Image.asset(
                  '/caja_herramientas.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}