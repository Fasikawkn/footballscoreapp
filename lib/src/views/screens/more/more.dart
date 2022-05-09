import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';

class MorePage extends StatefulWidget {
  static const routeName = 'footballscoreapp/morepage';
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'More',
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 4.0),
        child: ListView(
          children: [
            _buildMore('Settings', Colors.blue.shade500, Icons.settings),
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              child: Column(
                children: [
                  _buildMore('Rate App', Colors.red, Icons.favorite_border),
                  _buildMore('Share Foot Ball Score App', Colors.cyan.shade700,
                      Icons.screen_share_outlined),
                  _buildMore('About App', Colors.blue, Icons.help_outline)
                ],
              ),
            ),
            Container(
               margin: const EdgeInsets.only(top: 4.0),
               child: Column(
                 children: [
                  _buildMoreEnd('Support Us', 'Remove ads for 1 year', Colors.yellow, Icons.star_border),
                  _buildMoreEnd('Restore Previous Purchase', 'Restore missing subscription', Colors.green, Icons.star_border),
                 ],
               ),

            )
          ],
        ),
      ),
    );
  }

  Container _buildMore(String name, Color color, IconData icon) {
    return Container(
      color: kPrimaryColor2,
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: color.withOpacity(0.2)),
                child: Center(
                  child: Icon(
                    icon,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                name,
                style: const TextStyle(
                    color: kWhiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0),
              )
            ],
          ),
          const Icon(
            Icons.navigate_next,
            color: kgreyColor,
            size: 35.0,
          )
        ],
      ),
    );
  }

  Widget _buildMoreEnd(String title, String subTitle, Color color, IconData icon) {
    return Container(
      color: kPrimaryColor2,
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: color.withOpacity(0.2)),
                child: Center(
                  child: Icon(
                    icon,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: kWhiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0),
                  ),
                  Text(
                    subTitle,
                    style: const TextStyle(
                        color: kgreyColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0),
                  ),
                ],
              )
            ],
          ),
          const Icon(
            Icons.navigate_next,
            color: kgreyColor,
            size: 35.0,
          )
        ],
      ),
    );
  }
}
