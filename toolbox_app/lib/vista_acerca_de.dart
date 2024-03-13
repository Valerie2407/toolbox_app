import 'package:flutter/material.dart';

class VistaAcercaDe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de mí'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Alineación horizontal centrada
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Mostrar tu imagen
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/mi_foto.jpg'), // Asegúrate de tener la imagen en la carpeta 'assets'
              ),
              SizedBox(height: 16.0),

              // Mostrar tu nombre
              Text(
                'Valerie Lantigua De la Cruz',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),

              // Mostrar tu correo
              Text(
                'vlantiguadelacruz@gmail.com',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
