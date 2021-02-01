import 'package:bytebank/models/transaction_model.dart';
import 'package:bytebank/web/web_client.dart';

import 'dart:convert';

class TransactionsWebClient {
  static const _baseUrl = baseUrl + "/transactions";

  static const Map<String, String> _headers = {
    'Content-type': 'application/json',
    'password': '1000',
  };

  Future<List<Transaction>> findAll() async {
    final response =
        await webClient.get(_baseUrl).timeout(Duration(seconds: 15));
    final responseBody = jsonDecode(response.body);

    return responseBody
        .map(
          (json) => Transaction.fromJson(json),
        )
        .toList();
  }

  Future<Transaction> save(final Transaction transaction) async {
    final body = jsonEncode(transaction.toJson());

    final response =
        await webClient.post(_baseUrl, headers: _headers, body: body);
    final responseBody = jsonDecode(response.body);

    return Transaction.fromJson(responseBody);
  }
}
