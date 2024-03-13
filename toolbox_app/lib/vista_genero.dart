import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VistaGenero extends StatefulWidget {
  @override
  _VistaGeneroState createState() => _VistaGeneroState();
}

class _VistaGeneroState extends State<VistaGenero> {
  TextEditingController _nombreController = TextEditingController();
  Color _backgroundColor = Colors.white; // Por defecto
  String _generoPredicho = ''; // Nuevo

  void predecirGenero() async {
    String nombre = _nombreController.text;
    if (nombre.isNotEmpty) {
      // Realizar la llamada a la API
      Uri generoUri = Uri.parse('https://api.genderize.io/?name=$nombre');
      final response = await http.get(generoUri);

      if (response.statusCode == 200) {
        // Analizar la respuesta JSON
        Map<String, dynamic> data = json.decode(response.body);

        // Verificar el género y actualizar el fondo y el género predicho
        setState(() {
          _backgroundColor = (data['gender'] == 'male') ? Color.fromARGB(255, 151, 197, 235) : Color.fromARGB(255, 252, 134, 173);
          _generoPredicho = (data['gender'] == 'male') ? 'Masculino' : 'Femenino';
        });
      } else {
        // Manejar errores de la llamada a la API
        print('Error al obtener la predicción de género');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Género'),
      ),
      body: Container(
        color: _backgroundColor,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Ingrese el nombre',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: predecirGenero,
              child: Text('Predecir Género'),
            ),
            SizedBox(height: 20), // Espacio adicional
            if (_generoPredicho.isNotEmpty) // Agregado condicionalmente
              Text(
                'Género predicho: $_generoPredicho',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
