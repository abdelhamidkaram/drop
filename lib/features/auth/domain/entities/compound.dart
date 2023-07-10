class Compound {
  String? imgUrl ;
  String? name ;
  String? address ;
  String? unitNumber ;
  Compound({required this.name , required this.imgUrl , required this.address , this.unitNumber});
  Compound.formJson(Map<String , dynamic > json ){
    imgUrl = json["imgUrl"];
    name = json["name"];
    address = json["address"];
    unitNumber = json["unitNumber"];
  }
  Map<String , dynamic > toJson ()=>{
    "imgUrl" :imgUrl,
    "name" : name,
    "address" : address,
    "unitNumber" : unitNumber,
  };

}

