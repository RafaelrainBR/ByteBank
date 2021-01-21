import 'package:bytebank/dao/contact_dao.dart';
import 'package:bytebank/models/contact_model.dart';
import 'package:bytebank/screens/contact_list/creation/contact_form.dart';
import 'package:bytebank/screens/contact_list/option/contact_edit.dart';
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
        title: Text("Transfer"),
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
                    deleteAction: () => showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("Confirmation"),
                        content: Text("Are you sure to delete the contact?"),
                        actions: [
                          FlatButton(
                            child: const Text("Cancel"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          FlatButton(
                            child: const Text("Confirm"),
                            onPressed: () => setState(() {
                              _contactDao.delete(contact);
                              sendSnackMessage(context,
                                  "You have sucessfully deleted the contact ${contact.name}");
                              Navigator.pop(context);
                            }),
                          ),
                        ],
                      ),
                    ),
                    editAction: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => ContactEditScreen(contact)),
                    ).then((value) => setState(() {})),
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
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final Contact contact;
  final Function deleteAction;
  final Function editAction;

  const _ContactCard(
      {Key key, this.contact, this.deleteAction, this.editAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(contact.name, style: TextStyle(fontSize: 24)),
        subtitle: Text("${contact.account}", style: TextStyle(fontSize: 16)),
        trailing: _PopUpMenu(
          deleteAction: deleteAction,
          editAction: editAction,
        ),
      ),
    );
  }
}

class _PopUpMenu extends StatelessWidget {
  final Function deleteAction;
  final Function editAction;

  _PopUpMenu({this.deleteAction, this.editAction});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: doSelect,
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        const PopupMenuItem(
          value: "Edit",
          child: ListTile(
            title: Text("Edit"),
            leading: Icon(Icons.edit),
          ),
        ),
        const PopupMenuItem(
          value: "Delete",
          child: ListTile(
            title: Text("Delete"),
            leading: Icon(Icons.delete),
          ),
        ),
      ],
    );
  }

  void doSelect(String value) {
    switch (value) {
      case "Delete":
        deleteAction();
        break;
      case "Edit":
        editAction();
        break;
    }
  }
}