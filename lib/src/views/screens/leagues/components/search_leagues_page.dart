import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';
import 'package:footballscoreapp/src/models/league.dart';
import 'package:footballscoreapp/src/services/future_service/search_future.dart';
import 'package:footballscoreapp/src/views/widgets/search_widgets/leagues_search.dart';


class SearchLeaguesPage extends StatefulWidget {
  static const routeName = 'footballscoreapp/searchleaguespage';
  const SearchLeaguesPage({ Key? key }) : super(key: key);

  @override
  State<SearchLeaguesPage> createState() => _SearchLeaguesPageState();
}

class _SearchLeaguesPageState extends State<SearchLeaguesPage> {
  final _searchTextFieldController = TextEditingController();
  final _searchFormKey = GlobalKey<FormState>();

   List<League> _leaguesSearch = [];
  bool _leagueSearching = false;
  bool _leagueError = false;
  bool _leagueIsSearched = false;

  @override
  void initState() {
    super.initState();
    
  }

  Future _searchInLeagues(String search) async {
    setState(() {
      _leagueSearching = true;
      _leaguesSearch = [];
      _leagueIsSearched = false;
    });
    await SearchFuture().searchLeagues(search).then((value) {
      setState(() {
        _leaguesSearch = value;
        _leagueSearching = false;
        _leagueIsSearched = true;
      });
    }).onError((error, stackTrace) {
      setState(() {
        _leagueSearching = false;
        _leagueError = true;
        _leagueIsSearched = true;
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
                      await _searchInLeagues(value);
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
      body: _leagueSearching
          ?const  Center(
              child: CircularProgressIndicator(
                color: kBlueColor,
              ),
            )
          : _leagueIsSearched && _leaguesSearch.isEmpty?Center(
                  child: Text(
                    'Search not found!',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize:
                            Theme.of(context).textTheme.bodyText1!.fontSize! +
                                1),
                  ),
                ):
          LeaguesSearchPage(
        searchedLeagues: _leaguesSearch,
      ),
      
    );
  }
}