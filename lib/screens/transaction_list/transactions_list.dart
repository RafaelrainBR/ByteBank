import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/loading_component.dart';
import 'package:bytebank/models/transaction_model.dart';
import 'package:bytebank/web/webclients/transactions_webclient.dart';

import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final TransactionsWebClient _webClient = TransactionsWebClient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _webClient.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return LoadingWidget();
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final transactions = snapshot.data;
                if (transactions.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.monetization_on),
                          title: Text(
                            transaction.value.toString(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            transaction.contact.account.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: transactions.length,
                  );
                }
              }

              return CenteredMessage(
                "No transactions found.",
                icon: Icons.warning,
              );
            default:
              break;
          }
          return CenteredMessage("Unknown error.");
        },
      ),
    );
  }
}
