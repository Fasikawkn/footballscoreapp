import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/models/fixture_lineups.dart';
import 'package:footballscoreapp/src/views/views.dart';

class Substitution extends StatelessWidget {
  const Substitution(
      {required this.awaySubstitutes, required this.homeSubstitutes, Key? key})
      : super(key: key);
  final List<Substitutes> homeSubstitutes;
  final List<Substitutes> awaySubstitutes;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int _index = 0;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            decoration: const BoxDecoration(color: kPrimaryColor),
            child: const Text(
              'SUBSTITUTION ON BENCH',
              style: TextStyle(
                color: kgreyColor,
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
              ),
            ),
          ),
          Container(
              // height: 500,
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              color: kPrimaryColor2,
              child: Column(
                children: homeSubstitutes.map((substitute) {
                  Widget _secondItem = Container();
                  if(_index < awaySubstitutes.length){
                    _secondItem =  _buildSubstitution(awaySubstitutes[_index].player!);
                  }
                  Widget _row =  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSubstitution(substitute.player!),
                      _secondItem,
                     
                    ],
                  );
                  _index++;

                  return _row;
                }).toList(),
              )),
        ],
      ),
    );
  }

  String _getPostion(String pos) {
    String _postion = '';
    if (pos == 'G') {
      _postion = 'GoalKeeper';
    } else if (pos == 'D') {
      _postion = 'Defender';
    } else if (pos == 'M') {
      _postion = 'Midfielder';
    } else if (pos == 'F') {
      _postion = 'Forward';
    }
    return _postion;
  }

  Widget _buildSubstitution(Player player) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ContactNetworkImage(
              url:
                  'https://media.api-sports.io/football/players/${player.id}.png',
              width: 30),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            '${player.number}. ${player.name.toString()}',
            style: const TextStyle(
              color: kgreyColor,
            ),
          ),
          Text(
            _getPostion(player.pos.toString()),
            style:
                const TextStyle(color: kWhiteColor, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
