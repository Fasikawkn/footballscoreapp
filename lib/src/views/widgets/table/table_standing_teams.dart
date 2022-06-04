import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footballscoreapp/src/blocs/standing_bloc/standing_bloc.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/models/team_table_data.dart';
import 'package:footballscoreapp/src/services/data_providers/standings.dart';
import 'package:footballscoreapp/src/services/repositories/standings.dart';
import 'package:footballscoreapp/src/views/views.dart';
import 'package:footballscoreapp/src/views/widgets/table/components/form_button.dart';
import 'package:group_button/group_button.dart';
import 'package:http/http.dart' as http;

class StandingTable extends StatefulWidget {
  const StandingTable({required this.gamematch, required this.teams, Key? key})
      : super(key: key);
  final MatchDetailRouteArgument gamematch;
  final List<int> teams;

  @override
  State<StandingTable> createState() => _StandingTableState();
}

enum PlayStatus { home, away, all }

class _StandingTableState extends State<StandingTable> {
  @override
  void initState() {
    super.initState();
  }

  PlayStatus _status = PlayStatus.all;

  bool _formButtonSelected = false;
  final _buttonController = GroupButtonController();
  

  List<Item> _selectBasedonPlayStatus(
      PlayStatus playStatus, List<TableData> tableData) {
    if (playStatus == PlayStatus.all) {
      return tableData
          .map(
            (item) => Item(
                id: item.rank.toString(),
                gd: item.goalsDiff.toString(),
                // isSelected: false,
                isSelected: widget.teams.contains(item.team!.id),
                mp: item.all!.played.toString(),
                name: item.team!.name.toString(),
                plusMinus:
                    '${item.all!.goals!.scored}-${item.all!.goals!.against}',
                pts: item.points.toString(),
                image: item.team!.logo.toString(),
                description: item.description.toString()),
          )
          .toList();
    } else if (playStatus == PlayStatus.home) {
      return tableData
          .map(
            (item) => Item(
                id: item.rank.toString(),
                gd: '${item.home!.goals!.scored! - item.home!.goals!.against!}',
                isSelected: widget.teams.contains(item.team!.id),
                //  widget.teams.contains(widget.gamematch.gameMatch!.teams!.home!.id)
                // || widget.teams.contains( widget.gamematch.gameMatch!.teams!.away!.id),
                mp: item.home!.played.toString(),
                name: item.team!.name.toString(),
                plusMinus:
                    '${item.home!.goals!.scored}-${item.home!.goals!.against}',
                pts: item.points.toString(),
                image: item.team!.logo.toString(),
                description: item.description.toString()),
          )
          .toList();
    } else {
      return tableData
          .map(
            (item) => Item(
                id: item.rank.toString(),
                gd: '${item.away!.goals!.scored! - item.away!.goals!.against!}',
                isSelected: widget.teams.contains(item.team!.id),
                // isSelected: widget.teams.contains(widget.gamematch.gameMatch!.teams!.home!.id)
                // || widget.teams.contains( widget.gamematch.gameMatch!.teams!.away!.id),
                mp: item.away!.played.toString(),
                name: item.team!.name.toString(),
                plusMinus:
                    '${item.away!.goals!.scored}-${item.away!.goals!.against}',
                pts: item.points.toString(),
                image: item.team!.logo.toString(),
                description: item.description.toString()),
          )
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _standingRepository = StandingsRepository(
      dataProvider: StandingsDataProvider(
        httpClient: http.Client(),
      ),
    );

    return BlocProvider(
      lazy: false,
      create: (context) => StandingBloc(
        repository: _standingRepository,
      )..add(
          GetStandingDataEvent(
            leagueId: widget.gamematch.league.id!,
            season: widget.gamematch.league.season!,
          ),
        ),
      child:
          BlocBuilder<StandingBloc, StandingState>(builder: (context, state) {
       
        if (state is StandingLoadingState) {
        
          return const Center(
            child: CircularProgressIndicator(
              color: kBlueColor,
            ),
          );
        } else if (state is StandingLoadedState) {
          List<Item> _items = [
            Item(
              id: 'cbv',
              name: state.standings.name!.toString(),
              mp: 'MP',
              plusMinus: '+/-',
              gd: 'GD',
              pts: 'PTS',
              isSelected: false,
              image: '',
              description: '',
            ),
          ];
          _items.addAll(
              _selectBasedonPlayStatus(_status, state.standings.tableData!));
          return ListView(
            shrinkWrap: true,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 3.0),
                color: Theme.of(context).colorScheme.secondary,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              FormTableButton(
                                isSelected: _formButtonSelected,
                                onPressed: () {
                                  _buttonController.unselectAll();
                                  setState(() {
                                    _formButtonSelected = true;
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 6.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    shape: BoxShape.circle),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.cached,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                          GroupButton(
                            options: groupButtonOptions(),
                            controller: _buttonController,
                            buttons: const ['ALL', 'HOME', "AWAY"],
                            onSelected: (item, index, isSelected) {
                              setState(() {
                                if (item == 'ALL') {
                                  _status = PlayStatus.all;
                                } else if (item == 'HOME') {
                                  _status = PlayStatus.home;
                                } else {
                                  _status = PlayStatus.away;
                                }
                                _formButtonSelected = false;
                              });
                              debugPrint(
                                  'item $item index $index isSelected$isSelected');
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.baseline,
                        defaultColumnWidth: const IntrinsicColumnWidth(),
                        columnWidths: const <int, TableColumnWidth>{
                          0: FixedColumnWidth(1),
                          1: FixedColumnWidth(180),
                          2: FixedColumnWidth(30),
                          3: FixedColumnWidth(50),
                          4: FixedColumnWidth(30),
                          5: FixedColumnWidth(30),
                        },
                        textBaseline: TextBaseline.alphabetic,
                        children:
                            _items.map((item) => _buildTableRow(item)).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (state is StandingErrorState) {
          debugPrint('The error is ${state.errorMessage}');

          return const Text(
            'error',
            style: TextStyle(color: Colors.red),
          );
        } else {
          return Container();
        }
      }),
    );
  }

  Color _chooseStageColor(String desctiption) {
    switch (desctiption) {
      case 'Promotion - Champions League (Group Stage)':
        return Colors.blue;
      case 'Promotion - Europa League (Group Stage)':
        return Colors.purple;
      case 'Promotion - Europa Conference League (Qualification)':
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  TableRow _buildTableRow(
    Item item,
  ) {
    return TableRow(
        key: ValueKey(item.id),
        decoration: BoxDecoration(
          color: item.id != 'cbv'
              ? item.isSelected
                  ? Colors.blue.withOpacity(
                      0.3,
                    )
                  : Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.secondary,
          border: item.id == 'cbv'
              ? const Border()
              : const Border(
                  bottom: BorderSide(
                    width: 0.3,
                    color: Colors.grey,
                  ),
                ),
        ),
        children: [
          TableCell(
            child: item.id != 'cbv'
                ? Container(
                    margin: const EdgeInsets.only(bottom: 1.5, right: 8),
                    height: 40.0,
                    width: 0.5,
                    decoration: BoxDecoration(
                        color: item.id == '0'
                            ? const Color.fromARGB(255, 5, 25, 172)
                            : _chooseStageColor(item.description),
                        shape: BoxShape.rectangle),
                  )
                : const Text(''),
          ),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.bottom,
              child: SizedBox(
                height: 40.0,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (item.id != 'cbv')
                        Text(
                          item.id,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      if (item.id != 'cbv')
                        const SizedBox(
                          width: 10.0,
                        ),
                      if (item.id != 'cbv')
                        CustomCachedNetworkImage(
                          url: item.image,
                          placeholder: 'assets/images/ball_one.png',
                          width: 20.0,
                        ),
                      if (item.id != 'cbv')
                        const SizedBox(
                          width: 10.0,
                        ),
                      Expanded(
                        child: Text(
                          item.name,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      )
                    ],
                  ),
                ),
              )),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  item.mp,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  item.plusMinus,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  item.gd,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  item.pts,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )),
        ]);
  }
}

class Item {
  String id;
  String name;
  String mp;
  String plusMinus;
  String gd;
  String pts;
  bool isSelected;
  String image;
  String description;

  Item(
      {required this.id,
      required this.name,
      required this.mp,
      required this.plusMinus,
      required this.gd,
      required this.pts,
      required this.isSelected,
      required this.image,
      required this.description});
}

class RadiantGradientMask extends StatelessWidget {
  const RadiantGradientMask({required this.child, Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [Colors.green, Colors.red],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
