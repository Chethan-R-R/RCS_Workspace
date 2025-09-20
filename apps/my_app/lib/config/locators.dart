import 'package:database/repo_impl/core_repo_impl/core_api_repo_impl.dart';
import 'package:database/repo_impl/core_repo_impl/core_db_repo_impl.dart';
import 'package:database/repo_impl/sales_rep_repo_impl/sales_rep_api_repo_impl.dart';
import 'package:database/repo_impl/sales_rep_repo_impl/sales_rep_db_repo_impl.dart';
import 'package:database/repository/core_repo/core_api_repo.dart';
import 'package:database/repository/core_repo/core_db_repo.dart';
import 'package:database/repository/sales_rep_repo/sales_rep_api_repo.dart';
import 'package:database/repository/sales_rep_repo/sales_rep_db_repo.dart';
import 'package:get_it/get_it.dart';

void setupLocators() {
  GetIt.I.registerSingleton<CoreApiRepo>(CoreApiRepoImpl());
  GetIt.I.registerSingleton<CoreDbRepo>(CoreDbRepoImpl());
  GetIt.I.registerSingleton<SalesRepApiRepo>(SalesRepApiRepoImpl());
  GetIt.I.registerSingleton<SalesRepDbRepo>(SalesRepDbRepoImpl());
}
