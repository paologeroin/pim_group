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
            'CREATE TABLE IF NOT EXISTS `Sleep` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date` TEXT, `dateOfSleep` TEXT, `startTime` TEXT, `endTime` TEXT, `duration` REAL, `minutesToFallAsleep` INTEGER, `minutesAsleep` INTEGER, `minutesAwake` INTEGER, `minutesAfterWakeup` INTEGER, `efficiency` INTEGER, `logType` TEXT, `mainSleep` INTEGER, `levels` TEXT, `DailyData` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `levels` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `data` TEXT NOT NULL, `summary` TEXT NOT NULL, `sleep_id` TEXT NOT NULL, FOREIGN KEY (`sleep_id`) REFERENCES `Sleep` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `data` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `dateTime` INTEGER NOT NULL, `level` INTEGER NOT NULL, `seconds` INTEGER NOT NULL, `levels_id` TEXT NOT NULL, FOREIGN KEY (`levels_id`) REFERENCES `levels` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
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
  Future<void> deleteDrink(Drink drink) async {
    await _drinkDeletionAdapter.delete(drink);
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
                  'date': item.date,
                  'dateOfSleep': item.dateOfSleep,
                  'startTime': item.startTime,
                  'endTime': item.endTime,
                  'duration': item.duration,
                  'minutesToFallAsleep': item.minutesToFallAsleep,
                  'minutesAsleep': item.minutesAsleep,
                  'minutesAwake': item.minutesAwake,
                  'minutesAfterWakeup': item.minutesAfterWakeup,
                  'efficiency': item.efficiency,
                  'logType': item.logType,
                  'mainSleep':
                      item.mainSleep == null ? null : (item.mainSleep! ? 1 : 0),
                  'levels': item.levels,
                  'DailyData': item.DailyData ? 1 : 0
                }),
        _sleepUpdateAdapter = UpdateAdapter(
            database,
            'Sleep',
            ['id'],
            (Sleep item) => <String, Object?>{
                  'id': item.id,
                  'date': item.date,
                  'dateOfSleep': item.dateOfSleep,
                  'startTime': item.startTime,
                  'endTime': item.endTime,
                  'duration': item.duration,
                  'minutesToFallAsleep': item.minutesToFallAsleep,
                  'minutesAsleep': item.minutesAsleep,
                  'minutesAwake': item.minutesAwake,
                  'minutesAfterWakeup': item.minutesAfterWakeup,
                  'efficiency': item.efficiency,
                  'logType': item.logType,
                  'mainSleep':
                      item.mainSleep == null ? null : (item.mainSleep! ? 1 : 0),
                  'levels': item.levels,
                  'DailyData': item.DailyData ? 1 : 0
                }),
        _sleepDeletionAdapter = DeletionAdapter(
            database,
            'Sleep',
            ['id'],
            (Sleep item) => <String, Object?>{
                  'id': item.id,
                  'date': item.date,
                  'dateOfSleep': item.dateOfSleep,
                  'startTime': item.startTime,
                  'endTime': item.endTime,
                  'duration': item.duration,
                  'minutesToFallAsleep': item.minutesToFallAsleep,
                  'minutesAsleep': item.minutesAsleep,
                  'minutesAwake': item.minutesAwake,
                  'minutesAfterWakeup': item.minutesAfterWakeup,
                  'efficiency': item.efficiency,
                  'logType': item.logType,
                  'mainSleep':
                      item.mainSleep == null ? null : (item.mainSleep! ? 1 : 0),
                  'levels': item.levels,
                  'DailyData': item.DailyData ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Sleep> _sleepInsertionAdapter;

  final UpdateAdapter<Sleep> _sleepUpdateAdapter;

  final DeletionAdapter<Sleep> _sleepDeletionAdapter;

  @override
  Future<List<Sleep>> findSleepbyDate(String date) async {
    return _queryAdapter.queryList('SELECT * FROM Sleep WHERE date = ?1',
        mapper: (Map<String, Object?> row) => Sleep(
            id: row['id'] as int?,
            date: row['date'] as String?,
            dateOfSleep: row['dateOfSleep'] as String?,
            startTime: row['startTime'] as String?,
            endTime: row['endTime'] as String?,
            duration: row['duration'] as double?,
            minutesToFallAsleep: row['minutesToFallAsleep'] as int?,
            minutesAsleep: row['minutesAsleep'] as int?,
            minutesAwake: row['minutesAwake'] as int?,
            minutesAfterWakeup: row['minutesAfterWakeup'] as int?,
            efficiency: row['efficiency'] as int?,
            logType: row['logType'] as String?,
            mainSleep: row['mainSleep'] == null
                ? null
                : (row['mainSleep'] as int) != 0,
            levels: row['levels'] as String?),
        arguments: [date]);
  }

  @override
  Future<List<Sleep>> findAllSleep() async {
    return _queryAdapter.queryList('SELECT * FROM Sleep',
        mapper: (Map<String, Object?> row) => Sleep(
            id: row['id'] as int?,
            date: row['date'] as String?,
            dateOfSleep: row['dateOfSleep'] as String?,
            startTime: row['startTime'] as String?,
            endTime: row['endTime'] as String?,
            duration: row['duration'] as double?,
            minutesToFallAsleep: row['minutesToFallAsleep'] as int?,
            minutesAsleep: row['minutesAsleep'] as int?,
            minutesAwake: row['minutesAwake'] as int?,
            minutesAfterWakeup: row['minutesAfterWakeup'] as int?,
            efficiency: row['efficiency'] as int?,
            logType: row['logType'] as String?,
            mainSleep: row['mainSleep'] == null
                ? null
                : (row['mainSleep'] as int) != 0,
            levels: row['levels'] as String?));
  }

  @override
  Future<Sleep?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Sleep ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => Sleep(
            id: row['id'] as int?,
            date: row['date'] as String?,
            dateOfSleep: row['dateOfSleep'] as String?,
            startTime: row['startTime'] as String?,
            endTime: row['endTime'] as String?,
            duration: row['duration'] as double?,
            minutesToFallAsleep: row['minutesToFallAsleep'] as int?,
            minutesAsleep: row['minutesAsleep'] as int?,
            minutesAwake: row['minutesAwake'] as int?,
            minutesAfterWakeup: row['minutesAfterWakeup'] as int?,
            efficiency: row['efficiency'] as int?,
            logType: row['logType'] as String?,
            mainSleep: row['mainSleep'] == null
                ? null
                : (row['mainSleep'] as int) != 0,
            levels: row['levels'] as String?));
  }

  @override
  Future<Sleep?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Sleep ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => Sleep(
            id: row['id'] as int?,
            date: row['date'] as String?,
            dateOfSleep: row['dateOfSleep'] as String?,
            startTime: row['startTime'] as String?,
            endTime: row['endTime'] as String?,
            duration: row['duration'] as double?,
            minutesToFallAsleep: row['minutesToFallAsleep'] as int?,
            minutesAsleep: row['minutesAsleep'] as int?,
            minutesAwake: row['minutesAwake'] as int?,
            minutesAfterWakeup: row['minutesAfterWakeup'] as int?,
            efficiency: row['efficiency'] as int?,
            logType: row['logType'] as String?,
            mainSleep: row['mainSleep'] == null
                ? null
                : (row['mainSleep'] as int) != 0,
            levels: row['levels'] as String?));
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
  Future<void> deleteSleep(Sleep task) async {
    await _sleepDeletionAdapter.delete(task);
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
