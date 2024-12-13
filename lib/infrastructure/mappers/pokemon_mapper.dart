


import 'package:miscelaneos_permissions/domain/domain.dart';
import 'package:miscelaneos_permissions/infrastructure/models/pokeapi_pokemon_response.dart';

class PokemonMapper {

  static Pokemon pokeApiPokemonToEntity( Map<String, dynamic> json ){

    final pokeApiPokemon = PokeApiResponse.fromJson(json);

    return Pokemon(
      id: pokeApiPokemon.id, 
      name: pokeApiPokemon.name, 
      spriteFront: pokeApiPokemon.sprites.frontDefault
    );
  }
}