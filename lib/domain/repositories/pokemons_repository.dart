
import 'package:miscelaneos_permissions/domain/domain.dart';


abstract class PokemonRepository {

  Future<( Pokemon?, String )> getPokemon( String id );

}