import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
class DatabaseHelper{
  static const _databaseName = 'Favorites.db';
  static const _databaseVersion = 1;


  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static  Database? _database;
  Future<Database> get database async{
    if(_database != null) return _database!;
    
    _database = await _initDatabase();
    return _database!;

  }

  _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // TODO: todo
    //leagueRound
    await db.execute('''
            CREATE TABLE FAVLEAGUES(
              leagueId INTEGER PRIMARY KEY,
              leagueName TEXT ,
              leagueCountry TEXT ,
              leagueLogo TEXT ,
              leagueCountryFlag TEXT ,
              leagueSeason INTEGER, 
              leagueRound TEXT 
            )
            ''');
    await db.execute('''
              CREATE TABLE FAVTEAMS(
                teamId INTEGER PRIMARY KEY,
                teamName TEXT ,
                teamCountryCode TEXT ,
                teamCountry TEXT ,
                teamFounded TEXT ,
                teamNational INTEGER ,
                teamLogo TEXT ,
                leagueId INTEGER ,
                leagueName TEXT ,
                leagueCountry TEXT ,
                leagueLogo TEXT ,
                leagueCountryFlag TEXT ,
                leagueSeason INTEGER, 
                leagueRound TEXT 

              )''');
  }

  Future<int> insertLeague(Map<String, dynamic> row) async{
   try {
      Database db = await instance.database;
    return await db.insert('FAVLEAGUES', row);
     
   } catch (e) {
     throw Exception(e.toString());
   }
    
  }
  Future<int> insertTeam(Map<String, dynamic> row) async{
    try {
      Database db = await instance.database;
    return await db.insert('FAVTEAMS', row);
      
    } catch (e) {
      throw Exception(e.toString());
    }
    
  }

  Future<List<Map<String, dynamic>>> getAllLeagues() async{
    Database db = await instance.database;
    return await db.query('FAVLEAGUES');
  }

  Future<List<Map<String, dynamic>>> getAllTeams() async{
    Database db = await instance.database;
    return await db.query('FAVTEAMS');
  }

  Future<int?> leaguesQueryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM FAVLEAGUES'));
  }

  Future<int?> teamsQueryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM FAVTEAMS'));
  }

  Future<int> deleteLeague(int id) async{
      Database db = await instance.database;
    return await db.delete('FAVLEAGUES', where: 'leagueId = ?', whereArgs: [id]);
  }

Future<int> deleteTeam(int id) async{
      Database db = await instance.database;
    return await db.delete('FAVTEAMS', where: 'teamId = ?', whereArgs: [id]);
  }

Future<List<Map<String, dynamic>>> isLeagueFound(int id) async{
   Database db = await instance.database;
   String _query = 'SELECT 1 FROM FAVLEAGUES WHERE leagueId=$id';
   return await db.rawQuery(_query);
}
Future<List<Map<String, dynamic>>> isTeamFound(int id) async{
   Database db = await instance.database;
   String _query = 'SELECT 1 FROM FAVTEAMS WHERE teamId=$id';
   return await db.rawQuery(_query);
}

}
