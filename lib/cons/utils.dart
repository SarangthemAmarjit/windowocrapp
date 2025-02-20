import 'dart:math';

String getDate({ required String? dateTime,int duration = 0}){
  try{

  
 DateTime d  =  DateTime.parse( dateTime!).add(Duration(days: duration));
  return '${d.day}/${d.month}/${d.year}';

  }catch(e){

  }
  return "NA";
}

String generateRandomString(int length) {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  Random random = Random();
  
  return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
}
