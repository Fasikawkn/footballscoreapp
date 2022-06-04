import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:footballscoreapp/src/models/fixture_lineups.dart';
import 'package:footballscoreapp/src/views/views.dart';
import 'package:footballscoreapp/src/views/widgets/linesups/components/coaches.dart';
import 'package:footballscoreapp/src/views/widgets/linesups/components/substitution.dart';

class TeamLineups extends StatelessWidget {
  const TeamLineups({required this.teamslineupStats, Key? key})
      : super(key: key);
  final List<TeamLineupModel> teamslineupStats;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    debugPrint('${teamslineupStats.first.startXI}');
    
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: size.width,
                height: size.height,
                child: SvgPicture.asset(
                  'assets/images/soccer_field.svg',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                height: size.height,
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildPlayerPostion(teamslineupStats.first.startXI!),
                        _buildPlayerPostion2(teamslineupStats.last.startXI!.toList())
                      ]),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
           LineUpCoaches(
             homeCoach: teamslineupStats.first.coach!,
             awayCoach: teamslineupStats.last.coach!
           ),
          const SizedBox(
            height: 5.0,
          ),
           Substitution(
             homeSubstitutes: teamslineupStats.first.substitutes!,
             awaySubstitutes: teamslineupStats.last.substitutes!,
           )
        ],
      ),
    );
  }

  Widget _buildPlayerPostion(List<StartXI> players) {
    List<Widget> _rowsOne = [];
    List<Widget> _rowsTwo = [];
    List<Widget> _rowsThree = [];
    List<Widget> _rowsFour = [];
    List<Widget> _rowsFive = [];
    List<Widget> _rowsSix = [];
    List<Widget> _rowsSeven = [];

    for (var element in players) {
      
     if(element.player!.grid != null){
        if (int.parse(element.player!.grid![0]) == 1) {
        _rowsOne.add(Expanded(child: _buildPlayer(element.player!)));
      } else if (int.parse(element.player!.grid![0]) == 2) {
        _rowsTwo.add(Expanded(child: _buildPlayer(element.player!)));
      } else if (int.parse(element.player!.grid![0]) == 3) {
        _rowsThree.add(Expanded(child: _buildPlayer(element.player!)));
      } else if (int.parse(element.player!.grid![0]) == 4) {
        _rowsFour.add(Expanded(child: _buildPlayer(element.player!)));
      } else if (int.parse(element.player!.grid![0]) == 5) {
        _rowsFive.add(Expanded(child: _buildPlayer(element.player!)));
      } else if (int.parse(element.player!.grid![0]) == 6) {
        _rowsSix.add(Expanded(child: _buildPlayer(element.player!)));
      } else if (int.parse(element.player!.grid![0]) == 7) {
        _rowsSeven.add(Expanded(child: _buildPlayer(element.player!)));
      }
     }
    }
    List<Widget> _columns = [
      if (_rowsOne.isNotEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _rowsOne,
        ),
      if (_rowsTwo.isNotEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _rowsTwo,
        ),
      if (_rowsThree.isNotEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _rowsThree,
        ),
      if (_rowsFour.isNotEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _rowsFour,
        ),
      if (_rowsFive.isNotEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _rowsFive,
        ),
      if (_rowsSix.isNotEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _rowsSix,
        ),
      if (_rowsSeven.isNotEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _rowsSeven,
        ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _columns,
    );
  }

   Widget _buildPlayerPostion2(List<StartXI> players) {
    List<Widget> _rowsOne = [];
    List<Widget> _rowsTwo = [];
    List<Widget> _rowsThree = [];
    List<Widget> _rowsFour = [];
    List<Widget> _rowsFive = [];
    List<Widget> _rowsSix = [];
    List<Widget> _rowsSeven = [];

    for (var element in players) {
     if(element.player!.grid != null){
        if (int.parse(element.player!.grid![0]) == 1) {
        _rowsOne.add(Expanded(child: _buildPlayer(element.player!)));
      } else if (int.parse(element.player!.grid![0]) == 2) {
        _rowsTwo.add(Expanded(child: _buildPlayer(element.player!)));
      } else if (int.parse(element.player!.grid![0]) == 3) {
        _rowsThree.add(Expanded(child: _buildPlayer(element.player!)));
      } else if (int.parse(element.player!.grid![0]) == 4) {
        _rowsFour.add(Expanded(child: _buildPlayer(element.player!)));
      } else if (int.parse(element.player!.grid![0]) == 5) {
        _rowsFive.add(Expanded(child: _buildPlayer(element.player!)));
      } else if (int.parse(element.player!.grid![0]) == 6) {
        _rowsSix.add(Expanded(child: _buildPlayer(element.player!)));
      } else if (int.parse(element.player!.grid![0]) == 7) {
        _rowsSeven.add(Expanded(child: _buildPlayer(element.player!)));
      }
     }
    }
    List<Widget> _columns = [
      if (_rowsOne.isNotEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _rowsOne,
        ),
      if (_rowsTwo.isNotEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _rowsTwo,
        ),
      if (_rowsThree.isNotEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _rowsThree,
        ),
      if (_rowsFour.isNotEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _rowsFour,
        ),
      if (_rowsFive.isNotEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _rowsFive,
        ),
      if (_rowsSix.isNotEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _rowsSix,
        ),
      if (_rowsSeven.isNotEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _rowsSeven,
        ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _columns.reversed.toList(),
    );
  }

  Widget _buildPlayer(Player player) {
    return SizedBox(
      height: 60.0,
      width: 40.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ContactNetworkImage(
              url:
                  'https://media.api-sports.io/football/players/${player.id}.png',
              width: 30),
         
          Expanded(
            child: Text(
              '${player.number}. ${player.name}',
              style: const TextStyle(
                  fontSize: 9.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
