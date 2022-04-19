import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransactionsList extends StatefulWidget {
  TransactionsList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        initialData: [],
        future: _webClient.findAll(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final List<Transaction> transactions = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.active:
              break;

            case ConnectionState.done:
              if (transactions.isEmpty) {
                return CenteredMessage(
                  message: 'No transactions found',
                  icon: Icons.warning_rounded,
                  iconSize: 48.0,
                  fontSize: 18.0,
                );
              }
              return ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return _buildTransactionItem(transactions[index]);
                },
              );

            case ConnectionState.none:
              break;

            case ConnectionState.waiting:
              return Progress();
          }
          return CenteredMessage(
            message: 'Unknown Error',
            icon: Icons.error,
            fontSize: 24.0,
          );
        },
      ),
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    return Card(
      child: ListTile(
        title: Text('${transaction.value}'),
        subtitle: Text(transaction.contact.name),
        leading: Icon(Icons.monetization_on),
      ),
    );
  }
}
