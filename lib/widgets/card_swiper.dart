import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
          width: double.infinity,
          height: size.height * 0.5,
          child: Swiper(
            itemCount: movies.length,
            layout: SwiperLayout.STACK,
            itemWidth: size.width * 0.6,
            itemHeight: size.height * 0.9,
            itemBuilder: (_, i) {
              final movie = movies[i];

              movie.heroId = 'swiper-${movie.id}';

              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
                child: Hero(
                  tag: movie.heroId!,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Tooltip(
                      message: movie.title,
                      triggerMode: TooltipTriggerMode.longPress,
                      waitDuration: const Duration(milliseconds: 100),
                      child: FadeInImage(
                        placeholder: const AssetImage('assets/no-image.jpg'),
                        image: NetworkImage(movie.fullPosterImg),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
