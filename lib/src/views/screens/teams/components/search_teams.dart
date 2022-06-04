import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/models/models.dart';
import 'package:footballscoreapp/src/services/future_service/search_future.dart';
import 'package:footballscoreapp/src/views/widgets/search_widgets/teams_search.dart';

class SearchTeamsPage extends StatefulWidget {
  static const routeName = 'footballscoreapp/searchteamsPage';
  const SearchTeamsPage({Key? key}) : super(key: key);

  @override
  State<SearchTeamsPage> createState() => _SearchTeamsPageState();
}

class _SearchTeamsPageState extends State<SearchTeamsPage> {
  final _searchTextFieldController = TextEditingController();
  final _searchFormKey = GlobalKey<FormState>();

  List<TeamModel> _teamsSearch = [];
  bool _teamsSearching = false;
  bool _teamError = false;
  bool _teamIsSearched = false;

  @override
  void initState() {
    super.initState();
  }

  Future _searchInTeams(String search) async {
    setState(() {
      _teamsSearching = true;
      _teamsSearch = [];
      _teamIsSearched = false;
    });
    await SearchFuture().searchTeams(search).then((value) {
      setState(() {
        _teamsSearch = value;
        _teamsSearching = false;
        _teamIsSearched = true;
      });
    }).onError((error, stackTrace) {
      setState(() {
        _teamsSearching = false;
        _teamError = true;
        _teamIsSearched = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Form(
          key: _searchFormKey,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) async {
                    if (value.length >= 4) {
                      await _searchInTeams(value);
                    }
                  },
                  controller: _searchTextFieldController,
                  // cursorHeight: 25.0,
                  style: const TextStyle(color: kWhiteColor, fontSize: 16.0),

                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    fillColor: Colors.black.withOpacity(0.3),
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    // contentPadding: const EdgeInsets.all(0.0),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: kBlueColor,
                      width: 3.0,
                    )),
                    suffix: GestureDetector(
                      onTap: (() {
                        _searchTextFieldController.clear();
                      }),
                      child: Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(
                          Icons.close,
                          size: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: kBlueColor),
            ),
          )
        ],
      ),
      body: _teamsSearching
          ? const Center(
              child: CircularProgressIndicator(
                color: kBlueColor,
              ),
            )
          : _teamIsSearched && _teamsSearch.isEmpty
              ? Center(
                  child: Text(
                    'Search not found!',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize:
                            Theme.of(context).textTheme.bodyText1!.fontSize! +
                                1),
                  ),
                )
              : TeamsSearchPage(
                  searchedTeams: _teamsSearch,
                ),
    );
  }
}
