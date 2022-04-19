import 'package:bytebank/screens/contacts/list.dart';
import 'package:bytebank/screens/transactions/list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset('images/bytebank_logo.png'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  FeatureItem(
                    onClick: () => _showContactsList(context),
                    icon: Icons.monetization_on,
                    text: 'Transfer',
                  ),
                  FeatureItem(
                    onClick: () => _showTransactionList(context),
                    icon: Icons.description,
                    text: 'Transaction Feed',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showContactsList(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ContactsList()));
  }

  void _showTransactionList(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TransactionsList()));
  }
}

class FeatureItem extends StatelessWidget {
  final VoidCallback onClick;
  final IconData icon;
  final String text;
  const FeatureItem({
    Key? key,
    required this.onClick,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: onClick,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: 148,
            height: 96,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  icon,
                  size: 32,
                  color: Theme.of(context).primaryTextTheme.bodyText1?.color,
                ),
                Text(
                  text,
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
