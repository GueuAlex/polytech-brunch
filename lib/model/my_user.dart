// To parse this JSON data, do
//
//     final myUserModel = myUserModelFromJson(jsonString);

import 'dart:convert';

MyUserModel myUserModelFromJson(String str) =>
    MyUserModel.fromJson(json.decode(str));

String myUserModelToJson(MyUserModel data) => json.encode(data.toJson());

class MyUserModel {
  int id;
  String nom;
  String prenoms;
  DateTime dateVisite;
  String heureEntreeViste;
  String? heureSortieVisite;
  String? numeroCni;
  String? plaqueVehicule;
  String email;
  String number;
  int isAlreadyScanned;

  MyUserModel({
    required this.id,
    required this.nom,
    required this.prenoms,
    required this.dateVisite,
    required this.heureEntreeViste,
    this.heureSortieVisite,
    this.numeroCni,
    this.plaqueVehicule,
    required this.email,
    required this.number,
    this.isAlreadyScanned = 0,
  });

  factory MyUserModel.fromJson(Map<String, dynamic> json) => MyUserModel(
        id: json["id"],
        nom: json["nom"],
        prenoms: json["prenoms"],
        dateVisite: DateTime.parse(json["date_visite"]),
        heureEntreeViste: json["heure_entree_viste"],
        heureSortieVisite: json["heure_sortie_visite"],
        numeroCni: json["numero_cni"],
        plaqueVehicule: json["plaque_vehicule"],
        email: json["email"],
        number: json["number"],
        isAlreadyScanned: json["is_already_scanned"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "prenoms": prenoms,
        "date_visite":
            "${dateVisite.year.toString().padLeft(4, '0')}-${dateVisite.month.toString().padLeft(2, '0')}-${dateVisite.day.toString().padLeft(2, '0')}",
        "heure_entree_viste": heureEntreeViste,
        "heure_sortie_visite": heureSortieVisite,
        "numero_cni": numeroCni,
        "plaque_vehicule": plaqueVehicule,
        "email": email,
        "number": number,
        "is_already_scanned": isAlreadyScanned,
      };

  static List<MyUserModel> userList = [];
}
