import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/bloc/video/video_bloc.dart';
import 'package:movieapp/bloc/video/video_event.dart';
import 'package:movieapp/bloc/video/video_state.dart';
import 'package:movieapp/ui/list_movie/widget/error_page.dart';
import 'package:movieapp/ui/theme/colors.dart';
import 'package:movieapp/util/strings.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoView extends StatefulWidget {
  final int movieId;

  const VideoView({
    super.key,
    required this.movieId,
  });

  @override
  State<StatefulWidget> createState() => VideoViewState();
}

class VideoViewState extends State<VideoView> {
  String err = defaultErr;

  YoutubePlayerController controller = YoutubePlayerController(
    initialVideoId: '',
    flags: const YoutubePlayerFlags(
      controlsVisibleAtStart: true,
      autoPlay: false,
    ),
  );

  @override
  void initState() {
    super.initState();

    context.read<VideoBloc>().add(GetMovieVideosEvent(movieId: widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoBloc, VideoState>(listener: (context, state) {
      if (state is GetVideosError) {
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
        body: state is LoadingVideo
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state is GetVideosSuccess
                ? Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: YoutubePlayer(
                            controller: controller,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.orange,
                            bottomActions: [
                              CurrentPosition(),
                              const SizedBox(width: 10.0),
                              ProgressBar(isExpanded: true),
                              const SizedBox(width: 10.0),
                              RemainingDuration(),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.listVideo.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = state.listVideo[index];

                            return ListTile(
                              onTap: () {
                                setState(() {
                                  controller.load(item.key!);
                                });
                              },
                              leading: item.id == null || item.id!.isEmpty
                                  ? Image.network(
                                      YoutubePlayer.getThumbnail(
                                        videoId: item.key!,
                                      ),
                                      width: 80,
                                      height: 80,
                                    )
                                  : const Icon(Icons.play_arrow),
                              title: Text(
                                item.name ?? '',
                                style: const TextStyle(
                                  color: groupTitleColor,
                                  fontSize: 16.0,
                                  fontFamily: 'Muli',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : ErrorPage(
                    message: err,
                    retry: () {
                      context
                          .read<VideoBloc>()
                          .add(GetMovieVideosEvent(movieId: widget.movieId));
                    },
                  ),
      );
    });
  }
}
