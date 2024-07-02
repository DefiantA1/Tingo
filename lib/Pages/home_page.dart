import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tingo/Animation/slide_from_left_anim.dart';
import 'package:tingo/Animation/slide_up_anim.dart';
import 'package:tingo/Class/media.dart';
import 'package:tingo/Enum/genre_type.dart';
import 'package:tingo/Enum/media_type.dart';
import 'package:tingo/Widgets/countdown_timer.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/homePage";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Media> showData = [
    Media(
      name: "Jobless Reincarnation",
      img: "assets/jobless_reincarnation.jpg",
      genreType: GenreType.isekai,
      mediaType: MediaType.anime,
      season: 2,
      episode: 26,
      releaseDateUTC: DateTime(2024, 7, 8, 4, 30).toUtc(),
    ),
    Media(
      img: "assets/my_hero_academia.jpg",
      name: "My Hero Academia",
      season: 2,
      episode: 9,
      releaseDateUTC: DateTime(2024, 7, 6, 22, 30).toUtc(),
      genreType: GenreType.shonen,
      mediaType: MediaType.anime,
    ),
    Media(
      img: "assets/blue_lock.jpg",
      name: "Blue Lock",
      season: 2,
      episode: 1,
      releaseDateUTC: DateTime(2024, 10, 6, 3, 30).toUtc(),
      genreType: GenreType.sport,
      mediaType: MediaType.anime,
    ),
    Media(
      img: "assets/house_of_dragon.jpg",
      name: "House of Dragon",
      season: 2,
      episode: 4,
      releaseDateUTC: DateTime(2024, 7, 8, 14, 00).toUtc(),
      genreType: GenreType.fantasy,
      mediaType: MediaType.show,
    ),
    Media(
      img: "assets/rings_of_powers.jpg",
      name: "Rings of Power",
      season: 2,
      episode: 1,
      releaseDateUTC: DateTime(2024, 8, 10, 13, 00).toUtc(),
      genreType: GenreType.fantasy,
      mediaType: MediaType.show,
    ),
    Media(
      img: "assets/the_boys.jpg",
      name: "The Boys",
      season: 2,
      episode: 6,
      releaseDateUTC: DateTime(2024, 7, 4, 13, 00).toUtc(),
      genreType: GenreType.fantasy,
      mediaType: MediaType.show,
    ),
  ];

  // int? selectedIndex;
  GenreType? selectedGenreType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          children: [
            SlideFromLeftAnim(
              child: const Text(
                "Tingo 👀",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            genreFilters(),
            const SizedBox(
              height: 20,
            ),
            mediaList(showData, selectedGenreType)
          ],
        ),
      )),
    );
  }

  Widget genreFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        genreButton(null, showAll: true),
        const SizedBox(
          width: 20,
        ),
        ...List.generate(GenreType.values.length, (index) {
          GenreType genre = GenreType.values[index];

          return Row(
            children: [
              genreButton(genre),
              const SizedBox(
                width: 20,
              ),
            ],
          );
        }),
      ]),
    );
  }

  Widget genreButton(GenreType? genre, {bool showAll = false}) {
    String formattedButtonText = "";

    if (genre != null && showAll) {
      throw Exception("To show all, you must make sure genre is null");
    }

    if (genre == null && !showAll) {
      throw Exception("You must provide a genre or set showAll to true");
    }

    if (genre != null) {
      formattedButtonText =
          genre.name.toString().characters.toList()[0].toUpperCase() +
              genre.name.toString().toLowerCase().substring(1);
    } else {
      formattedButtonText = "All";
    }

    return GestureDetector(
      onTap: () {
        if (selectedGenreType == genre) {
          setState(() {
            selectedGenreType = null;
          });
          return;
        }
        setState(() {
          selectedGenreType = genre;
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          color: selectedGenreType == genre
              ? Colors.green
              : const Color.fromARGB(20, 255, 255, 255),
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
              child: Row(
                children: [
                  ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(30),
                    child: CircleAvatar(
                      backgroundColor: selectedGenreType == genre
                          ? Colors.greenAccent
                          : const Color.fromARGB(30, 255, 255, 255),
                      radius: 30,
                      child: selectedGenreType == genre
                          ? SlideUpAnim(
                              child: const Text(
                                "👀",
                                style: TextStyle(fontSize: 30),
                              ),
                            )
                          : Icon(
                              Icons.movie,
                              color: selectedGenreType == genre
                                  ? Colors.red
                                  : Colors.white,
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      formattedButtonText,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget mediaList(
    List<Media> shows,
    GenreType? selectedType,
  ) {
    List<Media> matchingShows = [];

    if (selectedType != null) {
      matchingShows = shows.where((e) => e.genreType == selectedType).toList();
    } else {
      matchingShows = shows;
    }

    // sort by date
    matchingShows = sortByReleaseDate(matchingShows);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: matchingShows.isEmpty
          ? noMediaFound(selectedType)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(matchingShows.length,
                  (index) => mediaCard(matchingShows[index]))),
    );
  }

  Center noMediaFound(GenreType? genre) {
    bool shouldCapatalize = true;

    String text = "no ${genre != null ? genre.name : genre} media found"
        .characters
        .map((char) {
          if (char == " ") {
            shouldCapatalize = true;
            return char;
          } else {
            if (shouldCapatalize) {
              shouldCapatalize = false;
              return char.toUpperCase();
            }

            return char;
          }
        })
        .toList()
        .join();

    return Center(child: Text(text));
  }

  Widget mediaCard(Media media) {
    String seasonText = media.season == null ? "" : "S ${media.season}";
    String episodeText = "Ep ${media.episode}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: SizedBox(
            height: 450,
            child: OverflowBox(
              maxHeight: 925,
              child: Image.asset(media.img),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                media.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "$seasonText $episodeText",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 5,
              ),
              CountdownTimer(
                  textStyle: const TextStyle(fontSize: 16),
                  targetDate: (media.releaseDateUTC).toLocal()),
              const SizedBox(
                height: 5,
              ),
              Text(
                DateFormat('hh:mm a, EEEE, d MMMM')
                    .format(media.releaseDateUTC.toLocal()),
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}

List<Media> sortByReleaseDate(List<Media> movies) {
  movies.sort((a, b) => ((a.releaseDateUTC).millisecondsSinceEpoch)
      .compareTo(((b.releaseDateUTC).millisecondsSinceEpoch)));
  return movies;
}
