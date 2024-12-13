

import 'package:miscelaneos_permissions/domain/domain.dart';
import 'package:miscelaneos_permissions/infrastructure/datasources/pokemons_datasource_impl.dart';

class PokemonsRepositoryImpl implements PokemonRepository {

  final PokemonDataSource datasource;

  PokemonsRepositoryImpl({ PokemonDataSource? datasource })
    : datasource = datasource ?? PokemonsDatasourceImpl();

  @override
  Future<(Pokemon?, String)> getPokemon(String id) {
    return datasource.getPokemon(id);
  }

}