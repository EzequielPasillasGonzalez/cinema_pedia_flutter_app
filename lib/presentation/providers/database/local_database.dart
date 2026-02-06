import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinema_pedia_app/infrastructure/datasources/local_db_datasource.dart';

final localDbDatasourceProvider = Provider<LocalDbDatasource>((ref) {
  return LocalDbDatasource();
});
