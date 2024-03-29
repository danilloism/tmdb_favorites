import 'package:tmdb_favorites/bloc/movie_repository.dart';

import '../../bloc/movie.dart';
import '../widgets/poster_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({required this.movieId, super.key});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Movie>(
      future: MovieRepository().getOne(movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final movie = snapshot.data!;
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 91, 146, 161),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(228, 1, 180, 228),
                          blurRadius: 2,
                          spreadRadius: 0.1,
                        ),
                      ],
                    ),
                    child: ListView(
                      padding: const EdgeInsets.all(10),
                      children: [
                        AppBar(
                          toolbarHeight: 70,
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          centerTitle: true,
                          title: Text(
                            movie.title,
                            style: GoogleFonts.sourceSansPro(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 500,
                          child: PosterCachedNetworkImage(
                            posterUrl: movie.poster,
                            cacheKey: movie.poster,
                            // fit: BoxFit.scaleDown,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '${movie.releaseDate.month}/${movie.releaseDate.day}/${movie.releaseDate.year}',
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 12,
                            color: const Color.fromARGB(255, 3, 37, 65),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 3, 37, 65),
                              size: 15,
                            ),
                            Text(
                              movie.voteAverage.toString(),
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 3, 37, 65),
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          // runSpacing: 4,
                          spacing: 4,
                          children: [
                            for (String genre in movie.genres) ...[
                              Chip(
                                label: Text(
                                  genre,
                                  style: GoogleFonts.sourceSansPro(
                                    color: const Color.fromARGB(255, 3, 37, 65),
                                  ),
                                ),
                              ),
                            ]
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (movie.description != null)
                          Text(
                            movie.description!,
                            style: GoogleFonts.sourceSansPro(
                              color: const Color.fromARGB(255, 3, 37, 65),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return Container();
        }
        return const ColoredBox(
          color: Colors.white,
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
