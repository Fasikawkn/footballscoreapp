
import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/custom_functions.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';
import 'package:footballscoreapp/src/models/player_statistics.dart';
import 'package:footballscoreapp/src/views/views.dart';
import 'package:footballscoreapp/src/views/widgets/common/custom_svg_network_image.dart';

class PlayerProfile extends StatelessWidget {
  const PlayerProfile({required this.player, Key? key}) : super(key: key);
  final PlayerStatistics player;

  @override
  Widget build(BuildContext context) {
    debugPrint(player.toJson().toString());
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
          child: Column(
            children: [
              if (player.statistics!.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(
                        10.0,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CustomCachedNetworkImage(
                            url: player.statistics!.first.team!.logo.toString(),
                            placeholder: 'assets/images/ball_two.png',
                            width: 40.0,
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            player.statistics!.first.team!.name.toString(),
                            style: Theme.of(context).textTheme.headline1,
                          )
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: kgreyColor,
                      )
                    ],
                  ),
                ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildYear(
                      formatDatebyDayYear(
                          player.player!.birth!.date.toString()),
                          context,
                      player.player!.age.toString(),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                      child: _buildPos('Position'.toUpperCase(), context,
                          player.statistics!.first.games!.position.toString()))
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(
                      child: _buildNationality('Nationality'.toUpperCase(),context,
                          player.player!.nationality.toString())),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                      child:
                          _buildPos('HEIGHT',context, player.player!.height.toString()))
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(
                      child: _buildPos(
                          'WEIGHT', context, player.player!.weight.toString())),
                  Expanded(
                    child: Container(),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNationality(String top, BuildContext context, String nationality) {
    debugPrint('THe players natinality is $nationality');
    String _flagUrl = getCountryFlag()[nationality] != null
        ? getCountryFlag()[nationality]!.first.flag
        : 'http://nationaltiy.svg';
    return _buildWrapper(
        top,
        context,
        Row(
          children: [
            CustomeFlag(
              size: 120.0,
              imageData: _flagUrl,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(
                nationality,
                overflow: TextOverflow.clip,
                maxLines: 1,
                style: Theme.of(context).textTheme.headline1,
              ),
            )
          ],
        ));
  }

  Widget _buildWrapper(
    String top,
    BuildContext context,
    Widget child,
    
  ) {
    return Container(
      padding: const EdgeInsets.all(
        10.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            top,
            style: const TextStyle(
              color: kgreyColor,
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          child
        ],
      ),
    );
  }

  Widget _buildPos(String top,BuildContext context, String bottom,) {
    return _buildWrapper(
      top,
      context,
      Text(
        bottom,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Widget _buildYear(String top,BuildContext context, String bottom) {
    return _buildWrapper(
        top,
        context,
        Row(
          children: [
            Text(
              bottom,
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(
              width: 5.0,
            ),
             Text(
              'years',
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ));
  }
}
