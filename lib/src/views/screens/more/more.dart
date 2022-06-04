import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';
import 'package:footballscoreapp/src/views/screens/more/about_app.dart';
import 'package:footballscoreapp/src/views/screens/more/theme_settings.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MorePage extends StatefulWidget {
  static const routeName = 'footballscoreapp/morepage';
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  final _keyShare = GlobalKey<State<Tooltip>>();
  final _keyRate = GlobalKey<State<Tooltip>>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'More',
          style: Theme.of(context).textTheme.headline1!,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 4.0),
        child: ListView(
          children: [
            GestureDetector(
                onTap: () {
                  pushNewScreenWithRouteSettings(
                    context,
                    screen: const ThemeSettings(),
                    settings: const RouteSettings(
                      name: ThemeSettings.routeName,
                      arguments: 2,
                    ),
                  );
                },
                child: _buildMore(
                    'Settings', Colors.blue.shade500, Icons.settings)),
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              child: Column(
                children: [
                  Tooltip(
                    key:_keyRate ,
                    message: 'Soon!!',
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async{

                        final dynamic _toolTip = _keyRate.currentState;
                        _toolTip.ensureTooltipVisible();
                        Future.delayed(const Duration(seconds: 2)).whenComplete((){
                          _toolTip!.deactivate();
                        });
                        
                        
                      },
                      child: _buildMore('Rate App', Colors.red, Icons.favorite_border)),
                  ),
                  Tooltip(
                    key: _keyShare,
                    message: 'Soon!!',
                    child: GestureDetector(
                      onTap: (){
                        
                        final dynamic _toolTip = _keyShare.currentState;
                        _toolTip.ensureTooltipVisible();
                        Future.delayed(const Duration(seconds: 2)).whenComplete((){
                          _toolTip!.deactivate();
                        });
                      },
                      child: _buildMore('Share Foot Ball Score App', Colors.cyan.shade700,
                          Icons.screen_share_outlined),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        pushNewScreenWithRouteSettings(
                          context,
                          screen: const AboutApp(),
                          settings: const RouteSettings(
                            name: AboutApp.routeName,
                            arguments: 2,
                          ),
                        );
                      },
                      child: _buildMore(
                          'About App', Colors.blue, Icons.help_outline))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildMore(String name, Color color, IconData icon) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
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
                style: Theme.of(context).textTheme.bodyText1,
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
