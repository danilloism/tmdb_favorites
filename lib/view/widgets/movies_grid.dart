import '../../bloc/error_message.dart';
import '../../bloc/movie_repository.dart';
import '../widgets/movie_card.dart';
import 'package:flutter/material.dart';

class MoviesGrid extends StatelessWidget {
  const MoviesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MovieRepository().getAll,
        builder: (context, AsyncSnapshot<List> movies) {
          if (movies.connectionState == ConnectionState.done) {
            if (!movies.hasError) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (_, index) =>
                    MovieCard(movie: movies.data![index]),
                itemCount: movies.data!.length,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
              );
            }

            final error = movies.error.toString();
            if (error.contains('404')) return ErrorMessage.error(400);
            if (error.contains('500')) return ErrorMessage.error(500);
            return ErrorMessage.error(0);
          }

          return const Center(child: CircularProgressIndicator());
        });
  }
}
