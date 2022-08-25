class ContactModel {
  ContactModel({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
  });

  int? id;
  String? firstName;
  String? lastName;
  List<dynamic>? phone;
  String? email;

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
    id: json["id"] == null ? null : json["id"],
    firstName: json["first_name"] == null ? "" : json["first_name"],
    lastName: json["last_name"] == null ? "" : json["last_name"],
    phone: json["phone"] == null ? null : List<String>.from(json["phone"].map((x) => x)),
    email: json["email"] == null ? null : json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "first_name": firstName == null ? null : firstName,
    "last_name": lastName == null ? null : lastName,
    "phone": phone == null ? [] : List<dynamic>.from(phone!.map((x) => x)),
    "email": email == null ? null : email,
  };
}
