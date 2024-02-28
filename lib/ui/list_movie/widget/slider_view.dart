import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/bloc/movie/movie_bloc.dart';
import 'package:movieapp/bloc/movie/movie_event.dart';
import 'package:movieapp/bloc/movie/movie_state.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/ui/list_movie/widget/error_page.dart';
import 'package:movieapp/ui/theme/colors.dart';
import 'package:movieapp/util/strings.dart';

class SliderView extends StatefulWidget {
  final Function(Movie) actionOpenMovie;
  final String genreId;

  const SliderView({
    super.key,
    required this.actionOpenMovie,
    required this.genreId,
  });

  @override
  State<StatefulWidget> createState() => SliderViewState();
}

class SliderViewState extends State<SliderView> {
  List<Movie> listMovie = [];
  String err = defaultErr;

  @override
  void initState() {
    super.initState();

    context
        .read<MovieBloc>()
        .add(GetMoviesByGenreEvent(genre: widget.genreId, page: 0));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieBloc, MovieState>(listener: (context, state) {
      if (state is GetMoviesSuccess) {
        setState(() {
          listMovie.addAll(state.listMovie);
        });
      } else if (state is GetMoviesError) {
        err = state.message;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              state.message,
            ),
          ),
        );
      }
    }, builder: (context, state) {
      return Container(
        child: state is Loading && listMovie.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : listMovie.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.all(16),
                    child: CarouselSlider.builder(
                      itemCount: listMovie.length,
                      itemBuilder: (context, index, realIndex) {
                        return _createSliderItem(context, listMovie[index]);
                      },
                      options: CarouselOptions(
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        pauseAutoPlayOnTouch: true,
                        viewportFraction: 0.8,
                        enlargeCenterPage: true,
                      ),
                    ),
                  )
                : ErrorPage(
                    message: err,
                    retry: () {
                      context.read<MovieBloc>().add(GetMoviesByGenreEvent(
                          genre: widget.genreId, page: 0));
                    },
                  ),
      );
    });
  }

  Widget _createSliderItem(BuildContext context, Movie movie) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        widget.actionOpenMovie(movie);
      },
      child: Container(
        width: width,
        height: double.infinity,
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Card(
          elevation: 10.0,
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SizedBox(
            width: width,
            height: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    imageUrl: '$sliderUrl${movie.backdropPath}',
                    width: width,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: width,
                    height: double.infinity,
                    padding: const EdgeInsets.only(left: 16.0, bottom: 20.0),
                    alignment: Alignment.bottomLeft,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.1, 0.5, 0.7, 0.9],
                        colors: [
                          Color(0x00000000),
                          Color(0x00000000),
                          Color(0x22000000),
                          Color(0x66000000),
                        ],
                      ),
                    ),
                    child: Text(
                      movie.title?.toUpperCase() ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        fontFamily: 'Muli',
                        color: white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
