import 'package:dio/dio.dart';
import 'package:miscelaneos_permissions/domain/domain.dart';
import 'package:miscelaneos_permissions/infrastructure/mappers/pokemon_mapper.dart';


class PokemonsDatasourceImpl implements PokemonDataSource {

  final Dio dio;

  PokemonsDatasourceImpl()
    : dio = Dio( BaseOptions(baseUrl: 'https://pokeapi.co/api/v2'));
 
  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    try {

      final resp = await dio.get('/pokemon/$id');
      final pokemon = PokemonMapper.pokeApiPokemonToEntity( resp.data );

      return (pokemon, 'Data obtenida correctamente');
    } catch (e) {
      return (null, 'No se pudo obtener el pokemon $e');
    }
  }

}