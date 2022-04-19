class Contact {
  final int? id;
  final String name;
  final int accountNumber;

  Contact({
    this.id,
    required this.name,
    required this.accountNumber,
  });

  Contact.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      accountNumber = json['accountNumber'];

  Map<String, dynamic> toJson() =>
    id != null ?
      {
        'id': id,
        'name': name,
        'accountNumber': accountNumber
      }
    : {
        'name': name,
        'accountNumber': accountNumber
      };


  @override
  String toString() {
    return 'Contact {${this.id != null ? 'id: $id, ' : null} name: "$name", accountNumber: $accountNumber}';
  }
}
