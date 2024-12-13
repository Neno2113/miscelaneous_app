import 'package:miscelaneos_permissions/domain/domain.dart';
import 'package:miscelaneos_permissions/infrastructure/datasources/isar_db_datasource.dart';




class LocalDBRepositoryImpl extends LocalDbRepository {

  final LocalDbDatasource _datasource;

  LocalDBRepositoryImpl([ LocalDbDatasource? datasource ])
    : _datasource = datasource ?? IsarLocalDbDatasource();

  @override
  Future<void> insertPokemon(Pokemon pokemon) {
    return _datasource.insertPokemon(pokemon);
  }

  @override
  Future<List<Pokemon>> loadPokemons() {
    return _datasource.loadPokemons();
  }

  @override
  Future<int> pokemonsCount() {
    return _datasource.pokemonsCount();
  }

}