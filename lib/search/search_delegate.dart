import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDeledate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Icon(Icons.movie_creation_outlined, size: 150, color: Colors.black26),
      );
    }

    final moviesProvideer = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvideer.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: moviesProvideer.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final movies = snapshot.data!;

        for (var movie in movies) {
          movie.heroId = 'search-${movie.id}';
        }

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int index) => Hero(
            tag: movies[index].heroId!,
            child: ListTile(
              leading: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movies[index].fullPosterImg),
                width: 50,
                fit: BoxFit.contain,
              ),
              title: Text(movies[index].title),
              subtitle: Text(movies[index].originalTitle),
              onTap: () {
                //close(context, null);
                Navigator.pushNamed(context, 'details', arguments: movies[index]);
              },
            ),
          ),
        );
      },
    );
  }
}
