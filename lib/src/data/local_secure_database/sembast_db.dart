// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sembast/sembast_io.dart';

// class SembastDB {
//   static final _sembastDB = SembastDB._();
//   static late Database db;
//   static bool _isInitialized = false;

//   SembastDB._();

//   factory SembastDB() {
//     return _sembastDB;
//   }

//   static Future<void> initSembastDB() async {
//     if (!_isInitialized) {
//       final dir = await getApplicationDocumentsDirectory();
//       await dir.create(recursive: true);
//       final dbPath = join(dir.path, 'vizzhy.db');
//       db = await databaseFactoryIo.openDatabase(dbPath);
//       _isInitialized = true;
//     }
//   }

//   static Future<void> storeIOTConnections(
//       String connection, String userId) async {
//     if (!_isInitialized) {
//       await initSembastDB();
//     }
//     final store = stringMapStoreFactory.store('iot-connections');
//     await store.record(connection).put(db, {'userId': userId});
//   }

//   static Future<String?> getIOTConnections(String connection) async {
//     if (!_isInitialized) {
//       await initSembastDB();
//     }
//     final store = stringMapStoreFactory.store('iot-connections');
//     final snapshot = await store.record(connection).get(db);
//     if (snapshot == null) {
//       return null;
//     }
//     return snapshot['userId'] as String?;
//   }

//   static Future<void> updateIOTConnections(
//       String connection, String? userId) async {
//     if (!_isInitialized) {
//       await initSembastDB();
//     }
//     final store = stringMapStoreFactory.store('iot-connections');
//     await store.record(connection).update(db, {'userId': userId});
//   }
// }
