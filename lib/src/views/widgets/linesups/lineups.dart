import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:footballscoreapp/src/views/widgets/linesups/components/coaches.dart';
import 'package:footballscoreapp/src/views/widgets/linesups/components/substitution.dart';

class TeamLineups extends StatelessWidget {
  const TeamLineups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: size.width,
                height: size.height,
                // decoration: BoxDecoration(
                //    image: DecorationImage(
                //      image:
                //    );
                // ),
                child: SvgPicture.asset(
                  'assets/images/soccer_field.svg',
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildPlayer('6 Lillie Sanchez'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPlayer('6 Lillie Sanchez'),
                        _buildPlayer('6 Lillie Sanchez'),
                        _buildPlayer('6 Lillie Sanchez'),
                        _buildPlayer('6 Lillie Sanchez'),
                      ],
                    ),
                    _buildPlayer('6 Lillie Sanchez'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPlayer('6 Lillie Sanchez'),
                        _buildPlayer('6 Lillie Sanchez'),
                        _buildPlayer('6 Lillie Sanchez'),
                        _buildPlayer('6 Lillie Sanchez'),
                      ],
                    ),
                    _buildPlayer('6 Lillie Sanchez'),
                    _buildPlayer('17. Robin Lod'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPlayer('17. Robin Lod'),
                        _buildPlayer('17. Robin Lod'),
                        _buildPlayer('17. Robin Lod'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPlayer('17. Robin Lod'),
                        _buildPlayer('17. Robin Lod'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPlayer('17. Robin Lod'),
                        _buildPlayer('17. Robin Lod'),
                        _buildPlayer('17. Robin Lod'),
                        _buildPlayer('17. Robin Lod'),
                      ],
                    ),
                    _buildPlayer('17. Robin Lod'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          const LineUpCoaches(
            
          ),
          const SizedBox(
            height: 5.0,
          ),
          const Substitution()
        ],
      ),
    );
  }

  SizedBox _buildPlayer(String name) {
    return SizedBox(
      height: 60.0,
      width: 40.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.person,
                  size: 30.0,
                )),
          ),
          Expanded(
              child: Text(
            name,
            style: const TextStyle(
                fontSize: 9.0,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ))
        ],
      ),
    );
  }
}
