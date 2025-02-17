

class Gate{

  final String name;
  final String id;
  Gate({
    required this.name,
    required this.id
  });

factory Gate.fromJson(Map<String,dynamic> json){
    return Gate(name: json["gateName"]??"", id: json["gateId"].toString());

}



}