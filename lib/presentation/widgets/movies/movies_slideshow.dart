import 'package:cinema_pedia_app/domain/entities/movie.dart';
import 'package:cinema_pedia_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;

  final CardSwiperController cardSwiperController = CardSwiperController();

  MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: CardSwiper(
        cardBuilder:
            (
              context,
              index,
              horizontalOffsetPercentage,
              verticalOffsetPercentage,
            ) {
              final movie = movies[index];
              return MoviesCard(movie: movie);
            },
        cardsCount: movies.length,
        controller: cardSwiperController,
        numberOfCardsDisplayed: 3,
        backCardOffset: const Offset(130, 0),
        padding: const EdgeInsets.only(right: 30, left: 20),
      ),
    );
  }
}
