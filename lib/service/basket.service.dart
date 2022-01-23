import 'dart:convert';
import 'dart:io';
import 'package:basketball/ui/teamui.model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../model/basket.model.dart';
import '../ui/gameui.model.dart';

class BasketService {
  Future<List<GameUI>> loadGames() async {
    var _uri = Uri.https('www.mocky.io', 'v2/5de8d38a3100000f006b1479');
    var response = await http.Client().get(_uri);
    List<GameUI> games = List.empty(growable: true);
    if (response.statusCode == HttpStatus.ok) {
      var listGame = BasketBall.fromJson(jsonDecode(response.body));
      /* games.sort((a, b) {
      return a.homeTeam);
    });*/
      listGame.data?.forEach((element) {
        games.add(GameUI(
          homeTeam: element.homeTeam!.fullName!,
          visitorTeam: element.visitorTeam!.fullName!,
          score: '${element.homeTeamScore} - ${element.visitorTeamScore}',
          date: DateTime.parse(element.date!),
          abbreviation: element.homeTeam!.abbreviation!,
          ab: element.visitorTeam!.abbreviation!,
          status: element.status!,
        ));
      });
    }
    return games;
  }

  Future<List<TeamUI>> loadTeams() async {
    var _uri = Uri.https('www.mocky.io', 'v2/5de8d38a3100000f006b1479');
    var response = await http.Client().get(_uri);
    List<TeamUI> teams = List.empty(growable: true);
    if (response.statusCode == HttpStatus.ok) {
      var listTeams = BasketBall.fromJson(jsonDecode(response.body));
      listTeams.data?.forEach((element) {
        teams.add(
          TeamUI(
            homeTeam: element.homeTeam!.fullName!,
            name: element.homeTeam!.name!,
            city: element.homeTeam!.city!,
            conference: element.homeTeam!.conference!,
            division: element.homeTeam!.division!,
            abbreviation: element.homeTeam!.abbreviation!,
            date: element.date!,
          ),
        );
      });
    }
    return teams;
  }
}
