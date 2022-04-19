import 'dart:convert';

import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

import 'package:bytebank/http/webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final timeLimit = Duration(seconds: 5);

    try {
      final Response response = await client.get(baseUrl).timeout(timeLimit);

      if (response.statusCode != 200) return [];

      final List<dynamic> decodedJson = jsonDecode(response.body);

      return decodedJson.map((e) =>
          Transaction.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<Transaction?> save(Transaction transaction) async {

    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(
      baseUrl,
      headers: {'Content-type': 'application/json', 'password': '2000'},
      body: transactionJson,
    );

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }
  }
}