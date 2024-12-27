import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_integration/model/get_api_model.dart';

class GetApi extends StatefulWidget {
  const GetApi({super.key});

  @override
  State<GetApi> createState() => _GetApiState();
}

class _GetApiState extends State<GetApi> {
  final String apiUrl = "https://movies-api14.p.rapidapi.com/movies";
  final Map<String, String> headers = {
    'x-rapidapi-key': '9058ba1f90msh1628eec6b158841p1819d6jsn3e7609774854',
    'x-rapidapi-host': 'movies-api14.p.rapidapi.com',
  };

  Future<List<Movies>> fetchMovies() async {
    final response = await http.get(Uri.parse(apiUrl), headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body.toString());
      List<dynamic> moviesJson = data['movies'];
      return moviesJson.map((json) => Movies.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load movies");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Get Api',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Movies>>(
        future: fetchMovies(),
        builder: (context, AsyncSnapshot<List<Movies>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.pink,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title.toString()),
                  leading: Image.network(
                    snapshot.data![index].posterPath.toString(),
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
