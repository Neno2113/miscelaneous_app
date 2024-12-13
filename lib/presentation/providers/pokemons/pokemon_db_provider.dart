
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos_permissions/domain/domain.dart';
import 'package:miscelaneos_permissions/infrastructure/infrastructure.dart';



final pokemonDBProvider = FutureProvider.autoDispose<List<Pokemon>>((ref) async {

  final localDB = LocalDBRepositoryImpl();
  final pokemons = await localDB.loadPokemons();

  return pokemons;
});