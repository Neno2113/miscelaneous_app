


import 'package:miscelaneos_permissions/domain/domain.dart';

abstract class PokemonDataSource {

  Future<( Pokemon?, String )> getPokemon( String id );

}