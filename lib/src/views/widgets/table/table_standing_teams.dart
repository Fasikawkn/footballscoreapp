import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/views/widgets/table/components/form_button.dart';
import 'package:group_button/group_button.dart';

class StandingTable extends StatefulWidget {
  const StandingTable({Key? key}) : super(key: key);

  @override
  State<StandingTable> createState() => _StandingTableState();
}

class _StandingTableState extends State<StandingTable> {
  List<Item> _items = [
    Item(
        id: 'cbv',
        name: "EASTERN CONFERENCE",
        mp: 'MP',
        plusMinus: '+/-',
        gd: 'GD',
        pts: 'PTS',
        isSelected: false),
  ];

  List<Item> _generateItem() {
    return List.generate(5, (index) {
      return Item(
          id: '$index',
          name: 'Team of indebbbbdgjfdhfgx $index',
          mp: '${index + 5}',
          plusMinus: '${index + 7}-${index + 2}',
          gd: '+${index + 4}',
          pts: '${index * 4}',
          isSelected: index == 2);
    });
  }

  @override
  void initState() {
    setState(() {
      _items.addAll(_generateItem());
    });
    super.initState();
  }

  bool _formButtonSelected = false;
  final _buttonController = GroupButtonController();
  GroupButtonOptions _groupButtonOptions() {
    return GroupButtonOptions(
        borderRadius: BorderRadius.circular(20.0),
        buttonHeight: 30.0,
        textPadding: EdgeInsets.zero,
        groupingType: GroupingType.wrap,
        spacing: 5.0,
        mainGroupAlignment: MainGroupAlignment.end,
        unselectedBorderColor: Colors.grey,
        unselectedColor: Colors.transparent,
        selectedBorderColor: Colors.transparent,
        unselectedTextStyle: const TextStyle(color: Colors.grey),
        selectedColor: Colors.blue.withOpacity(0.5),
        selectedTextStyle: const TextStyle(color: Colors.blue));
  }

  @override
  Widget build(BuildContext context) {
    print('FormButton is Selected $_formButtonSelected');
    return Container(
      color: kPrimaryColor,
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
                  options: _groupButtonOptions(),
                  controller: _buttonController,
                  buttons: ['ALL', 'HOME', "AWAY"],
                  onSelected: (item, index, isSelected) {
                    setState(() {
                      _formButtonSelected = false;
                    });
                    debugPrint('item $item index $index isSelected$isSelected');
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.baseline,
              defaultColumnWidth: const IntrinsicColumnWidth(),
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(3),
                1: FixedColumnWidth(180),
                2: FixedColumnWidth(30),
                3: FixedColumnWidth(30),
                4: FixedColumnWidth(30),
                5: FixedColumnWidth(30),
              },
              textBaseline: TextBaseline.alphabetic,
              children: _items.map((item) => _buildTableRow(item)).toList(),
            ),
          ),
        ],
      ),
    );
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
                  : kPrimaryColor2
              : kPrimaryColor,
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
                    margin: const EdgeInsets.only(bottom: 1.5, right: 7.0),
                    height: 40.0,
                    width: 2.0,
                    decoration: BoxDecoration(
                        color: item.id == '0'
                            ? const Color.fromARGB(255, 5, 25, 172)
                            : Colors.blue,
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
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      if (item.id != 'cbv')
                        const SizedBox(
                          width: 10.0,
                        ),
                      if (item.id != 'cbv')
                        Image.asset(
                          'assets/images/ball_one.png',
                          width: 16.0,
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
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
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
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
              )),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  item.plusMinus,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
              )),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  item.gd,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
              )),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  item.pts,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
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

  Item({
    required this.id,
    required this.name,
    required this.mp,
    required this.plusMinus,
    required this.gd,
    required this.pts,
    required this.isSelected,
  });
}


class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({
    required this.child,
    });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [Colors.green, Colors.red],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}