import 'package:flutter/material.dart';
import 'package:tingo/Animation/slide_from_left_anim.dart';
import 'package:tingo/Animation/slide_up_anim.dart';
import 'package:tingo/Widgets/countdown_timer.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/homePage";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> types = [
    {"type": "all", "icon": Icons.movie_rounded},
    {"type": "anime", "icon": Icons.movie_rounded},
    {"type": "fantasy", "icon": Icons.movie_rounded},
  ];

  List<Map> showData = [
    {
      "img": "assets/jobless_reincarnation.jpg",
      "name": "Jobless Reincarnation",
      "season": 2,
      "episode": 26,
      "release_date_utc": DateTime(2024, 7, 8, 4, 30).toUtc(),
      "type": "anime",
    },
    {
      "img": "assets/my_hero_academia.jpg",
      // "img": "assets/mha_anim.gif",
      "name": "My Hero Academia",
      "season": 2,
      "episode": 9,
      "release_date_utc": DateTime(2024, 7, 6, 22, 30).toUtc(),
      "type": "anime",
    },
    {
      "img": "assets/blue_lock.jpg",
      "name": "Blue Lock",
      "season": 2,
      "episode": 1,
      "release_date_utc": DateTime(2024, 10, 6, 3, 30).toUtc(),
      "type": "anime",
    },
    {
      "img": "assets/house_of_dragon.jpg",
      "name": "House of Dragon",
      "season": 2,
      "episode": 4,
      "release_date_utc": DateTime(2024, 7, 8, 14, 00).toUtc(),
      "type": "fantasy",
    },
    {
      "img": "assets/rings_of_powers.jpg",
      "name": "Rings of Power",
      "season": 2,
      "episode": 1,
      "release_date_utc": DateTime(2024, 8, 10, 13, 00).toUtc(),
      "type": "fantasy",
    },
    {
      "img": "assets/the_boys.jpg",
      "name": "The Boys",
      "season": 2,
      "episode": 6,
      "release_date_utc": DateTime(2024, 7, 4, 13, 00).toUtc(),
      "type": "Dark Comedy",
    },
  ];

  int? selectedIndex;
  String? selectedType;

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
            filters(),
            const SizedBox(
              height: 20,
            ),
            shows(showData, selectedType)
          ],
        ),
      )),
    );
  }

  Widget filters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            types.length,
            (index) => Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          selectedType = types[index]["type"];
                        });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          color: selectedIndex == index
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
                                      backgroundColor: selectedIndex == index
                                          ? Colors.greenAccent
                                          : const Color.fromARGB(
                                              30, 255, 255, 255),
                                      radius: 30,
                                      child: selectedIndex == index
                                          ? SlideUpAnim(
                                              child: const Text(
                                                "👀",
                                                style: TextStyle(fontSize: 30),
                                              ),
                                            )
                                          : Icon(
                                              types[index]["icon"],
                                              color: selectedIndex == index
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
                                      types[index]["type"]
                                              .toString()
                                              .characters
                                              .toList()[0]
                                              .toUpperCase() +
                                          types[index]["type"]
                                              .toString()
                                              .toLowerCase()
                                              .substring(1),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
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
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                )),
      ),
    );
  }

  Widget shows(
    List<Map> shows,
    String? selectedType,
  ) {
    List<Map> matchingShows = [];

    if (selectedType != null && selectedType != "all") {
      selectedType = selectedType.toLowerCase();
      matchingShows = shows.where((e) => e["type"] == selectedType).toList();
    } else {
      matchingShows = shows;
    }

    // sort by date
    matchingShows = sortByReleaseDate(matchingShows);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              matchingShows.length,
              (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          height: 450,
                          child: OverflowBox(
                            maxHeight: 925,
                            child: Image.asset(matchingShows[index]["img"]),
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
                              matchingShows[index]["name"],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${matchingShows[index]["season"] == null ? "" : "S ${matchingShows[index]["season"]}"} Ep ${matchingShows[index]["episode"]}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CountdownTimer(
                                textStyle: const TextStyle(fontSize: 16),
                                targetDate: (matchingShows[index]
                                        ["release_date_utc"] as DateTime)
                                    .toLocal()),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ))),
    );
  }
}

List<Map<dynamic, dynamic>> sortByReleaseDate(
    List<Map<dynamic, dynamic>> movies) {
  movies.sort((a, b) => ((a['release_date_utc'] as DateTime)
          .millisecondsSinceEpoch)
      .compareTo(((b['release_date_utc'] as DateTime).millisecondsSinceEpoch)));
  return movies;
}
