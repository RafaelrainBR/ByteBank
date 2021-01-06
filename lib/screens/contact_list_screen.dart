import 'package:bytebank/dao/contact_dao.dart';
import 'package:bytebank/models/contact_model.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final _contactDao = ContactDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: FutureBuilder(
        future: _contactDao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data;
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (ctx, i) {
                  final contact = contacts[i];

                  return _ContactCard(
                    contact: contact,
                    onDelete: () => setState(() {
                      _contactDao.delete(contact);
                    }),
                  );
                },
              );
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading'),
                  ],
                ),
              );
            default:
              break;
          }

          return Text('Unkown error');
        },
      ),
      floatingActionButton: _actionButton(context),
    );
  }

  Widget _actionButton(context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => ContactForm()))
              .then((value) {
            if (value != null) {
              setState(() {
                _contactDao.save(value).then((_) =>
                    sendSnackMessage(context, "You have added a new contact!"));
              });
            }
          });
        });
  }

  void sendSnackMessage(context, text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final Contact contact;
  final Function onDelete;

  const _ContactCard({Key key, this.contact, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(contact.name, style: TextStyle(fontSize: 24)),
        subtitle: Text("${contact.account}", style: TextStyle(fontSize: 16)),
        trailing: _PopUpMenu(
          onDelete: onDelete,
        ),
      ),
    );
  }
}

class _PopUpMenu extends StatelessWidget {
  final Function onDelete;

  _PopUpMenu({this.onDelete});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) => onDelete,
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        const PopupMenuItem(
          child: ListTile(
            title: Text("Delete"),
            leading: Icon(Icons.delete),
          ),
        ),
      ],
    );
  }
}
