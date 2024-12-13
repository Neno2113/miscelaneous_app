import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class MenuItem {
  final String title;
  final IconData icon;
  final String route;

  MenuItem(this.title, this.icon, this.route);
}


final menuItems = <MenuItem>[
  MenuItem('Giroscopio', Icons.downloading, '/gyroscope'),
  MenuItem('Acelemetro', Icons.speed, '/acelerometer'),
  MenuItem('Magnetometro', Icons.explore_outlined, '/magnetometer'),
  MenuItem('Giroscopio Ball', Icons.sports_baseball_outlined, '/gyroscope-ball'),
  MenuItem('Brujula', Icons.explore, '/compass'),
  MenuItem('Almacenamiento', Icons.storage_outlined, '/storage'),
  MenuItem('Pokemons', Icons.catching_pokemon, '/pokemons'),
  MenuItem('Background Process', Icons.storage_rounded, '/db-pokemons'),
  MenuItem('Biometrics', Icons.fingerprint, '/biometrics'),
  MenuItem('Location', Icons.gps_fixed, '/location'),
  MenuItem('Map', Icons.map_outlined, '/map'),
  MenuItem('Controlled Map', Icons.gamepad_outlined, '/controlled_map'),
  MenuItem('Badge', Icons.notifications_active_sharp, '/bagde'),
  MenuItem('Ad Full', Icons.ad_units_rounded, '/ad-fullscreen'),
  MenuItem('Ad Rewarded', Icons.fort_rounded, '/ad-rewarded'),
];



class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children:  menuItems.map((item) => 
        HomeMenuItem(
          title: item.title, 
          route: item.route, 
          icon: item.icon
        )

      ).toList(),
    );
  }
}


class HomeMenuItem extends StatelessWidget {

  final String title;
  final String route;
  final IconData icon;
  final List<Color> bgColor;

  const HomeMenuItem({
    super.key, 
    required this.title, 
    required this.route, 
    required this.icon, 
    this.bgColor = const [ Colors.lightBlue, Colors.blue ]
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: bgColor,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon( icon, color:Colors.white, size: 35,),
            const SizedBox( height: 10, ),
            Text(title, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: const TextStyle( color: Colors.white),),
          ],
    
        ),
      ),
    );
  }
}