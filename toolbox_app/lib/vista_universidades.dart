import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VistaUniversidades extends StatefulWidget {
  @override
  _VistaUniversidadesState createState() => _VistaUniversidadesState();
}

class _VistaUniversidadesState extends State<VistaUniversidades> {
  TextEditingController _paisController = TextEditingController();
  List<Universidad> _listaUniversidades = [];

  void obtenerUniversidades() async {
    String pais = _paisController.text.trim();
    if (pais.isNotEmpty) {
     
      // Crear la instancia de Uri
      Uri universidadesUri = Uri.parse('http://universities.hipolabs.com/search?country=$pais');

      // Realizar la llamada a la API
      final response = await http.get(universidadesUri);

      if (response.statusCode == 200) {
        // Limpiar la lista antes de agregar nuevas universidades
        _listaUniversidades.clear();

        // Analizar la respuesta JSON
        List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

        // Crear instancias de Universidad y agregar a la lista
        for (var universidadData in data) {
          Universidad universidad = Universidad.fromJson(universidadData);
          _listaUniversidades.add(universidad);
        }

        // Actualizar la interfaz
        setState(() {});
      } else {
        // Manejar errores de la llamada a la API
        print('Error al obtener la lista de universidades');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universidades por País'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _paisController,
              decoration: InputDecoration(
                labelText: 'Ingrese el nombre del país en inglés',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: obtenerUniversidades,
              child: Text('Obtener Universidades'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _listaUniversidades.length,
                itemBuilder: (context, index) {
                  Universidad universidad = _listaUniversidades[index];
                  return ListTile(
                    title: Text(universidad.nombre),
                    subtitle: Text('Dominio: ${universidad.dominio}\nEnlace: ${universidad.enlace}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Universidad {
  final String nombre;
  final String dominio;
  final String enlace;

  Universidad({
    required this.nombre,
    required this.dominio,
    required this.enlace,
  });

  factory Universidad.fromJson(Map<String, dynamic> json) {
    return Universidad(
      nombre: json['name'] ?? 'Sin nombre',
      dominio: json['domains'] != null ? json['domains'][0] ?? 'Sin dominio' : 'Sin dominio',
      enlace: json['web_pages'] != null ? json['web_pages'][0] ?? 'Sin enlace' : 'Sin enlace',
    );
  }
}
