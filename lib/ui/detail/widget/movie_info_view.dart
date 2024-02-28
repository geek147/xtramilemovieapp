import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/bloc/movie/movie_bloc.dart';
import 'package:movieapp/bloc/movie/movie_event.dart';
import 'package:movieapp/bloc/movie/movie_state.dart';

import 'package:movieapp/models/movie.dart';
import 'package:movieapp/ui/list_movie/widget/error_page.dart';
import 'package:movieapp/ui/list_movie/widget/star_rating.dart';
import 'package:movieapp/util/strings.dart';

class MovieInfoView extends StatefulWidget {
  final Movie movie;

  const MovieInfoView({super.key, required this.movie});

  @override
  State<StatefulWidget> createState() => MovieInfoViewState();
}

class MovieInfoViewState extends State<MovieInfoView> {
  String err = defaultErr;

  @override
  void initState() {
    super.initState();

    context
        .read<MovieBloc>()
        .add(GetMovieInfoEvent(movieId: widget.movie.id ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieBloc, MovieState>(listener: (context, state) {
      if (state is GetInfoError) {
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
        child: state is Loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state is GetInfoSuccess
                ? Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                        child: Text(
                          state.movieInfo.title ?? '',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.black87,
                            fontFamily: 'Muli',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                        child: Text(
                          state.movieInfo.getCategories ?? '',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13.0,
                            color: Colors.black45,
                            fontFamily: 'Muli',
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: StarRating(
                          size: 24.0,
                          rating: state.movieInfo.voteAverage! / 2,
                          color: Colors.red,
                          borderColor: Colors.black54,
                          starCount: 5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(''),
                            Column(
                              children: [
                                const Text(
                                  "Year",
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black45,
                                    fontFamily: 'Muli',
                                  ),
                                ),
                                Text(
                                  state.movieInfo.year,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Muli',
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  "Country",
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black45,
                                    fontFamily: 'Muli',
                                  ),
                                ),
                                Text(
                                  state.movieInfo.country,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Muli',
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  "Duratioon",
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black45,
                                    fontFamily: 'Muli',
                                  ),
                                ),
                                Text(
                                  state.movieInfo.runtime?.toString() ?? '',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Muli',
                                  ),
                                )
                              ],
                            ),
                            const Text(''),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                            left: 24.0, right: 24.0, top: 8.0),
                        child: Text(
                          state.movieInfo.overview ?? '',
                          textAlign: TextAlign.justify,
                          maxLines: state.movieInfo.overview != null ? 100 : 5,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black45,
                            fontFamily: 'Muli',
                          ),
                        ),
                      ),
                    ],
                  )
                : ErrorPage(
                    message: err,
                    retry: () {
                      context.read<MovieBloc>().add(
                          GetMovieInfoEvent(movieId: widget.movie.id ?? 0));
                    },
                  ),
      );
    });
  }
}
