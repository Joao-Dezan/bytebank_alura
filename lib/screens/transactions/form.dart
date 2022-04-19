import 'package:bytebank/components/my_elevated_button.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';

class TransactionsForm extends StatefulWidget {
  final Contact receiver;
  const TransactionsForm({
    Key? key,
    required this.receiver,
  }) : super(key: key);

  @override
  _TransactionsFormState createState() => _TransactionsFormState();
}

class _TransactionsFormState extends State<TransactionsForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transfer'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.receiver.name,
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                widget.receiver.accountNumber.toString(),
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(
                height: 32.0,
              ),
              TextFormField(
                controller: _valueController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please, enter some text';
                  }
                  return null;
                },
              ),
              MyElevatedButton(
                onClick: () => _transfer(context),
                text: 'Transfer',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _transfer(BuildContext context) async {
    final double? value = double.tryParse(_valueController.text);

    if (_formKey.currentState!.validate() && value != null) {
      final Transaction newTransaction =
          Transaction(value: value, contact: widget.receiver);
      
      Transaction? response = await _webClient.save(newTransaction);
      if (response != null) {
        return Navigator.pop(context);
      }
    }
  }
}
