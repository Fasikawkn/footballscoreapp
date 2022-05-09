import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';

class TeamEvents extends StatelessWidget {
  const TeamEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildStatsRowRight(kPrimaryColor, context),
        _buildStatsRowLeft(kPrimaryColor2, context),
        _buildStatsRowRight(kPrimaryColor, context),
        _buildStatsRowLeft(kPrimaryColor2, context),
      ],
    );
  }

  Container _buildStatsRowLeft(Color backgroundColor, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      color: backgroundColor,
      child: Center(
        child: Row(
         mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    'Coatesjdfhdj',
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: Colors.green),
                  ),
                  Text(
                    'Fedda',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            const Icon(
              Icons.cached,
              color: Colors.green,
              size: 30.0,
            ),
            const SizedBox(
              width: 20.0,
            ),
            const Text(
              '78\'',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              width: (MediaQuery.of(context).size.width * 0.5) - 22,
            ),
          ],
        ),
      ),
    );
  }

  Container _buildStatsRowRight(Color backgroundColor, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      color: backgroundColor,
      child: Center(
        child: Row(
          //  mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width * 0.5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  '78\'',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                const Icon(
                  Icons.cached,
                  color: Colors.green,
                  size: 30.0,
                ),
                const SizedBox(
                  width: 20.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Coatesfdjghfjhg',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            color: Colors.green),
                      ),
                      Text(
                        'Feddal',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
