import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';
import 'package:footballscoreapp/src/models/team_table_data.dart';
import 'package:footballscoreapp/src/views/views.dart';
import 'package:group_button/group_button.dart';

class TeamStats extends StatefulWidget {
  const TeamStats({required this.teamStats, Key? key}) : super(key: key);
  final LeagueTable teamStats;

  @override
  State<TeamStats> createState() => _TeamStatsState();
}

class _TeamStatsState extends State<TeamStats> {
  final GroupButtonController _groupButtonController = GroupButtonController();
  @override
  void initState() {
    _groupButtonController.selectIndex(0);
    _setTagged();
    super.initState();
  }

  String _tag = 'All';

  All _selectedTag = All();

  _setTagged() {
    _selectedTag = widget.teamStats.tableData!.first.all!;
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 4.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.secondary),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          CustomCachedNetworkImage(
                            url: widget.teamStats.logo.toString(),
                            placeholder: 'assets/images/ball_one.png',
                            width: 20.0,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            widget.teamStats.name.toString(),
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      GroupButton(
                        controller: _groupButtonController,
                        options: _groupButtonOptions(_size),
                        buttons: const ['ALL', 'HOME', "AWAY"],
                        onSelected: (item, index, isSelected) {
                          debugPrint('$item $index $isSelected');
                          if (item == 'ALL') {
                            setState(() {
                              _selectedTag =
                                  widget.teamStats.tableData!.first.all!;
                            });
                          } else if (item == 'HOME') {
                            setState(() {
                              _selectedTag =
                                  widget.teamStats.tableData!.first.home!;
                            });
                          } else {
                            setState(() {
                              _selectedTag =
                                  widget.teamStats.tableData!.first.away!;
                            });
                          }
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildStats(
                        'WINS',
                        _selectedTag.win.toString(),
                        Theme.of(context).colorScheme.secondary,
                      )),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child: _buildStats(
                        'DRAW',
                        _selectedTag.draw.toString(),
                        Theme.of(context).colorScheme.secondary,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: _buildStats(
                        'LOSSES',
                        _selectedTag.lose.toString(),
                        Theme.of(context).colorScheme.secondary,
                      )),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child: _buildStats(
                        '+/-',
                        '${_selectedTag.goals!.scored}-${_selectedTag.goals!.against}',
                        Theme.of(context).colorScheme.secondary,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: _buildStats(
                        'PLAYED',
                        _selectedTag.played.toString(),
                        Theme.of(context).colorScheme.secondary,
                      )),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child: _buildStats(
                        'GOAL DIFFERENCE',
                        _goalDifference(),
                        Theme.of(context).colorScheme.secondary,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: _buildStats(
                              'POINTS',
                              widget.teamStats.tableData!.first.points
                                  .toString(),
                              Theme.of(context).colorScheme.secondary,)),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(child: _buildStats('', '', Colors.transparent)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _goalDifference() {
    if (widget.teamStats.tableData!.first.goalsDiff!.toInt() > 0) {
      return '+${widget.teamStats.tableData!.first.goalsDiff}';
    } else if (widget.teamStats.tableData!.first.goalsDiff!.toInt() == 0) {
      return '0';
    } else {
      return '${widget.teamStats.tableData!.first.goalsDiff}';
    }
  }

  Widget _buildStats(String topText, String bottomText, Color color) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            topText,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: kgreyColor
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          AutoSizeText(
            bottomText,
            maxLines: 1,
            style:Theme.of(context).textTheme.headline1,
          )
        ],
      ),
    );
  }

  GroupButtonOptions _groupButtonOptions(Size size) {
    return GroupButtonOptions(
        borderRadius: BorderRadius.circular(20.0),
        buttonHeight: 30.0,
        buttonWidth: (size.width - 46) * 0.3,
        textPadding: EdgeInsets.zero,
        groupingType: GroupingType.wrap,
        spacing: 5.0,
        mainGroupAlignment: MainGroupAlignment.end,
        unselectedBorderColor: Colors.grey,
        unselectedColor: Colors.transparent,
        selectedBorderColor: Colors.transparent,
        unselectedTextStyle:
            const TextStyle(color: Color.fromARGB(255, 165, 161, 161)),
        selectedColor: Colors.blue.withOpacity(0.5),
        selectedTextStyle: const TextStyle(color: Colors.blue));
  }
}
