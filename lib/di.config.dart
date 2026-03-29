// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/api_manager.dart' as _i331;
import 'repository/local/home_local_repo.dart' as _i895;
import 'repository/local/home_local_repo_impl.dart' as _i883;
import 'repository/remote/home_remote_repo.dart' as _i233;
import 'repository/remote/home_remote_repo_impl.dart' as _i493;
import 'screens/cubit/cubit.dart' as _i123;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i331.ApiManager>(() => _i331.ApiManager());
    gh.factory<_i895.HomeLocalRepo>(() => _i883.HomeLocalRepoImpl());
    gh.factory<_i233.HomeRemoteRepo>(
      () => _i493.HomeRemoteRepoImpl(gh<_i331.ApiManager>()),
    );
    gh.factory<_i123.HomeCubit>(
      () => _i123.HomeCubit(
        gh<_i233.HomeRemoteRepo>(),
        gh<_i895.HomeLocalRepo>(),
      ),
    );
    return this;
  }
}
