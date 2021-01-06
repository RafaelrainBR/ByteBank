import 'package:bytebank/screens/contact_list_screen.dart';
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
          Expanded(child: _getIcon()),
          Padding(
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
                        Icons.people,
                        color: Colors.white,
                        size: 24,
                      ),
                      Text(
                        "Contacts",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => ContactsScreen()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIcon() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Image.asset("images/bytebank_logo.png"),
    );
  }
}
