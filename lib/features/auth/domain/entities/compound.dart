class Compound {
  String? imgUrl ;
  String? name ;
  String? address ;

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

