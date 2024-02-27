import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/bloc/review/review_bloc.dart';
import 'package:movieapp/bloc/review/review_event.dart';
import 'package:movieapp/bloc/review/review_state.dart';
import 'package:movieapp/ui/list_movie/widget/error_page.dart';
import 'package:movieapp/ui/theme/colors.dart';
import 'package:movieapp/util/strings.dart';

class ReviewView extends StatefulWidget {
  final int movieId;
  final Function actionLoadAll;

  const ReviewView({
    super.key,
    required this.movieId,
    required this.actionLoadAll,
  });

  @override
  State<StatefulWidget> createState() => ListHorizontalViewState();
}

class ListHorizontalViewState extends State<ReviewView> {
  String err = defaultErr;
  ScrollController? controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);

    context
        .read<ReviewBloc>()
        .add(GetMovieReviewsEvent(movieId: widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewBloc, ReviewState>(listener: (context, state) {
      if (state is GetReviewsError) {
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
        child: state is LoadingReview
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state is GetReviewsSuccess
                ? Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 20.0, right: 16.0),
                        height: 48.0,
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text(
                                "List Movie",
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
                      ListView.separated(
                        controller: controller,
                        separatorBuilder: (_, __) => const Divider(),
                        itemCount: state.listReview.length,
                        itemBuilder: (context, index) {
                          if (index < state.listReview.length) {
                            final item = state.listReview[index];
                            return ListTile(
                              leading: CachedNetworkImage(
                                width: 80,
                                height: 60,
                                imageUrl: item.authorDetails?.avatarPath ?? '',
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress)),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.account_circle_rounded),
                              ),
                              title: Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  item.author ?? "N/A",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              subtitle: Text(item.content ?? "N/A"),
                            );
                          }
                          return const Center(
                            child: SizedBox(
                                width: 32.0,
                                height: 32.0,
                                child: CircularProgressIndicator()),
                          );
                        },
                      ),
                    ],
                  )
                : ErrorPage(
                    message: err,
                    retry: () {
                      context
                          .read<ReviewBloc>()
                          .add(GetMovieReviewsEvent(movieId: widget.movieId));
                    },
                  ),
      );
    });
  }

  @override
  void dispose() {
    controller?.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (controller?.position.pixels == controller?.position.maxScrollExtent) {
      context
          .read<ReviewBloc>()
          .add(GetMovieReviewsEvent(movieId: widget.movieId));
    }
  }
}
