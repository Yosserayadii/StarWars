import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:starwars/filmsdetails.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({Key? key}) : super(key: key);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  late Future<List<dynamic>> filmsData;

  @override
  void initState() {
    super.initState();
    filmsData = fetchFilms();
  }

  Future<List<dynamic>> fetchFilms() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/films'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final films = jsonData['results'];
      return films;
    } else {
      throw Exception('Failed to load films');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Star Wars Films'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.black,
            child: Column(
              children: [
                SizedBox(height: 20),
                Image.asset(
                  'assets/starwars.png', // Replace with the path to your image in the assets folder
                  height: 100,
                  width: 100,
                ),
                SizedBox(height: 20),
                FutureBuilder<List<dynamic>>(
                  future: filmsData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final films = snapshot.data!;
                      return Text(
                        'Total variable films: ${films.length}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return Text('No data available.');
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: filmsData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final films = snapshot.data!;
                  return ListView.builder(
                    itemCount: films.length,
                    itemBuilder: (context, index) {
                      final film = films[index];
                      return Container(
                        color: Colors.black,
                        child: ListTile(
                          title: Text(
                            film['title'],
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Episode ${film['episode_id']}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Release Date: ${film['release_date']}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Director: ${film['director']}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Producer: ${film['producer']}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    FilmDetailsScreen(film: film),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No data available.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
