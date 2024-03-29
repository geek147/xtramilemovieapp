import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/bloc/movie/movie_bloc.dart';
import 'package:movieapp/bloc/movie/movie_event.dart';
import 'package:movieapp/bloc/movie/movie_state.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/ui/list_movie/widget/error_page.dart';
import 'package:movieapp/ui/theme/colors.dart';
import 'package:movieapp/util/strings.dart';

class ListVerticalView extends StatefulWidget {
  final Function(Movie) actionOpenMovie;
  final Function actionLoadAll;
  final String genreId;

  const ListVerticalView({
    super.key,
    required this.actionOpenMovie,
    required this.actionLoadAll,
    required this.genreId,
  });

  @override
  State<StatefulWidget> createState() => ListVerticalViewState();
}

class ListVerticalViewState extends State<ListVerticalView> {
  List<Movie> listMovie = [];
  String err = defaultErr;
  ScrollController? controller;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);

    context
        .read<MovieBloc>()
        .add(GetMoviesByGenreEvent(genre: widget.genreId, page: currentPage));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieBloc, MovieState>(listener: (context, state) {
      if (state is GetMoviesSuccess) {
        setState(() {
          currentPage = currentPage + 1;
          if (currentPage == 1) {
            listMovie = state.listMovie;
          } else {
            listMovie.addAll(state.listMovie);
          }
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
      final contentHeight = 4.0 * (MediaQuery.of(context).size.width / 2.4) / 3;
      return Container(
        child: state is Loading && listMovie.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : listMovie.isNotEmpty
                ? SizedBox(
                    height: contentHeight,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 16.0),
                          height: 48.0,
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  "Movies",
                                  style: TextStyle(
                                    color: groupTitleColor,
                                    fontSize: 16.0,
                                    fontFamily: 'Muli',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.arrow_forward,
                                    color: groupTitleColor),
                                onPressed: () {
                                  widget.actionLoadAll;
                                },
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            controller: controller,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.0,
                              mainAxisSpacing: 16.0,
                            ),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            itemCount: listMovie.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _createMyListItem(
                                  context, listMovie[index]);
                            },
                            scrollDirection: Axis.vertical,
                          ),
                        ),
                      ],
                    ),
                  )
                : ErrorPage(
                    message: err,
                    retry: () {
                      setState(() {
                        currentPage = 0;
                      });
                      context.read<MovieBloc>().add(GetMoviesByGenreEvent(
                          genre: widget.genreId, page: currentPage));
                    },
                  ),
      );
    });
  }

  Widget _createMyListItem(BuildContext context, Movie movie) {
    final width = MediaQuery.of(context).size.width / 2.6;
    return InkWell(
      onTap: () {
        widget.actionOpenMovie(movie);
      },
      child: Container(
        height: 100,
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
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                width: width,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (controller?.position.pixels == controller?.position.maxScrollExtent) {
      context
          .read<MovieBloc>()
          .add(GetMoviesByGenreEvent(genre: widget.genreId, page: currentPage));
    }
  }
}
