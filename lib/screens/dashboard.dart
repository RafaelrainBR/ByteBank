import 'package:bytebank/screens/contact_list/contact_list_screen.dart';
import 'package:bytebank/screens/transaction_list/transactions_list.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: Image.asset("images/bytebank_logo.png"),
          ),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _FeatureItem(
                  "Transfer",
                  Icons.people,
                  onClick: () => _showContactsList(context),
                ),
                _FeatureItem(
                  "Transaction Feed",
                  Icons.description,
                  onClick: () => _showTransactionList(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showContactsList(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => ContactsScreen()),
    );
  }

  void _showTransactionList(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => TransactionsList()),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem(this.name, this.icon, {@required this.onClick})
      : assert(icon != null),
        assert(onClick != null);

  final IconData icon;
  final String name;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          child: Container(
            padding: EdgeInsets.all(8),
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          onTap: onClick,
        ),
      ),
    );
  }
}
