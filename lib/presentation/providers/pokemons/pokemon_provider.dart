import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos_permissions/domain/domain.dart';
import 'package:miscelaneos_permissions/infrastructure/repositories/pokemons_repository_impl.dart';

final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonsRepositoryImpl();
});

final pokemonProvider = FutureProvider.family<Pokemon, String >((ref, id) async {

  final pokemonReposiry = ref.watch( pokemonRepositoryProvider );

  final ( pokemon, msg ) = await pokemonReposiry.getPokemon(id);

  if( pokemon != null) return pokemon;

  throw msg;
});