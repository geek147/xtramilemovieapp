import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/ui/detail/detail_screen.dart';
import 'package:movieapp/ui/list_movie/widget/list_horizontal_view.dart';
import 'package:movieapp/ui/list_movie/widget/list_vertical_view.dart';
import 'package:movieapp/ui/list_movie/widget/slider_view.dart';
import 'package:movieapp/ui/theme/colors.dart';

class ListMovieScreen extends StatefulWidget {
  final String genreId;

  const ListMovieScreen({super.key, required this.genreId});

  @override
  State<StatefulWidget> createState() => ListMovieState();
}

class ListMovieState extends State<ListMovieScreen>
    implements AutomaticKeepAliveClientMixin<ListMovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 4.0,
        backgroundColor: primaryColor,
        title: Image.asset(
          'assets/images/ic_netflix.png',
          height: 56.0,
          fit: BoxFit.fitHeight,
        ),
        centerTitle: true,
        leading: Container(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: const Icon(Icons.menu_rounded, color: actionBarIconColor),
            onPressed: () {},
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.search, color: actionBarIconColor),
              onPressed: () {},
            ),
          ),
        ],
        elevation: 0.0,
      ),
      backgroundColor: backgroundColor,
      body: _createBody(context),
    );
  }

  Widget _createBody(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Column(
              children: [
                SliderView(
                  actionOpenMovie: (movie) {
                    _openMovieDetail(movie);
                  },
                  genreId: widget.genreId,
                ),
                const Divider(height: 8.0, color: Colors.transparent),
                ListHorizontalView(
                  actionOpenMovie: (movie) {
                    _openMovieDetail(movie);
                  },
                  actionLoadAll: () {},
                  genreId: widget.genreId,
                ),
                const Divider(height: 4.0, color: Colors.transparent),
                ListVerticalView(
                  actionOpenMovie: (movie) {
                    _openMovieDetail(movie);
                  },
                  actionLoadAll: () {},
                  genreId: widget.genreId,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openMovieDetail(Movie movie) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return DetailScreen(movie: movie);
      }),
    );
  }

  @override
  void updateKeepAlive() {}

  @override
  bool get wantKeepAlive => true;
}
