import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class News {
  final String title;
  final String summary;
  final String url;

  News({required this.title, required this.summary, required this.url});
}

Future<List<News>> fetchNews() async {
  final response =
      await http.get(Uri.parse('https://blog.ted.com/wp-json/wp/v2/posts?per_page=3'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    return data.map((post) {
      return News(
        title: post['title']['rendered'],
        summary: post['excerpt']['rendered'],
        url: post['link'],
      );
    }).toList();
  } else {
    throw Exception('No se pudieron cargar las noticias');
  }
}

class NewsCard extends StatelessWidget {
  final News news;

  NewsCard({required this.news});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mostrar el logo de la página encima del título
            Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/TED_three_letter_logo.svg/324px-TED_three_letter_logo.svg.png?20160620081926'),

            SizedBox(height: 8.0),

            Text(
              news.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8.0),

            // Usar un tipo de letra diferente para los resúmenes
            Text(
              stripHtmlTags(news.summary),
              style: TextStyle(fontSize: 14, fontFamily: 'Montserrat'),
            ),

            SizedBox(height: 16.0),

            ElevatedButton(
              onPressed: () {
                launchURL(news.url);
              },
              child: Text('Visitar'),
            ),
          ],
        ),
      ),
    );
  }

  String stripHtmlTags(String htmlString) {
    return htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  void launchURL(String url) {
    // Implementar la lógica para abrir el enlace
  }
}

class VistaWordPress extends StatefulWidget {
  @override
  _VistaWordPressState createState() => _VistaWordPressState();
}

class _VistaWordPressState extends State<VistaWordPress> {
  late Future<List<News>> _news;

  @override
  void initState() {
    super.initState();
    _news = fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Últimas Noticias TED'),
      ),
      body: FutureBuilder(
        future: _news,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar las noticias'));
          } else if (!snapshot.hasData || (snapshot.data as List<News>).isEmpty) {
            return Center(child: Text('No hay noticias disponibles'));
          } else {
            return ListView.builder(
              itemCount: (snapshot.data as List<News>).length,
              itemBuilder: (context, index) {
                return NewsCard(news: (snapshot.data as List<News>)[index]);
              },
            );
          }
        },
      ),
    );
  }
}
