import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class VistaClima extends StatefulWidget {
  @override
  _VistaClimaState createState() => _VistaClimaState();
}

class _VistaClimaState extends State<VistaClima> {
  WeatherFactory wf = WeatherFactory("92050666fb7c936344f82c3d15a53b36");
  double lat = 55.0111;
  double lon = 15.0569;
  String cityName = 'Dominican Republic';
  Weather? _clima;

  void obtenerClima() async {
    try {
      // Obtener datos meteorológicos
      _clima = await wf.currentWeatherByLocation(lat, lon);
      // Actualizar la interfaz
      setState(() {});
    } catch (e) {
      print('Error al obtener datos meteorológicos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima Actual'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.blueGrey[100], // Cambié el color de fondo a un tono de gris-azul
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: obtenerClima,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Cambié el color del botón a azul
                ),
                child: Text(
                  'Obtener Clima',
                  style: TextStyle(
                    color: Colors.white, // Cambié el color del texto del botón a blanco
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (_clima != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fecha: ${_clima!.date}'),
                    Text('Condiciones: ${_clima!.weatherDescription}'),
                    Text('Temperatura: ${_clima!.temperature?.celsius}°C'),
                    Text('Mínima: ${_clima!.tempMin?.celsius}°C'),
                    Text('Máxima: ${_clima!.tempMax?.celsius}°C'),
                    Text('Sensación Térmica: ${_clima!.tempFeelsLike?.celsius}°C'),
                    Text('Salida del Sol: ${_clima!.sunrise}'),
                    Text('Puesta del Sol: ${_clima!.sunset ?? 'N/A'}'),
                  ],
                )
              else
                Text(
                  'Presiona "Obtener Clima" para cargar los datos.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
