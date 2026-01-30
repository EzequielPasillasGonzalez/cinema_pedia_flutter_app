import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:cinema_pedia_app/domain/entities/movie.dart';
import 'package:cinema_pedia_app/presentation/widgets/widgets.dart';

class MoviesSlideshow extends StatefulWidget {
  final List<Movie> movies;

  const MoviesSlideshow({super.key, required this.movies});

  @override
  State<MoviesSlideshow> createState() => _MoviesSlideshowState();
}

class _MoviesSlideshowState extends State<MoviesSlideshow> {
  final CardSwiperController cardSwiperController = CardSwiperController();

  int currentIndex = 0;

  @override
  void dispose() {
    cardSwiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        SizedBox(
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
                  final movie = widget.movies[index];
                  return MoviesCard(movie: movie);
                },
            onSwipe: (previousIndex, index, direction) {
              currentIndex = index ?? 0;
              setState(() {});
              return true;
            },
            onUndo: (previousIndex, index, direction) {
              currentIndex = index;
              setState(() {});
              return true;
            },
            cardsCount: widget.movies.length,
            controller: cardSwiperController,
            duration: const Duration(milliseconds: 300),

            numberOfCardsDisplayed: 3,
            backCardOffset: const Offset(130, 0),
            padding: const EdgeInsets.only(right: 30, left: 20),
          ),
        ),

        const SizedBox(height: 10),

        _Pagination(widget: widget, currentIndex: currentIndex, colors: colors),
      ],
    );
  }
}

class _Pagination extends StatelessWidget {
  const _Pagination({
    required this.widget,
    required this.currentIndex,
    required this.colors,
  });

  final MoviesSlideshow widget;
  final int currentIndex;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.movies.length, (index) {
        final isSelected = currentIndex == index;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: isSelected ? 20 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: isSelected ? colors.primary : colors.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}
