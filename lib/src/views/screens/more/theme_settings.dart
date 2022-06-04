import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footballscoreapp/src/blocs/theme_bloc/theme_bloc.dart';
import 'package:footballscoreapp/src/config/themes/theme_data.dart';
import 'package:footballscoreapp/src/config/themes/theme_preference.dart';

import 'package:group_button/group_button.dart';

class ThemeSettings extends StatefulWidget {
  static const routeName = 'footballscoreapp/themesettings';
  const ThemeSettings({Key? key}) : super(key: key);

  @override
  State<ThemeSettings> createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> {
  final _themeGroupButtonController = GroupButtonController();
  final _fontGroupButtonController = GroupButtonController();
  @override
  void initState() {
    _selectButton();
    _selectFontButton();
    super.initState();
  }

  _selectButton() async {
    DarkThemePreference _darkThemePreference = DarkThemePreference();
    bool _isDarkThemed = await _darkThemePreference.getTheme();
    if (_isDarkThemed) {
      _themeGroupButtonController.selectIndex(1);
    } else {
      _themeGroupButtonController.selectIndex(0);
    }
  }

  _selectFontButton() async{
     DarkThemePreference _darkThemePreference = DarkThemePreference();
     String _fontSize = await _darkThemePreference.getFontSize();
     debugPrint('Font Size ---->$_fontSize');
     if(_fontSize == 'M'){
       _fontGroupButtonController.selectIndex(0);
     }else if(_fontSize == 'L'){
       _fontGroupButtonController.selectIndex(1);
     }else{
       _fontGroupButtonController.selectIndex(2);
     }

  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'Scaffold background color ${Theme.of(context).scaffoldBackgroundColor.toString()}');
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Appearance',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 2.0),
        child: Column(
          children: [
            _buildMore(
              "App Theme",
              Colors.green,
              const Icon(
                Icons.mode_night,
                color: Colors.green,
              ),
              context,
              Column(
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  GroupButton(
                    options: _groupButtonOptions(context),
                    controller: _themeGroupButtonController,
                    buttons: const ['LIGHT', 'DARK'],
                    onSelected: (item, index, isSelected) async {
                      String _fontSize =
                          await DarkThemePreference().getFontSize();
                      if (index == 0) {
                        ThemeData _themeData =
                            Styles().themeData(false, _fontSize);
                        BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(
                            isDarkThemed: false, themeData: _themeData));
                      } else {
                        ThemeData _themeData =
                            Styles().themeData(true, _fontSize);
                        BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(
                            isDarkThemed: true, themeData: _themeData));
                      }
                    },
                  ),
                ],
              ),
            ),
            _buildMore(
              'Font Size',
              Colors.orange,
              const Padding(
                padding: EdgeInsets.all(3.0),
                child: Text(
                  'A',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 30.0,
                  ),
                ),
              ),
              context,
              Column(
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  GroupButton(
                    options: _groupButtonOptions(context),
                    controller: _fontGroupButtonController,
                    buttons: const ['M', 'L', 'XL'],
                    onSelected: ((item, index, isSelected) async {
                      debugPrint('item ----->$item');
                       await DarkThemePreference().setFontSize(item.toString());
                      bool _isDarkThemed =
                          await DarkThemePreference().getTheme();
                      if (index == 0) {
                        ThemeData _themeData =
                            Styles().themeData(_isDarkThemed, item.toString());
                       
                        BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(
                            isDarkThemed: _isDarkThemed, themeData: _themeData));
                      } else if (index == 1) {
                        ThemeData _themeData =
                            Styles().themeData(_isDarkThemed, item.toString());
                        BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(
                            isDarkThemed: _isDarkThemed, themeData: _themeData));
                      } else {
                        
                        ThemeData _themeData =
                            Styles().themeData(_isDarkThemed, item.toString());
                        BlocProvider.of<ThemeBloc>(context).add(
                          ThemeChanged(
                              isDarkThemed: _isDarkThemed, themeData: _themeData),
                        );
                      }
                    }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  GroupButtonOptions _groupButtonOptions(BuildContext context) {
    return GroupButtonOptions(
        borderRadius: BorderRadius.circular(20.0),
        buttonHeight: 20.0,
        textPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        groupingType: GroupingType.wrap,
        spacing: 5.0,
        // alignment: Alignment.centerLeft,
        mainGroupAlignment: MainGroupAlignment.end,
        unselectedBorderColor: Colors.grey,
        unselectedColor: Colors.transparent,
        selectedBorderColor: Colors.transparent,
        unselectedTextStyle: Theme.of(context).textTheme.bodyText2!.copyWith(),
        selectedColor: Colors.blue.withOpacity(0.5),
        selectedTextStyle: Theme.of(context).textTheme.bodyText1);
  }

  Container _buildMore(String name, Color color, Widget leading,
      BuildContext context, Widget child) {
    return Container(
      margin: const EdgeInsets.only(top: 3.0),
      color: Theme.of(context).colorScheme.secondary,
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 15.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: color.withOpacity(0.2)),
                child: Center(
                  child: leading,
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
          child
        ],
      ),
    );
  }
}
