import 'package:bytebank/components/my_elevated_button.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactsForm extends StatefulWidget {
  const ContactsForm({Key? key}) : super(key: key);

  @override
  _ContactsFormState createState() => _ContactsFormState();
}

class _ContactsFormState extends State<ContactsForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _contactAccountNumberController =
      TextEditingController();
  final _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New contact'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _contactNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: 'Full name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Plese, enter some text';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: TextFormField(
                  controller: _contactAccountNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(labelText: 'Account number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Plese, enter some text';
                    }
                    return null;
                  },
                ),
              ),
              MyElevatedButton(
                onClick: () => _createContact(context),
                text: 'Create',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createContact(BuildContext context) async {
    final String name = _contactNameController.text;
    final int? accountNumber =
        int.tryParse(_contactAccountNumberController.text);

    if (_formKey.currentState!.validate() && accountNumber != null) {
      final Contact newContact = Contact(
        id: 0,
        name: name,
        accountNumber: accountNumber,
      );

      await _dao.save(newContact);

      Navigator.pop(context);
    }
  }
}
