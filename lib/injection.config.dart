// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cookbook/features/recipe/data_sources/recipe_data_source.dart'
    as _i1020;
import 'package:cookbook/features/recipe/data_sources/recipe_firestore_data_source.dart'
    as _i35;
import 'package:cookbook/features/recipe/data_sources/recipe_local_data_source.dart'
    as _i568;
import 'package:cookbook/features/recipe/presentation/blocs/recipe_cubit.dart'
    as _i651;
import 'package:cookbook/features/recipe/repositories/recipe_repository.dart'
    as _i885;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i1020.RecipeDataSource>(
      () => _i568.RecipeLocalDataSource(),
      instanceName: 'local',
    );
    gh.factory<_i1020.RecipeDataSource>(
      () => _i35.RecipeFirestoreDataSource(),
      instanceName: 'firestore',
    );
    gh.factory<_i885.RecipeRepository>(
      () => _i885.RecipeRepository(
        gh<_i1020.RecipeDataSource>(instanceName: 'local'),
      ),
    );
    gh.factory<_i651.RecipeCubit>(
      () => _i651.RecipeCubit(gh<_i885.RecipeRepository>()),
    );
    return this;
  }
}
