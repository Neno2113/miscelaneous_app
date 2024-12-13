import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos_permissions/config/config.dart';
import 'package:workmanager/workmanager.dart';




class BackgroundFetchNotifier extends StateNotifier<bool?> {

  final String processKeyName;

  BackgroundFetchNotifier({
    required this.processKeyName
  }): super(false){
    checkCurrentStatus();
  }

  toggleProcess() {
    if( state == true ){
      deactivateProcess();
    } else {
      activateProcess();
    }
  }

  checkCurrentStatus() async {
    state = await SharedPreferencesPlugin.getBool( processKeyName ) ?? false;
  }


  activateProcess() async {

    await Workmanager()
      .registerPeriodicTask(
        processKeyName, 
        processKeyName,
        frequency: const Duration( seconds: 10), // Lo cambiara a 15 minutos
        constraints: Constraints(
          networkType: NetworkType.connected
        ),
        tag: processKeyName,
      );

    await SharedPreferencesPlugin.setBool(processKeyName, true);
    state = true;

  }


  deactivateProcess() async {
    await Workmanager().cancelByTag(processKeyName);
    await SharedPreferencesPlugin.setBool(processKeyName, false);
    state = false;

  }

}



final backgroundPokemonFetchProvider = StateNotifierProvider<BackgroundFetchNotifier, bool?>((ref) {
  return BackgroundFetchNotifier(processKeyName: fetchPeriodicBackgorundTaskKey);
});