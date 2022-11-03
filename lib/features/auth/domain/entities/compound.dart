class Compound {
  String? imgUrl ;
  String? name ;
  String? address ;
  Compound({required this.name , required this.imgUrl , required this.address});
  Compound.formJson(Map<String , dynamic > json ){
    imgUrl = json["imgUrl"];
    name = json["name"];
    address = json["address"];
  }
  Map<String , dynamic > toJson ()=>{
    "imgUrl" :imgUrl,
    "name" : name,
    "address" : address,
  };

}

