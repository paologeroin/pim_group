// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_sleep.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DrinkDao? _drinkDaoInstance;

  SleepDao? _sleepDaoInstance;

  LevelsDao? _levelDaoInstance;

  DataDao? _dataDaoInstance;

  GoalDao? _goalDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 5,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Drink` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `drinkType` TEXT NOT NULL, `dateTime` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Sleep` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `dateOfSleep` INTEGER NOT NULL, `startTime` INTEGER NOT NULL, `endTime` INTEGER NOT NULL, `duration` INTEGER NOT NULL, `minutesToFallAsleep` INTEGER NOT NULL, `minutesAsleep` INTEGER NOT NULL, `minutesAwake` INTEGER NOT NULL, `efficiency` INTEGER NOT NULL, `mainSleep` INTEGER NOT NULL, `levelName` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Levels` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `levelName` TEXT NOT NULL, `count` INTEGER NOT NULL, `minutes` INTEGER NOT NULL, `thirtyDayAvgMinutes` INTEGER NOT NULL, `sleepId` INTEGER NOT NULL, FOREIGN KEY (`sleepId`) REFERENCES `Levels` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Data` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `dateTime` INTEGER NOT NULL, `level` INTEGER NOT NULL, `seconds` INTEGER NOT NULL, `sleepId` INTEGER NOT NULL, FOREIGN KEY (`sleepId`) REFERENCES `Data` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Goal` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `money` REAL NOT NULL, `dateTime` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DrinkDao get drinkDao {
    return _drinkDaoInstance ??= _$DrinkDao(database, changeListener);
  }

  @override
  SleepDao get sleepDao {
    return _sleepDaoInstance ??= _$SleepDao(database, changeListener);
  }

  @override
  LevelsDao get levelDao {
    return _levelDaoInstance ??= _$LevelsDao(database, changeListener);
  }

  @override
  DataDao get dataDao {
    return _dataDaoInstance ??= _$DataDao(database, changeListener);
  }

  @override
  GoalDao get goalDao {
    return _goalDaoInstance ??= _$GoalDao(database, changeListener);
  }
}

class _$DrinkDao extends DrinkDao {
  _$DrinkDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _drinkInsertionAdapter = InsertionAdapter(
            database,
            'Drink',
            (Drink item) => <String, Object?>{
                  'id': item.id,
                  'drinkType': item.drinkType,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _drinkDeletionAdapter = DeletionAdapter(
            database,
            'Drink',
            ['id'],
            (Drink item) => <String, Object?>{
                  'id': item.id,
                  'drinkType': item.drinkType,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Drink> _drinkInsertionAdapter;

  final DeletionAdapter<Drink> _drinkDeletionAdapter;

  @override
  Future<List<Drink>> findAllDrinks() async {
    return _queryAdapter.queryList('SELECT * FROM Drink',
        mapper: (Map<String, Object?> row) => Drink(
            id: row['id'] as int?,
            drinkType: row['drinkType'] as String,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<List<Drink>> findDrinksOnDate(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Drink WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => Drink(id: row['id'] as int?, drinkType: row['drinkType'] as String, dateTime: _dateTimeConverter.decode(row['dateTime'] as int)),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<Drink>> findMostRecentDrink() async {
    return _queryAdapter.queryList('SELECT * FROM Drink ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => Drink(
            id: row['id'] as int?,
            drinkType: row['drinkType'] as String,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<void> insertDrink(Drink drink) async {
    await _drinkInsertionAdapter.insert(drink, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteDrink(Drink task) async {
    await _drinkDeletionAdapter.delete(task);
  }
}

class _$SleepDao extends SleepDao {
  _$SleepDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _sleepInsertionAdapter = InsertionAdapter(
            database,
            'Sleep',
            (Sleep item) => <String, Object?>{
                  'id': item.id,
                  'dateOfSleep': _dateTimeConverter.encode(item.dateOfSleep),
                  'startTime': _dateTimeConverter.encode(item.startTime),
                  'endTime': _dateTimeConverter.encode(item.endTime),
                  'duration': item.duration,
                  'minutesToFallAsleep': item.minutesToFallAsleep,
                  'minutesAsleep': item.minutesAsleep,
                  'minutesAwake': item.minutesAwake,
                  'efficiency': item.efficiency,
                  'mainSleep': item.mainSleep ? 1 : 0,
                  'levelName': item.levelName
                }),
        _sleepUpdateAdapter = UpdateAdapter(
            database,
            'Sleep',
            ['id'],
            (Sleep item) => <String, Object?>{
                  'id': item.id,
                  'dateOfSleep': _dateTimeConverter.encode(item.dateOfSleep),
                  'startTime': _dateTimeConverter.encode(item.startTime),
                  'endTime': _dateTimeConverter.encode(item.endTime),
                  'duration': item.duration,
                  'minutesToFallAsleep': item.minutesToFallAsleep,
                  'minutesAsleep': item.minutesAsleep,
                  'minutesAwake': item.minutesAwake,
                  'efficiency': item.efficiency,
                  'mainSleep': item.mainSleep ? 1 : 0,
                  'levelName': item.levelName
                }),
        _sleepDeletionAdapter = DeletionAdapter(
            database,
            'Sleep',
            ['id'],
            (Sleep item) => <String, Object?>{
                  'id': item.id,
                  'dateOfSleep': _dateTimeConverter.encode(item.dateOfSleep),
                  'startTime': _dateTimeConverter.encode(item.startTime),
                  'endTime': _dateTimeConverter.encode(item.endTime),
                  'duration': item.duration,
                  'minutesToFallAsleep': item.minutesToFallAsleep,
                  'minutesAsleep': item.minutesAsleep,
                  'minutesAwake': item.minutesAwake,
                  'efficiency': item.efficiency,
                  'mainSleep': item.mainSleep ? 1 : 0,
                  'levelName': item.levelName
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Sleep> _sleepInsertionAdapter;

  final UpdateAdapter<Sleep> _sleepUpdateAdapter;

  final DeletionAdapter<Sleep> _sleepDeletionAdapter;

  @override
  Future<List<Sleep>> findSleepbyDate(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Sleep WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => Sleep(row['id'] as int?, _dateTimeConverter.decode(row['dateOfSleep'] as int), _dateTimeConverter.decode(row['startTime'] as int), _dateTimeConverter.decode(row['endTime'] as int), row['duration'] as int, row['minutesToFallAsleep'] as int, row['minutesAsleep'] as int, row['minutesAwake'] as int, row['efficiency'] as int, (row['mainSleep'] as int) != 0, row['levelName'] as String),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<Sleep>> findAllSleep() async {
    return _queryAdapter.queryList('SELECT * FROM Sleep',
        mapper: (Map<String, Object?> row) => Sleep(
            row['id'] as int?,
            _dateTimeConverter.decode(row['dateOfSleep'] as int),
            _dateTimeConverter.decode(row['startTime'] as int),
            _dateTimeConverter.decode(row['endTime'] as int),
            row['duration'] as int,
            row['minutesToFallAsleep'] as int,
            row['minutesAsleep'] as int,
            row['minutesAwake'] as int,
            row['efficiency'] as int,
            (row['mainSleep'] as int) != 0,
            row['levelName'] as String));
  }

  @override
  Future<Sleep?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Sleep ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => Sleep(
            row['id'] as int?,
            _dateTimeConverter.decode(row['dateOfSleep'] as int),
            _dateTimeConverter.decode(row['startTime'] as int),
            _dateTimeConverter.decode(row['endTime'] as int),
            row['duration'] as int,
            row['minutesToFallAsleep'] as int,
            row['minutesAsleep'] as int,
            row['minutesAwake'] as int,
            row['efficiency'] as int,
            (row['mainSleep'] as int) != 0,
            row['levelName'] as String));
  }

  @override
  Future<Sleep?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Sleep ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => Sleep(
            row['id'] as int?,
            _dateTimeConverter.decode(row['dateOfSleep'] as int),
            _dateTimeConverter.decode(row['startTime'] as int),
            _dateTimeConverter.decode(row['endTime'] as int),
            row['duration'] as int,
            row['minutesToFallAsleep'] as int,
            row['minutesAsleep'] as int,
            row['minutesAwake'] as int,
            row['efficiency'] as int,
            (row['mainSleep'] as int) != 0,
            row['levelName'] as String));
  }

  @override
  Future<void> insertSleep(Sleep sleep) async {
    await _sleepInsertionAdapter.insert(sleep, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSleep(Sleep sleep) async {
    await _sleepUpdateAdapter.update(sleep, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteSleep(Sleep sleep) async {
    await _sleepDeletionAdapter.delete(sleep);
  }
}

class _$LevelsDao extends LevelsDao {
  _$LevelsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _levelsInsertionAdapter = InsertionAdapter(
            database,
            'Levels',
            (Levels item) => <String, Object?>{
                  'id': item.id,
                  'levelName': item.levelName,
                  'count': item.count,
                  'minutes': item.minutes,
                  'thirtyDayAvgMinutes': item.thirtyDayAvgMinutes,
                  'sleepId': item.sleepId
                }),
        _levelsUpdateAdapter = UpdateAdapter(
            database,
            'Levels',
            ['id'],
            (Levels item) => <String, Object?>{
                  'id': item.id,
                  'levelName': item.levelName,
                  'count': item.count,
                  'minutes': item.minutes,
                  'thirtyDayAvgMinutes': item.thirtyDayAvgMinutes,
                  'sleepId': item.sleepId
                }),
        _levelsDeletionAdapter = DeletionAdapter(
            database,
            'Levels',
            ['id'],
            (Levels item) => <String, Object?>{
                  'id': item.id,
                  'levelName': item.levelName,
                  'count': item.count,
                  'minutes': item.minutes,
                  'thirtyDayAvgMinutes': item.thirtyDayAvgMinutes,
                  'sleepId': item.sleepId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Levels> _levelsInsertionAdapter;

  final UpdateAdapter<Levels> _levelsUpdateAdapter;

  final DeletionAdapter<Levels> _levelsDeletionAdapter;

  @override
  Future<List<Levels>> findLevelsbyDate(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Levels WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => Levels(row['id'] as int, row['levelName'] as String, row['count'] as int, row['minutes'] as int, row['thirtyDayAvgMinutes'] as int, row['sleepId'] as int),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<Levels>> findAllLevels() async {
    return _queryAdapter.queryList('SELECT * FROM Levels',
        mapper: (Map<String, Object?> row) => Levels(
            row['id'] as int,
            row['levelName'] as String,
            row['count'] as int,
            row['minutes'] as int,
            row['thirtyDayAvgMinutes'] as int,
            row['sleepId'] as int));
  }

  @override
  Future<Levels?> getLevelsById(int id) async {
    return _queryAdapter.query('SELECT * FROM Level WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Levels(
            row['id'] as int,
            row['levelName'] as String,
            row['count'] as int,
            row['minutes'] as int,
            row['thirtyDayAvgMinutes'] as int,
            row['sleepId'] as int),
        arguments: [id]);
  }

  @override
  Future<List<Levels>> getLevelsForSleep(int sleepId) async {
    return _queryAdapter.queryList('SELECT * FROM Level WHERE sleepId = ?1',
        mapper: (Map<String, Object?> row) => Levels(
            row['id'] as int,
            row['levelName'] as String,
            row['count'] as int,
            row['minutes'] as int,
            row['thirtyDayAvgMinutes'] as int,
            row['sleepId'] as int),
        arguments: [sleepId]);
  }

  @override
  Future<int?> getAwakeCount(int sleepId) async {
    return _queryAdapter.query(
        'SELECT count FROM Levels WHERE levelName = \"awake\" AND sleepId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [sleepId]);
  }

  @override
  Future<void> insertLevels(Levels levels) async {
    await _levelsInsertionAdapter.insert(levels, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateLevels(Levels levels) async {
    await _levelsUpdateAdapter.update(levels, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteLevels(Levels levels) async {
    await _levelsDeletionAdapter.delete(levels);
  }
}

class _$DataDao extends DataDao {
  _$DataDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _dataInsertionAdapter = InsertionAdapter(
            database,
            'Data',
            (Data item) => <String, Object?>{
                  'id': item.id,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'level': item.level,
                  'seconds': item.seconds,
                  'sleepId': item.sleepId
                }),
        _dataUpdateAdapter = UpdateAdapter(
            database,
            'Data',
            ['id'],
            (Data item) => <String, Object?>{
                  'id': item.id,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'level': item.level,
                  'seconds': item.seconds,
                  'sleepId': item.sleepId
                }),
        _dataDeletionAdapter = DeletionAdapter(
            database,
            'Data',
            ['id'],
            (Data item) => <String, Object?>{
                  'id': item.id,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'level': item.level,
                  'seconds': item.seconds,
                  'sleepId': item.sleepId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Data> _dataInsertionAdapter;

  final UpdateAdapter<Data> _dataUpdateAdapter;

  final DeletionAdapter<Data> _dataDeletionAdapter;

  @override
  Future<List<Data>> findDatabyDate(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Data WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => Data(row['id'] as int?, _dateTimeConverter.decode(row['dateTime'] as int), row['level'] as int, row['seconds'] as int, row['sleepId'] as int),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<Data>> findAllData() async {
    return _queryAdapter.queryList('SELECT * FROM Data',
        mapper: (Map<String, Object?> row) => Data(
            row['id'] as int?,
            _dateTimeConverter.decode(row['dateTime'] as int),
            row['level'] as int,
            row['seconds'] as int,
            row['sleepId'] as int));
  }

  @override
  Future<Data?> getDataById(int id) async {
    return _queryAdapter.query('SELECT * FROM Data WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Data(
            row['id'] as int?,
            _dateTimeConverter.decode(row['dateTime'] as int),
            row['level'] as int,
            row['seconds'] as int,
            row['sleepId'] as int),
        arguments: [id]);
  }

  @override
  Future<List<Data>> getDataForSleep(int sleepId) async {
    return _queryAdapter.queryList('SELECT * FROM Level WHERE sleepId = ?1',
        mapper: (Map<String, Object?> row) => Data(
            row['id'] as int?,
            _dateTimeConverter.decode(row['dateTime'] as int),
            row['level'] as int,
            row['seconds'] as int,
            row['sleepId'] as int),
        arguments: [sleepId]);
  }

  @override
  Future<void> insertData(Data data) async {
    await _dataInsertionAdapter.insert(data, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateData(Data data) async {
    await _dataUpdateAdapter.update(data, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteData(Data data) async {
    await _dataDeletionAdapter.delete(data);
  }
}

class _$GoalDao extends GoalDao {
  _$GoalDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _goalInsertionAdapter = InsertionAdapter(
            database,
            'Goal',
            (Goal item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'money': item.money,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _goalUpdateAdapter = UpdateAdapter(
            database,
            'Goal',
            ['id'],
            (Goal item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'money': item.money,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _goalDeletionAdapter = DeletionAdapter(
            database,
            'Goal',
            ['id'],
            (Goal item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'money': item.money,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Goal> _goalInsertionAdapter;

  final UpdateAdapter<Goal> _goalUpdateAdapter;

  final DeletionAdapter<Goal> _goalDeletionAdapter;

  @override
  Future<List<Goal>> findAllGoals() async {
    return _queryAdapter.queryList('SELECT * FROM Goal',
        mapper: (Map<String, Object?> row) => Goal(
            id: row['id'] as int?,
            name: row['name'] as String,
            money: row['money'] as double,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<List<Goal>> findMostRecentGoal() async {
    return _queryAdapter.queryList('SELECT * FROM Goal ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => Goal(
            id: row['id'] as int?,
            name: row['name'] as String,
            money: row['money'] as double,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<void> insertGoal(Goal goal) async {
    await _goalInsertionAdapter.insert(goal, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateGoal(Goal goal) async {
    await _goalUpdateAdapter.update(goal, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteGoal(Goal task) async {
    await _goalDeletionAdapter.delete(task);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
