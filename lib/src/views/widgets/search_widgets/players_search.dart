import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/models/player_statistics.dart';
import 'package:footballscoreapp/src/views/widgets/common/custome_network_image.dart';
import 'package:footballscoreapp/src/views/widgets/player/player_home.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class PlayersSearchPage extends StatelessWidget {
  const PlayersSearchPage({required this.searchedPlayers, Key? key})
      : super(key: key);
  final List<PlayerStatistics> searchedPlayers;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4.0),
      child: ListView(
        children: searchedPlayers
            .map((_player) => SearchPlayerTile(player: _player))
            .toList(),
      ),
    );
  }
}

class SearchPlayerTile extends StatelessWidget {
  const SearchPlayerTile({required this.player, Key? key}) : super(key: key);
  final PlayerStatistics player;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        pushNewScreenWithRouteSettings(
          context,
          screen: PlayerHomePage(
            player: player,
          ),
          settings: RouteSettings(
            name: PlayerHomePage.routeName,
            arguments: player,
          ),
        );
      },
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
          padding: const EdgeInsets.only(
            left: 20.0,
            
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kgreyColor,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                ContactNetworkImage(
                  url: player.player!.photo.toString(),
                  width: 40.0,
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Text(
                  player.player!.name.toString(),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: Theme.of(context).textTheme.bodyText1!.fontSize! + 2
                    ),
                )
              ],
            ),
          )),
    );
  }
}
