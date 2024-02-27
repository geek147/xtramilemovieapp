import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/ui/detail/widget/movie_info_view.dart';
import 'package:movieapp/ui/detail/widget/reviews_view.dart';
import 'package:movieapp/ui/detail/widget/video_view.dart';
import 'package:movieapp/ui/theme/colors.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;

  const DetailScreen({super.key, required this.movie});

  @override
  State<StatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        body: _createDetailBody(context),
      ),
    );
  }

  Widget _createDetailBody(BuildContext context) {
    return Stack(
      children: [
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: Column(
                  children: [
                    _createDetailHeader(context),
                    MovieInfoView(movie: widget.movie),
                    const Divider(height: 8.0, color: Colors.transparent),
                    ReviewView(
                        movieId: widget.movie.id ?? 0, actionLoadAll: () {}),
                    const Divider(height: 8.0, color: Colors.transparent),
                  ],
                ),
              ),
            );
          },
        ),
        _createAppbar(context),
      ],
    );
  }

  Widget _createDetailHeader(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: double.infinity,
      height: width + 56.0,
      child: Stack(
        children: [
          ShapeOfView(
            shape: ArcShape(
              direction: ArcDirection.Outside,
              height: 48,
              position: ArcPosition.Bottom,
            ),
            height: width,
            elevation: 24.0,
            child: SizedBox(
              width: double.infinity,
              height: width,
              child: _createHeaderImage(context),
            ),
          ),
          _createHeaderAction(context),
        ],
      ),
    );
  }

  Widget _createAppbar(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        elevation: 0.0,
        titleSpacing: 4.0,
        backgroundColor: Colors.transparent,
        title: Image.asset(
          'assets/images/ic_netflix.png',
          height: 56.0,
          fit: BoxFit.fitHeight,
        ),
        centerTitle: true,
        leading: Container(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: actionBarIconColor),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }

  Widget _createHeaderImage(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          imageUrl:
              'https://image.tmdb.org/t/p/w500${widget.movie.backdropPath}',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.5, 0.7, 0.9],
              colors: [
                white20,
                white10,
                white05,
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _createHeaderAction(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 16.0,
          bottom: 8.0,
          child: SizedBox(
            width: 64.0,
            height: 64.0,
            child: FittedBox(
              child: IconButton(
                icon: const Icon(Icons.add_rounded, color: actionBarIconColor),
                onPressed: () {},
              ),
            ),
          ),
        ),
        Positioned(
          right: 16.0,
          bottom: 8.0,
          child: SizedBox(
            width: 64.0,
            height: 64.0,
            child: FittedBox(
              child: IconButton(
                icon:
                    const Icon(Icons.share_outlined, color: actionBarIconColor),
                onPressed: () {},
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 8.0,
          left: 0.0,
          right: 0.0,
          child: FractionalTranslation(
            translation: const Offset(0.0, -0.2),
            child: SizedBox(
              width: 72.0,
              height: 72.0,
              child: FittedBox(
                child: FloatingActionButton(
                  elevation: 10.0,
                  onPressed: () {
                    _openMovieVideo(widget.movie.id ?? 0);
                  },
                  backgroundColor: white,
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _openMovieVideo(int movieId) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return VideoView(
          movieId: movieId,
        );
      }),
    );
  }
}
