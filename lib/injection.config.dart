// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cookbook/data/data_sources/recipe_data_source.dart' as _i19;
import 'package:cookbook/data/data_sources/recipe_firestore_data_source.dart'
    as _i839;
import 'package:cookbook/data/data_sources/recipe_local_data_source.dart'
    as _i380;
import 'package:cookbook/domain/repositories/recipe_repository.dart' as _i33;
import 'package:cookbook/presentation/blocs/recipe_cubit.dart' as _i848;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i19.RecipeDataSource>(
      () => _i380.RecipeLocalDataSource(),
      instanceName: 'local',
    );
    gh.factory<_i19.RecipeDataSource>(
      () => _i839.RecipeFirestoreDataSource(),
      instanceName: 'firestore',
    );
    gh.factory<_i33.RecipeRepository>(
      () => _i33.RecipeRepository(
        gh<_i19.RecipeDataSource>(instanceName: 'local'),
      ),
    );
    gh.factory<_i848.RecipeCubit>(
      () => _i848.RecipeCubit(gh<_i33.RecipeRepository>()),
    );
    return this;
  }
}
