import 'package:cinema_pedia_app/infrastructure/repositories/local_database_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinema_pedia_app/infrastructure/datasources/local_db_datasource.dart';

final localDbRepositoryProvider = Provider((ref) {
  return LocalDatabaseImpl(datasource: LocalDbDatasource());
});
