import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos_permissions/config/config.dart';


const storeKeys = 'showAds';

class ShowAdsNotifier extends StateNotifier<bool> {
  
  ShowAdsNotifier(): super( false );


  void checkAdSatte() async {
    state = await SharedPreferencesPlugin.getBool(storeKeys) ?? true;
  }

  void removeAds(){
    SharedPreferencesPlugin.setBool(storeKeys, false);
    state = false;
  }

  
  void showAds(){
    SharedPreferencesPlugin.setBool(storeKeys, true);
    state = true;
  }

  void toggleAds(){
    state ? removeAds() : showAds();
  }

}


final showAdsProvider = StateNotifierProvider<ShowAdsNotifier, bool>((ref) {
  return ShowAdsNotifier();
});