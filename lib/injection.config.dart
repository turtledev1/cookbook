// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:cookbook/data/data_sources/parsers/hellofresh/hellofresh_parser.dart'
    as _i1044;
import 'package:cookbook/data/data_sources/recipe_data_source.dart' as _i19;
import 'package:cookbook/data/data_sources/recipe_firestore_data_source.dart'
    as _i839;
import 'package:cookbook/domain/repositories/recipe_repository.dart' as _i33;
import 'package:cookbook/injection.dart' as _i435;
import 'package:cookbook/presentation/blocs/import_recipe_cubit.dart' as _i736;
import 'package:cookbook/presentation/blocs/recipe_cubit.dart' as _i848;
import 'package:cookbook/presentation/blocs/settings_cubit.dart' as _i138;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    gh.factory<_i1044.HelloFreshParser>(() => _i1044.HelloFreshParser());
    gh.singleton<_i138.SettingsCubit>(() => _i138.SettingsCubit());
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.factory<_i19.RecipeDataSource>(
      () => _i839.RecipeFirestoreDataSource(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i33.RecipeRepository>(
      () => _i33.RecipeRepository(gh<_i19.RecipeDataSource>()),
    );
    gh.factory<_i736.ImportRecipeCubit>(
      () => _i736.ImportRecipeCubit(
        gh<_i33.RecipeRepository>(),
        gh<_i1044.HelloFreshParser>(),
      ),
    );
    gh.factory<_i848.RecipeCubit>(
      () => _i848.RecipeCubit(
        gh<_i33.RecipeRepository>(),
        gh<_i138.SettingsCubit>(),
      ),
    );
    return this;
  }
}

class _$FirebaseModule extends _i435.FirebaseModule {}
