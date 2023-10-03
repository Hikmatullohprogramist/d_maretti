
class HisobotModel {
  String naqd;
  String plastik;
  String chiqimNaqd;
  String chiqimPlastik;
  String haridorNaqd;
  String haridorPlastik;
  String vozvratNaqd;
  String vozvratPlastik;

  HisobotModel({
    required this.naqd,
    required this.plastik,
    required this.chiqimNaqd,
    required this.chiqimPlastik,
    required this.haridorNaqd,
    required this.haridorPlastik,
    required this.vozvratNaqd,
    required this.vozvratPlastik,
  });

  factory HisobotModel.fromJson(Map<String, dynamic> json) => HisobotModel(
    naqd: json["Naqd"],
    plastik: json["Plastik"],
    chiqimNaqd: json["chiqim_naqd"],
    chiqimPlastik: json["chiqim_plastik"],
    haridorNaqd: json["haridor_naqd"],
    haridorPlastik: json["haridor_plastik"],
    vozvratNaqd: json["vozvrat_naqd"],
    vozvratPlastik: json["vozvrat_plastik"],
  );

  Map<String, dynamic> toJson() => {
    "Naqd": naqd,
    "Plastik": plastik,
    "chiqim_naqd": chiqimNaqd,
    "chiqim_plastik": chiqimPlastik,
    "haridor_naqd": haridorNaqd,
    "haridor_plastik": haridorPlastik,
    "vozvrat_naqd": vozvratNaqd,
    "vozvrat_plastik": vozvratPlastik,
  };
}
