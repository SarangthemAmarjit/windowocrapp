String getDate({ required String dateTime,int duration = 0}){
  try{
  DateTime? d = DateTime.tryParse(dateTime);
  
 d =  d!.add(Duration(days: duration));
  return '${d.day}/${d.month}/${d.year}';

  }catch(e){

  }
  return "NA";
}