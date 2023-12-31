import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier{

//late SharedPreferences _prefs;
late Box box;

Map <String,String> locale= {
  'locate': 'pt_BR','locale':'en_US'
};


AppSettings(){
  _startSettings();
}

_startSettings() async{
  await _startPreferences();
  await _readLocale();
}

Future <void> _startPreferences() async{
  //_prefs=await SharedPreferences.getInstance();
  box= await Hive.openBox('Preferencias');
}

_readLocale(){
  //final local = _prefs.getString('local')?? 'pt_BR';
  //final name = _prefs.getString('name')?? 'R\$';
  final local = box.get('local')?? 'pt_BR';
  final name  = box.get ('name')?? 'R\$';

  locale={
    'locale':local,
    'name':name
    };
    notifyListeners();

}

setLocale(String local,String name) async{
  //await _prefs.setString('local', local);
  //await _prefs.setString('name', name);
  await box.put('local', name);
  await box.put('name', name);
  await _readLocale();
}



}
