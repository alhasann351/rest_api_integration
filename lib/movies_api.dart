import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import 'model/get_api_model.dart';

class MoviesApi extends StatefulWidget {
  const MoviesApi({super.key});

  @override
  State<MoviesApi> createState() => _MoviesApiState();
}

class _MoviesApiState extends State<MoviesApi> {
  final String baseUrl = 'https://movies-api14.p.rapidapi.com/movies';

  final Map<String, String> headers = {
    'x-rapidapi-key': '9058ba1f90msh1628eec6b158841p1819d6jsn3e7609774854',
    'x-rapidapi-host': 'movies-api14.p.rapidapi.com',
  };

  Future<List<Movies>> fetchMovies() async {
    final response = await http.get(Uri.parse(baseUrl), headers: headers);

    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body.toString());
      List<dynamic> moviesJson = movies['movies'];
      return moviesJson.map((json) => Movies.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          'Movies',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
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
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            );
          } else {
            return MasonryGridView.count(
                shrinkWrap: true,
                cacheExtent: 1500,
                crossAxisCount: 3,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                      color: Colors.white,
                      clipBehavior: Clip.antiAlias,
                      elevation: 5,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                snapshot.data![index].posterPath.toString(),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                color: Colors.grey,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ],
                      ));
                });
          }
        },
      ),
    );
  }
}
