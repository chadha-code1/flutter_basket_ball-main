import 'package:basketball/service/basket.service.dart';
import 'package:basketball/ui/teamui.model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'gameui.model.dart';

class wrapper extends StatefulWidget {
  const wrapper({Key? key}) : super(key: key);

  @override
  _wrapperState createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: ('GAMES')),
              Tab(text: ('TEAMS')),
            ],
          ),
          //title: const Text(' '),
          /* actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.archive_rounded,
                color: Colors.white,
              ),
              onPressed: () async {},
            )
          ],*/
        ),
        body: TabBarView(children: [
          FutureBuilder<List<GameUI>>(
            future: BasketService().loadGames(),
            builder: (context, data) {
              if (data.hasData) {
                var gameList = data.data!;
                gameList.sort((a, b) {
                  return a.date.compareTo(b.date);
                });
                print(gameList);
                return ListView.builder(
                  itemCount: gameList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "${gameList[index].homeTeam} ",
                                  textAlign: TextAlign.center,
                                ),
                                Text("${gameList[index].abbreviation} ",
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 13)),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                      DateFormat("yyyy-MM-dd")
                                          .format(gameList[index].date),
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 13)),
                                  Container(
                                      width: 75,
                                      height: 30,
                                      margin: EdgeInsets.all(6),
                                      padding: EdgeInsets.all(6),
                                      child: Text(
                                        " ${gameList[index].score}",
                                        textAlign: TextAlign.center,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green[400],
                                      )),
                                  // Text("${gameList[index].status}"),
                                  Text(
                                    "${gameList[index].status.substring(0, 4)} ",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    " ${gameList[index].visitorTeam}",
                                    textAlign: TextAlign.center,
                                  ),
                                  Text("${gameList[index].ab} ",
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 13)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const LinearProgressIndicator();
              }
            },
          ),
          FutureBuilder<List<TeamUI>>(
              future: BasketService().loadTeams(),
              builder: (context, data) {
                if (data.hasData) {
                  var teamList = data.data!;
                  teamList.sort((a, b) {
                    return DateTime.parse(a.date)
                        .compareTo(DateTime.parse(b.date));
                  });
                  return ListView.builder(
                    itemCount: teamList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "${teamList[index].homeTeam} (${teamList[index].abbreviation})",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                // Text('Middle Left'),
                                Text("city :${teamList[index].city} ",
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 13)),
                                Spacer(),
                                Text("name: ${teamList[index].name}",
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 13)),

                                //Text('Middle right')
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                //Text('Bottom Left'),
                                Text("division: ${teamList[index].division} ",
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 13)),

                                Spacer(),

                                Text(
                                    "conference:  ${teamList[index].conference}",
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 13)),
                                // Text('Bottom right')
                              ],
                            ),
                          ]),
                        ),
                      );
                    },
                  );
                } else {
                  return const LinearProgressIndicator();
                }
              }),
        ]),
      ),
    );
  }
}
