import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:cookbook/injection.config.dart';

final getIt = GetIt.instance;

@module
abstract class FirebaseModule {
  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}

@InjectableInit()
void configureDependencies() => getIt.init();
