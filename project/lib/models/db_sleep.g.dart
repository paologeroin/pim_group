// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_sleep.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorSleepDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$SleepDatabaseBuilder databaseBuilder(String name) =>
      _$SleepDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$SleepDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$SleepDatabaseBuilder(null);
}

class _$SleepDatabaseBuilder {
  _$SleepDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$SleepDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$SleepDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<SleepDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$SleepDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$SleepDatabase extends SleepDatabase {
  _$SleepDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  SleepDurationDao? _sleepDurationDaoInstance;

  EfficiencyDao? _efficiencyDaoInstance;

  DataDao? _dataDaoInstance;

  TimeLimitDao? _timeLimitDaoInstance;

  MinutesDao? _minutesDaoInstance;

  LevelsDao? _levelsDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 4,
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
            'CREATE TABLE IF NOT EXISTS `SleepDuration` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `durationValue` INTEGER NOT NULL, `timestamp` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Efficiency` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `efficiency` INTEGER NOT NULL, `timestamp` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Data` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `dateTime` INTEGER NOT NULL, `level` INTEGER NOT NULL, `seconds` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TimeLimit` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `startingTime` INTEGER NOT NULL, `endingTime` INTEGER NOT NULL, `timestamp` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Minutes` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `minutesAsleep` INTEGER NOT NULL, `minutesAwake` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `levels` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `deep` TEXT NOT NULL, `light` TEXT NOT NULL, `rem` TEXT NOT NULL, `awake` TEXT NOT NULL, FOREIGN KEY (`count`, `minutes`, `thirtyDayAvgMinutes`) REFERENCES `levels` (`deep`, `light`, `rem`, `awake`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  SleepDurationDao get sleepDurationDao {
    return _sleepDurationDaoInstance ??=
        _$SleepDurationDao(database, changeListener);
  }

  @override
  EfficiencyDao get efficiencyDao {
    return _efficiencyDaoInstance ??= _$EfficiencyDao(database, changeListener);
  }

  @override
  DataDao get dataDao {
    return _dataDaoInstance ??= _$DataDao(database, changeListener);
  }

  @override
  TimeLimitDao get timeLimitDao {
    return _timeLimitDaoInstance ??= _$TimeLimitDao(database, changeListener);
  }

  @override
  MinutesDao get minutesDao {
    return _minutesDaoInstance ??= _$MinutesDao(database, changeListener);
  }

  @override
  LevelsDao get levelsDao {
    return _levelsDaoInstance ??= _$LevelsDao(database, changeListener);
  }
}

class _$SleepDurationDao extends SleepDurationDao {
  _$SleepDurationDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _sleepDurationInsertionAdapter = InsertionAdapter(
            database,
            'SleepDuration',
            (SleepDuration item) => <String, Object?>{
                  'id': item.id,
                  'durationValue': item.durationValue,
                  'timestamp': _dateTimeConverter.encode(item.timestamp)
                }),
        _sleepDurationUpdateAdapter = UpdateAdapter(
            database,
            'SleepDuration',
            ['id'],
            (SleepDuration item) => <String, Object?>{
                  'id': item.id,
                  'durationValue': item.durationValue,
                  'timestamp': _dateTimeConverter.encode(item.timestamp)
                }),
        _sleepDurationDeletionAdapter = DeletionAdapter(
            database,
            'SleepDuration',
            ['id'],
            (SleepDuration item) => <String, Object?>{
                  'id': item.id,
                  'durationValue': item.durationValue,
                  'timestamp': _dateTimeConverter.encode(item.timestamp)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SleepDuration> _sleepDurationInsertionAdapter;

  final UpdateAdapter<SleepDuration> _sleepDurationUpdateAdapter;

  final DeletionAdapter<SleepDuration> _sleepDurationDeletionAdapter;

  @override
  Future<List<SleepDuration>> findExposuresbyDate(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Exposure WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => SleepDuration(row['id'] as int?, row['durationValue'] as int, _dateTimeConverter.decode(row['timestamp'] as int)),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<SleepDuration>> findAllSleepDuration() async {
    return _queryAdapter.queryList('SELECT * FROM Exposure',
        mapper: (Map<String, Object?> row) => SleepDuration(
            row['id'] as int?,
            row['durationValue'] as int,
            _dateTimeConverter.decode(row['timestamp'] as int)));
  }

  @override
  Future<SleepDuration?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Exposure ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => SleepDuration(
            row['id'] as int?,
            row['durationValue'] as int,
            _dateTimeConverter.decode(row['timestamp'] as int)));
  }

  @override
  Future<SleepDuration?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Exposure ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => SleepDuration(
            row['id'] as int?,
            row['durationValue'] as int,
            _dateTimeConverter.decode(row['timestamp'] as int)));
  }

  @override
  Future<void> insertSleepDuration(SleepDuration sleepDurations) async {
    await _sleepDurationInsertionAdapter.insert(
        sleepDurations, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSleepDuration(SleepDuration sleepDurations) async {
    await _sleepDurationUpdateAdapter.update(
        sleepDurations, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteSleepDuration(SleepDuration sleepDurations) async {
    await _sleepDurationDeletionAdapter.delete(sleepDurations);
  }
}

class _$EfficiencyDao extends EfficiencyDao {
  _$EfficiencyDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _efficiencyInsertionAdapter = InsertionAdapter(
            database,
            'Efficiency',
            (Efficiency item) => <String, Object?>{
                  'id': item.id,
                  'efficiency': item.efficiency,
                  'timestamp': _dateTimeConverter.encode(item.timestamp)
                }),
        _efficiencyUpdateAdapter = UpdateAdapter(
            database,
            'Efficiency',
            ['id'],
            (Efficiency item) => <String, Object?>{
                  'id': item.id,
                  'efficiency': item.efficiency,
                  'timestamp': _dateTimeConverter.encode(item.timestamp)
                }),
        _efficiencyDeletionAdapter = DeletionAdapter(
            database,
            'Efficiency',
            ['id'],
            (Efficiency item) => <String, Object?>{
                  'id': item.id,
                  'efficiency': item.efficiency,
                  'timestamp': _dateTimeConverter.encode(item.timestamp)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Efficiency> _efficiencyInsertionAdapter;

  final UpdateAdapter<Efficiency> _efficiencyUpdateAdapter;

  final DeletionAdapter<Efficiency> _efficiencyDeletionAdapter;

  @override
  Future<List<Efficiency>> findEfficienciesbyDate(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Efficiency WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => Efficiency(row['id'] as int?, row['efficiency'] as int, _dateTimeConverter.decode(row['timestamp'] as int)),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<Efficiency>> findAllEfficiencies() async {
    return _queryAdapter.queryList('SELECT * FROM Efficiency',
        mapper: (Map<String, Object?> row) => Efficiency(
            row['id'] as int?,
            row['efficiency'] as int,
            _dateTimeConverter.decode(row['timestamp'] as int)));
  }

  @override
  Future<Efficiency?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Efficiency ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => Efficiency(
            row['id'] as int?,
            row['efficiency'] as int,
            _dateTimeConverter.decode(row['timestamp'] as int)));
  }

  @override
  Future<Efficiency?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Efficiency ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => Efficiency(
            row['id'] as int?,
            row['efficiency'] as int,
            _dateTimeConverter.decode(row['timestamp'] as int)));
  }

  @override
  Future<void> insertEfficiency(Efficiency efficiencies) async {
    await _efficiencyInsertionAdapter.insert(
        efficiencies, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateEfficiency(Efficiency efficiencies) async {
    await _efficiencyUpdateAdapter.update(
        efficiencies, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteEfficiency(Efficiency efficiencies) async {
    await _efficiencyDeletionAdapter.delete(efficiencies);
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
                  'seconds': item.seconds
                }),
        _dataUpdateAdapter = UpdateAdapter(
            database,
            'Data',
            ['id'],
            (Data item) => <String, Object?>{
                  'id': item.id,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'level': item.level,
                  'seconds': item.seconds
                }),
        _dataDeletionAdapter = DeletionAdapter(
            database,
            'Data',
            ['id'],
            (Data item) => <String, Object?>{
                  'id': item.id,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'level': item.level,
                  'seconds': item.seconds
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
        mapper: (Map<String, Object?> row) => Data(row['id'] as int?, _dateTimeConverter.decode(row['dateTime'] as int), row['level'] as int, row['seconds'] as int),
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
            row['seconds'] as int));
  }

  @override
  Future<Data?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Data ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => Data(
            row['id'] as int?,
            _dateTimeConverter.decode(row['dateTime'] as int),
            row['level'] as int,
            row['seconds'] as int));
  }

  @override
  Future<Data?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Data ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => Data(
            row['id'] as int?,
            _dateTimeConverter.decode(row['dateTime'] as int),
            row['level'] as int,
            row['seconds'] as int));
  }

  @override
  Future<void> insertData(Data data) async {
    await _dataInsertionAdapter.insert(data, OnConflictStrategy.abort);
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

class _$TimeLimitDao extends TimeLimitDao {
  _$TimeLimitDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _timeLimitInsertionAdapter = InsertionAdapter(
            database,
            'TimeLimit',
            (TimeLimit item) => <String, Object?>{
                  'id': item.id,
                  'startingTime': _dateTimeConverter.encode(item.startingTime),
                  'endingTime': _dateTimeConverter.encode(item.endingTime),
                  'timestamp': _dateTimeConverter.encode(item.timestamp)
                }),
        _timeLimitUpdateAdapter = UpdateAdapter(
            database,
            'TimeLimit',
            ['id'],
            (TimeLimit item) => <String, Object?>{
                  'id': item.id,
                  'startingTime': _dateTimeConverter.encode(item.startingTime),
                  'endingTime': _dateTimeConverter.encode(item.endingTime),
                  'timestamp': _dateTimeConverter.encode(item.timestamp)
                }),
        _timeLimitDeletionAdapter = DeletionAdapter(
            database,
            'TimeLimit',
            ['id'],
            (TimeLimit item) => <String, Object?>{
                  'id': item.id,
                  'startingTime': _dateTimeConverter.encode(item.startingTime),
                  'endingTime': _dateTimeConverter.encode(item.endingTime),
                  'timestamp': _dateTimeConverter.encode(item.timestamp)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TimeLimit> _timeLimitInsertionAdapter;

  final UpdateAdapter<TimeLimit> _timeLimitUpdateAdapter;

  final DeletionAdapter<TimeLimit> _timeLimitDeletionAdapter;

  @override
  Future<List<TimeLimit>> findAllTimeLimit() async {
    return _queryAdapter.queryList('SELECT * FROM TimeLimit',
        mapper: (Map<String, Object?> row) => TimeLimit(
            row['id'] as int?,
            _dateTimeConverter.decode(row['startingTime'] as int),
            _dateTimeConverter.decode(row['endingTime'] as int),
            _dateTimeConverter.decode(row['timestamp'] as int)));
  }

  @override
  Future<TimeLimit?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM TimeLimit ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => TimeLimit(
            row['id'] as int?,
            _dateTimeConverter.decode(row['startingTime'] as int),
            _dateTimeConverter.decode(row['endingTime'] as int),
            _dateTimeConverter.decode(row['timestamp'] as int)));
  }

  @override
  Future<TimeLimit?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM TimeLimit ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => TimeLimit(
            row['id'] as int?,
            _dateTimeConverter.decode(row['startingTime'] as int),
            _dateTimeConverter.decode(row['endingTime'] as int),
            _dateTimeConverter.decode(row['timestamp'] as int)));
  }

  @override
  Future<void> insertTimeLimit(TimeLimit data) async {
    await _timeLimitInsertionAdapter.insert(data, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTimeLimit(TimeLimit timeLimit) async {
    await _timeLimitUpdateAdapter.update(timeLimit, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteTimeLimit(TimeLimit data) async {
    await _timeLimitDeletionAdapter.delete(data);
  }
}

class _$MinutesDao extends MinutesDao {
  _$MinutesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _minutesInsertionAdapter = InsertionAdapter(
            database,
            'Minutes',
            (Minutes item) => <String, Object?>{
                  'id': item.id,
                  'minutesAsleep': item.minutesAsleep,
                  'minutesAwake': item.minutesAwake
                }),
        _minutesUpdateAdapter = UpdateAdapter(
            database,
            'Minutes',
            ['id'],
            (Minutes item) => <String, Object?>{
                  'id': item.id,
                  'minutesAsleep': item.minutesAsleep,
                  'minutesAwake': item.minutesAwake
                }),
        _minutesDeletionAdapter = DeletionAdapter(
            database,
            'Minutes',
            ['id'],
            (Minutes item) => <String, Object?>{
                  'id': item.id,
                  'minutesAsleep': item.minutesAsleep,
                  'minutesAwake': item.minutesAwake
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Minutes> _minutesInsertionAdapter;

  final UpdateAdapter<Minutes> _minutesUpdateAdapter;

  final DeletionAdapter<Minutes> _minutesDeletionAdapter;

  @override
  Future<List<Minutes>> findMinutesbyDate(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Exposure WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => Minutes(row['id'] as int?, row['minutesAsleep'] as int, row['minutesAwake'] as int),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<Minutes>> findAllMinutes() async {
    return _queryAdapter.queryList('SELECT * FROM Exposure',
        mapper: (Map<String, Object?> row) => Minutes(row['id'] as int?,
            row['minutesAsleep'] as int, row['minutesAwake'] as int));
  }

  @override
  Future<Minutes?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Exposure ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => Minutes(row['id'] as int?,
            row['minutesAsleep'] as int, row['minutesAwake'] as int));
  }

  @override
  Future<Minutes?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Exposure ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => Minutes(row['id'] as int?,
            row['minutesAsleep'] as int, row['minutesAwake'] as int));
  }

  @override
  Future<void> insertMinutes(Minutes minutes) async {
    await _minutesInsertionAdapter.insert(minutes, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMinutes(Minutes minutes) async {
    await _minutesUpdateAdapter.update(minutes, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteMinutes(Minutes minutes) async {
    await _minutesDeletionAdapter.delete(minutes);
  }
}

class _$LevelsDao extends LevelsDao {
  _$LevelsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _levelsInsertionAdapter = InsertionAdapter(
            database,
            'levels',
            (Levels item) => <String, Object?>{
                  'id': item.id,
                  'deep': item.deep,
                  'light': item.light,
                  'rem': item.rem,
                  'awake': item.awake
                }),
        _levelsUpdateAdapter = UpdateAdapter(
            database,
            'levels',
            ['id'],
            (Levels item) => <String, Object?>{
                  'id': item.id,
                  'deep': item.deep,
                  'light': item.light,
                  'rem': item.rem,
                  'awake': item.awake
                }),
        _levelsDeletionAdapter = DeletionAdapter(
            database,
            'levels',
            ['id'],
            (Levels item) => <String, Object?>{
                  'id': item.id,
                  'deep': item.deep,
                  'light': item.light,
                  'rem': item.rem,
                  'awake': item.awake
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
        mapper: (Map<String, Object?> row) => Levels(row['id'] as int?, row['deep'] as String, row['light'] as String, row['rem'] as String, row['awake'] as String),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<Levels>> findAllLevels() async {
    return _queryAdapter.queryList('SELECT * FROM Levels',
        mapper: (Map<String, Object?> row) => Levels(
            row['id'] as int?,
            row['deep'] as String,
            row['light'] as String,
            row['rem'] as String,
            row['awake'] as String));
  }

  @override
  Future<Levels?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Levels ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => Levels(
            row['id'] as int?,
            row['deep'] as String,
            row['light'] as String,
            row['rem'] as String,
            row['awake'] as String));
  }

  @override
  Future<Levels?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Levels ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => Levels(
            row['id'] as int?,
            row['deep'] as String,
            row['light'] as String,
            row['rem'] as String,
            row['awake'] as String));
  }

  @override
  Future<void> insertLevels(Levels levels) async {
    await _levelsInsertionAdapter.insert(levels, OnConflictStrategy.abort);
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

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
