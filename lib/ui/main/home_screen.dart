import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/bloc/movie/movie_bloc.dart';
import 'package:movieapp/bloc/movie/movie_event.dart';
import 'package:movieapp/bloc/movie/movie_state.dart';
import 'package:movieapp/models/genre.dart';
import 'package:movieapp/ui/list_movie/list_movie_screen.dart';
import 'package:movieapp/ui/theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  List<Genre> listGenre = [];

  @override
  void initState() {
    super.initState();

    context.read<MovieBloc>().add(
          GetGenresEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieBloc, MovieState>(listener: (context, state) {
      if (state is GetGenresSuccess) {
        listGenre = state.listGenre;
      } else if (state is GetGenresError) {
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
        body: SafeArea(
            child: state is Loading && listGenre.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: const EdgeInsets.all(16),
                    child: ListView.separated(
                        separatorBuilder: (_, __) => const Divider(),
                        itemCount: listGenre.length,
                        itemBuilder: (context, index) {
                          final currentGenre = listGenre[index];
                          return ListTile(
                            onTap: () {
                              if (currentGenre.id != null) {
                                openMovieList(currentGenre.id.toString());
                              }
                            },
                            title: Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                currentGenre.name ?? "N/A",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }),
                  )),
      );
    });
  }

  void openMovieList(String genreId) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return ListMovieScreen(genreId: genreId);
      }),
    );
  }
}
