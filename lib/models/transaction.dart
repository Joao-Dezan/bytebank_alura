import 'package:bytebank/models/contact.dart';

class Transaction {
  final double value;
  final Contact contact;

  Transaction({
    required this.value,
    required this.contact,
  });

  Transaction.fromJson(Map<String, dynamic> json)
    : value = json['value'],
      contact = Contact.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
    'value': value,
    'contact': contact.toJson()
  };
}
