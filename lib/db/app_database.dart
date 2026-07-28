import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();

  static const _dbName = 'put_smisla.db';
  static const _dbVersion = 1;

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;

    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, _dbName);

    _db = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );

    return _db!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE lessons (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        subtitle TEXT NOT NULL,
        chapterNumber INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE questions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        lessonId INTEGER NOT NULL,
        questionNumber INTEGER NOT NULL,
        questionText TEXT NOT NULL,
        answerText TEXT NOT NULL,
        isCorrect INTEGER NOT NULL,
        FOREIGN KEY (lessonId) REFERENCES lessons(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE session_progress (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        lessonId INTEGER NOT NULL,
        isCompleted INTEGER NOT NULL,
        bestScore INTEGER NOT NULL,
        unlocked INTEGER NOT NULL,
        FOREIGN KEY (userId) REFERENCES users(id),
        FOREIGN KEY (lessonId) REFERENCES lessons(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        text TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        FOREIGN KEY (userId) REFERENCES users(id)
      )
    ''');

    await _insertInitialData(db);
  }

  Future<void> _insertInitialData(Database db) async {
    await db.insert('lessons', {
      'id': 1,
      'title': 'Level 1 • Što je smisao?',
      'subtitle': 'Uvod u logoterapiju: čovjek i potraga za smislom.',
      'chapterNumber': 1,
    });

    await db.insert('lessons', {
      'id': 2,
      'title': 'Level 2 • Sloboda i odgovornost',
      'subtitle': 'Između podražaja i reakcije — postoji prostor izbora.',
      'chapterNumber': 2,
    });

    await db.insert('lessons', {
      'id': 3,
      'title': 'Level 3 • Stav prema patnji',
      'subtitle': 'Kad se okolnosti ne mogu promijeniti — ostaje stav.',
      'chapterNumber': 3,
    });

    await _insertQuestions(db);
  }

  Future<void> _insertAnswer(
    Database db, {
    required int lessonId,
    required int questionNumber,
    required String questionText,
    required String answerText,
    required int isCorrect,
  }) async {
    await db.insert('questions', {
      'lessonId': lessonId,
      'questionNumber': questionNumber,
      'questionText': questionText,
      'answerText': answerText,
      'isCorrect': isCorrect,
    });
  }

  Future<void> _insertQuestions(Database db) async {
    // LEVEL 1
    await _insertAnswer(
      db,
      lessonId: 1,
      questionNumber: 1,
      questionText: 'Što je temeljna motivacija čovjeka prema logoterapiji?',
      answerText: 'Potraga za smislom',
      isCorrect: 1,
    );
    await _insertAnswer(
      db,
      lessonId: 1,
      questionNumber: 1,
      questionText: 'Što je temeljna motivacija čovjeka prema logoterapiji?',
      answerText: 'Potraga za ugodom',
      isCorrect: 0,
    );
    await _insertAnswer(
      db,
      lessonId: 1,
      questionNumber: 1,
      questionText: 'Što je temeljna motivacija čovjeka prema logoterapiji?',
      answerText: 'Potraga za moći',
      isCorrect: 0,
    );
    await _insertAnswer(
      db,
      lessonId: 1,
      questionNumber: 1,
      questionText: 'Što je temeljna motivacija čovjeka prema logoterapiji?',
      answerText: 'Izbjegavanje boli',
      isCorrect: 0,
    );

    await _insertAnswer(
      db,
      lessonId: 1,
      questionNumber: 2,
      questionText: 'Smisao se prema Franklu najčešće otkriva…',
      answerText: 'u konkretnim situacijama života',
      isCorrect: 1,
    );
    await _insertAnswer(
      db,
      lessonId: 1,
      questionNumber: 2,
      questionText: 'Smisao se prema Franklu najčešće otkriva…',
      answerText: 'u apstraktnim definicijama i teoriji',
      isCorrect: 0,
    );
    await _insertAnswer(
      db,
      lessonId: 1,
      questionNumber: 2,
      questionText: 'Smisao se prema Franklu najčešće otkriva…',
      answerText: 'isključivo u uspjehu i postignuću',
      isCorrect: 0,
    );
    await _insertAnswer(
      db,
      lessonId: 1,
      questionNumber: 2,
      questionText: 'Smisao se prema Franklu najčešće otkriva…',
      answerText: 'samo kroz doživljaje ugode',
      isCorrect: 0,
    );

    await _insertAnswer(
      db,
      lessonId: 1,
      questionNumber: 3,
      questionText: 'Koje od navedenog je jedan od Franklovih puteva do smisla?',
      answerText: 'Vrijednosti stava',
      isCorrect: 1,
    );
    await _insertAnswer(
      db,
      lessonId: 1,
      questionNumber: 3,
      questionText: 'Koje od navedenog je jedan od Franklovih puteva do smisla?',
      answerText: 'Vrijednosti perfekcionizma',
      isCorrect: 0,
    );
    await _insertAnswer(
      db,
      lessonId: 1,
      questionNumber: 3,
      questionText: 'Koje od navedenog je jedan od Franklovih puteva do smisla?',
      answerText: 'Vrijednosti natjecanja',
      isCorrect: 0,
    );
    await _insertAnswer(
      db,
      lessonId: 1,
      questionNumber: 3,
      questionText: 'Koje od navedenog je jedan od Franklovih puteva do smisla?',
      answerText: 'Vrijednosti popularnosti',
      isCorrect: 0,
    );

    // LEVEL 2
    await _insertAnswer(
      db,
      lessonId: 2,
      questionNumber: 1,
      questionText: 'Što se nalazi između podražaja i reakcije?',
      answerText: 'Prostor izbora',
      isCorrect: 1,
    );
    await _insertAnswer(
      db,
      lessonId: 2,
      questionNumber: 1,
      questionText: 'Što se nalazi između podražaja i reakcije?',
      answerText: 'Navika',
      isCorrect: 0,
    );
    await _insertAnswer(
      db,
      lessonId: 2,
      questionNumber: 1,
      questionText: 'Što se nalazi između podražaja i reakcije?',
      answerText: 'Samo emocije',
      isCorrect: 0,
    );
    await _insertAnswer(
      db,
      lessonId: 2,
      questionNumber: 1,
      questionText: 'Što se nalazi između podražaja i reakcije?',
      answerText: 'Slučajnost',
      isCorrect: 0,
    );

    await _insertAnswer(
      db,
      lessonId: 2,
      questionNumber: 2,
      questionText: 'Odgovornost u logoterapiji znači prvenstveno…',
      answerText: 'preuzimanje odgovora na životne situacije',
      isCorrect: 1,
    );
    await _insertAnswer(
      db,
      lessonId: 2,
      questionNumber: 2,
      questionText: 'Odgovornost u logoterapiji znači prvenstveno…',
      answerText: 'krivnju za sve što se dogodi',
      isCorrect: 0,
    );
    await _insertAnswer(
      db,
      lessonId: 2,
      questionNumber: 2,
      questionText: 'Odgovornost u logoterapiji znači prvenstveno…',
      answerText: 'potpunu kontrolu nad okolnostima',
      isCorrect: 0,
    );
    await _insertAnswer(
      db,
      lessonId: 2,
      questionNumber: 2,
      questionText: 'Odgovornost u logoterapiji znači prvenstveno…',
      answerText: 'izbjegavanje pogrešaka',
      isCorrect: 0,
    );

    await _insertAnswer(
      db,
      lessonId: 2,
      questionNumber: 3,
      questionText: 'Koja je tvrdnja najbliža logoterapiji?',
      answerText: 'Smisao može postojati i bez ugodnih osjećaja',
      isCorrect: 1,
    );
    await _insertAnswer(
      db,
      lessonId: 2,
      questionNumber: 3,
      questionText: 'Koja je tvrdnja najbliža logoterapiji?',
      answerText: 'Smisao ovisi o stalno dobrim osjećajima',
      isCorrect: 0,
    );
    await _insertAnswer(
      db,
      lessonId: 2,
      questionNumber: 3,
      questionText: 'Koja je tvrdnja najbliža logoterapiji?',
      answerText: 'Smisao je stabilan i nepromjenjiv',
      isCorrect: 0,
    );
    await _insertAnswer(
      db,
      lessonId: 2,
      questionNumber: 3,
      questionText: 'Koja je tvrdnja najbliža logoterapiji?',
      answerText: 'Smisao je isto što i sreća',
      isCorrect: 0,
    );

    // LEVEL 3
    await _insertAnswer(
      db,
      lessonId: 3,
      questionNumber: 1,
      questionText: 'Kako logoterapija gleda na patnju?',
      answerText: 'Patnja nije cilj, ali stav može dati smisao kad je neizbježna',
      isCorrect: 1,
    );
    await _insertAnswer(
      db,
      lessonId: 3,
      questionNumber: 1,
      questionText: 'Kako logoterapija gleda na patnju?',
      answerText: 'Patnja je uvijek besmislena',
      isCorrect: 0,
    );
    await _insertAnswer(
      db,
      lessonId: 3,
      questionNumber: 1,
      questionText: 'Kako logoterapija gleda na patnju?',
      answerText: 'Patnju treba tražiti da bismo rasli',
      isCorrect: 0,
    );
    await _insertAnswer(
      db,
      lessonId: 3,
      questionNumber: 1,
      questionText: 'Kako logoterapija gleda na patnju?',
      answerText: 'Patnja se rješava samo pozitivnim mislima',
      isCorrect: 0,
    );

    await _insertAnswer(
      db,
      lessonId: 3,
      questionNumber: 2,
      questionText: 'Vrijednosti stava najviše dolaze do izražaja kada…',
      answerText: 'okolnosti ne mogu promijeniti, ali mogu birati stav',
      isCorrect: 1,
    );
    await _insertAnswer(
      db,
      lessonId: 3,
      questionNumber: 2,
      questionText: 'Vrijednosti stava najviše dolaze do izražaja kada…',
      answerText: 'sve ide savršeno',
      isCorrect: 0,
    );
    await _insertAnswer(
      db,
      lessonId: 3,
      questionNumber: 2,
      questionText: 'Vrijednosti stava najviše dolaze do izražaja kada…',
      answerText: 'mogu u potpunosti promijeniti okolnosti',
      isCorrect: 0,
    );
    await _insertAnswer(
      db,
      lessonId: 3,
      questionNumber: 2,
      questionText: 'Vrijednosti stava najviše dolaze do izražaja kada…',
      answerText: 'imam dovoljno vremena i motivacije',
      isCorrect: 0,
    );

    await _insertAnswer(
      db,
      lessonId: 3,
      questionNumber: 3,
      questionText: 'Koja je najbolja IT-mjerljiva potvrda napretka u ovoj aplikaciji?',
      answerText: 'Korisnik završi edukaciju i odgovori na pitanja',
      isCorrect: 1,
    );
    await _insertAnswer(
      db,
      lessonId: 3,
      questionNumber: 3,
      questionText: 'Koja je najbolja IT-mjerljiva potvrda napretka u ovoj aplikaciji?',
      answerText: 'Aplikacija analizira dubinu emocija u tekstu',
      isCorrect: 0,
    );
    await _insertAnswer(
      db,
      lessonId: 3,
      questionNumber: 3,
      questionText: 'Koja je najbolja IT-mjerljiva potvrda napretka u ovoj aplikaciji?',
      answerText: 'Korisnik dobije savjet liječnika',
      isCorrect: 0,
    );
    await _insertAnswer(
      db,
      lessonId: 3,
      questionNumber: 3,
      questionText: 'Koja je najbolja IT-mjerljiva potvrda napretka u ovoj aplikaciji?',
      answerText: 'Korisnik uvijek odabere najpozitivniji odgovor',
      isCorrect: 0,
    );
  }

  Future<int> registerUser(String username, String password) async {
    final database = await db;

    final userId = await database.insert('users', {
      'username': username,
      'password': password,
    });

    await createDefaultProgressForUser(userId);

    return userId;
  }

  Future<Map<String, Object?>?> loginUser(
    String username,
    String password,
  ) async {
    final database = await db;

    final result = await database.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
      limit: 1,
    );

    if (result.isEmpty) return null;
    return result.first;
  }

  Future<void> createDefaultProgressForUser(int userId) async {
    final database = await db;

    for (int lessonId = 1; lessonId <= 3; lessonId++) {
      await database.insert('session_progress', {
        'userId': userId,
        'lessonId': lessonId,
        'isCompleted': 0,
        'bestScore': 0,
        'unlocked': lessonId == 1 ? 1 : 0,
      });
    }
  }

  Future<List<Map<String, Object?>>> getProgress(int userId) async {
    final database = await db;

    return database.query(
      'session_progress',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'lessonId ASC',
    );
  }

  Future<void> completeLesson({
    required int userId,
    required int lessonId,
    required int score,
  }) async {
    final database = await db;

    final old = await database.query(
      'session_progress',
      where: 'userId = ? AND lessonId = ?',
      whereArgs: [userId, lessonId],
      limit: 1,
    );

    final oldBest = old.isNotEmpty ? old.first['bestScore'] as int : 0;
    final newBest = score > oldBest ? score : oldBest;

    await database.update(
      'session_progress',
      {
        'isCompleted': 1,
        'bestScore': newBest,
        'unlocked': 1,
      },
      where: 'userId = ? AND lessonId = ?',
      whereArgs: [userId, lessonId],
    );

    if (lessonId < 3) {
      await database.update(
        'session_progress',
        {'unlocked': 1},
        where: 'userId = ? AND lessonId = ?',
        whereArgs: [userId, lessonId + 1],
      );
    }
  }

  Future<List<Map<String, Object?>>> getAnswersForQuestion({
    required int lessonId,
    required int questionNumber,
  }) async {
    final database = await db;

    return database.query(
      'questions',
      where: 'lessonId = ? AND questionNumber = ?',
      whereArgs: [lessonId, questionNumber],
      orderBy: 'RANDOM()',
    );
  }

  Future<List<int>> getQuestionNumbersForLesson(int lessonId) async {
    final database = await db;

    final result = await database.rawQuery(
      '''
      SELECT DISTINCT questionNumber
      FROM questions
      WHERE lessonId = ?
      ORDER BY questionNumber ASC
      ''',
      [lessonId],
    );

    return result.map((row) => row['questionNumber'] as int).toList();
  }

  Future<void> resetProgress(int userId) async {
    final database = await db;

    for (int lessonId = 1; lessonId <= 3; lessonId++) {
      await database.update(
        'session_progress',
        {
          'isCompleted': 0,
          'bestScore': 0,
          'unlocked': lessonId == 1 ? 1 : 0,
        },
        where: 'userId = ? AND lessonId = ?',
        whereArgs: [userId, lessonId],
      );
    }
  }

  Future<int> insertNote({
    required int userId,
    required String text,
  }) async {
    final database = await db;

    return database.insert('notes', {
      'userId': userId,
      'text': text,
      'createdAt': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, Object?>>> getNotes(int userId) async {
    final database = await db;

    return database.query(
      'notes',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'id DESC',
    );
  }

  Future<int> updateNote({
    required int id,
    required String text,
  }) async {
    final database = await db;

    return database.update(
      'notes',
      {'text': text},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteNote(int id) async {
    final database = await db;

    return database.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}