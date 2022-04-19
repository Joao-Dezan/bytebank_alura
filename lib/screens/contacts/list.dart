import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts/form.dart';
import 'package:bytebank/screens/transactions/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactsList extends StatefulWidget {
  ContactsList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: [],
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Contact>? contacts = snapshot.data;

                return ListView.builder(
                  padding: EdgeInsets.all(16.0),
                  itemCount: contacts?.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: _ContactItem(
                        contact: contacts![index],
                        onDelete: () {
                          final int? contactId = contacts[index].id;
                          if (contactId != null) {
                            setState(() {
                              _dao.delete(contactId);
                            });
                          }
                        },
                    ),
                  ),
                );
              }
              break;
          }

          return Center(child: Text('Unknown error'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactsForm(),
              ));

          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {

  final Contact contact;
  final Function? onDelete;

  const _ContactItem({
    required this.contact,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TransactionsForm(receiver: contact)));
        },
        title: Text(contact.name),
        subtitle: Text(contact.accountNumber.toString()),
        trailing: IconButton(
          onPressed: () => onDelete!(),
          icon: Icon(
            Icons.delete,
            color: Colors.red[400],
          ),
        ),
      ),
    );
  }
}
