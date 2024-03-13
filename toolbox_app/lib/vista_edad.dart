import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VistaEdad extends StatefulWidget {
  @override
  _VistaEdadState createState() => _VistaEdadState();
}

class _VistaEdadState extends State<VistaEdad> {
  TextEditingController _nombreController = TextEditingController();
  String _mensajeEdad = '';
  int _edad = 0;

void determinarEdad() async {
  String nombre = _nombreController.text;
  if (nombre.isNotEmpty) {
    // Realizar la llamada a la API
    final response = await http.get(Uri.parse('https://api.agify.io/?name=$nombre'));

    if (response.statusCode == 200) {
      // Analizar la respuesta JSON
      Map<String, dynamic>? data = json.decode(response.body);

      // Verificar si 'age' está presente y no es nulo
      if (data != null && data.containsKey('age') && data['age'] != null) {
        // Obtener la edad y actualizar el mensaje
        int edad = data['age'];
        setState(() {
          _edad = edad;
          _mensajeEdad = _calcularMensajeEdad(edad);
        });
      } else {
        // Manejar el caso en el que 'age' es nulo
        setState(() {
          _mensajeEdad = 'No se pudo determinar la edad';
        });
      }
    } else {
      // Manejar errores de la llamada a la API
      print('Error al obtener la predicción de edad');
      setState(() {
        _mensajeEdad = 'Error al obtener la predicción de edad';
      });
    }
  }
}


  String _calcularMensajeEdad(int edad) {
    if (edad <= 25) {
      return 'Eres joven';
    } else if (edad <= 60) {
      return 'Usted es un adulto';
    } else {
      return 'Usted es un anciano';
    }
  }

  Widget _buildImagesBasedOnAge() {
    if (_edad > 0) {
      if (_edad <= 25) {
        return Image.asset('assets/joven.jpg', height: 100);
      } else if (_edad <= 60) {
        return Image.asset('assets/adulto.png', height: 100);
      } else {
        return Image.asset('assets/anciano.png', height: 100);
      }
    } else {
      return Container(); // Widget vacío si la edad es <= 0
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Determinar Edad'),
      ),
      body: Container(
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
              onPressed: determinarEdad,
              child: Text('Determinar Edad'),
            ),
            SizedBox(height: 20),
            Text(
              _mensajeEdad,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            if (_edad > 0) // Mostrar la edad solo si es mayor que cero
              Text(
                'Edad: $_edad años',
                style: TextStyle(fontSize: 18),
              ),
            SizedBox(height: 20),
            // Muestra la imagen solo si la edad es mayor que cero
            _buildImagesBasedOnAge(),
          ],
        ),
      ),
    );
  }
}
