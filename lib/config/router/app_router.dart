

import 'package:go_router/go_router.dart';
import 'package:miscelaneos_permissions/presentation/screens/screens.dart';

final router = GoRouter(
  routes: [

    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/permissions',
      builder: (context, state) => const PermissionScreen(),
    ),
    GoRoute(
      path: '/gyroscope',
      builder: (context, state) => const GyroscopeScreen(),
    ),
    GoRoute(
      path: '/gyroscope-ball',
      builder: (context, state) => const GyroscopeBallScreen(),
    ),
    GoRoute(
      path: '/acelerometer',
      builder: (context, state) => const AcelerometerScreen(),
    ),
    GoRoute(
      path: '/magnetometer',
      builder: (context, state) => const MagnometerScreen(),
    ),
    GoRoute(
      path: '/compass',
      builder: (context, state) => const CompassScreen(),
    ),
    GoRoute(
      path: '/storage',
      builder: (context, state) => const StorageScreen(),
    ),
  //Pokemons
    GoRoute(
      path: '/pokemons',
      builder: (context, state) => const PokemonsScreen(),
      
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final id = state.pathParameters['id'] ?? '1';
            return PokemonScreen(pokemonId:  id);
          },
        ),
      ]
    ),
    GoRoute(
      path: '/db-pokemons',
      builder: (context, state) => const DBPokemonsScreen(),
    ),
    GoRoute(
      path: '/biometrics',
      builder: (context, state) => const BiometricScreen(),
    ),
    GoRoute(
      path: '/controlled_map',
      builder: (context, state) => const ControlledMapScreen(),
    ),
    GoRoute(
      path: '/location',
      builder: (context, state) => const LocationScreen(),
    ),
    GoRoute(
      path: '/map',
      builder: (context, state) => const MapScreen(),
    ),
    GoRoute(
      path: '/bagde',
      builder: (context, state) => const BadgeScreen(),
    ),
    GoRoute(
      path: '/ad-fullscreen',
      builder: (context, state) => const AdFullScreen(),
    ),
    GoRoute(
      path: '/ad-rewarded',
      builder: (context, state) => const AdRewardedScreen(),
    ),
  ]

);