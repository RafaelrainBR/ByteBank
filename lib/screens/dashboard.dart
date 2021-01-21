import 'package:bytebank/screens/contact_list/contact_list_screen.dart';
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
          Row(
            children: [
              _FeatureItem(
                name: "Transfer",
                icon: Icons.people,
                onClick: () => _showContactsList(context),
              ),
              _FeatureItem(
                name: "Transaction Feed",
                icon: Icons.description,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showContactsList(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => ContactsScreen()),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({Key key, this.name, this.icon, this.onClick})
      : super(key: key);

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
            height: 100,
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
