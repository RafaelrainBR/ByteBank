import 'package:bytebank/dao/contact_dao.dart';
import 'package:bytebank/models/contact_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactEditScreen extends StatefulWidget {
  final _contactDao = ContactDao();
  final Contact contact;

  ContactEditScreen(this.contact, {Key key}) : super(key: key);

  @override
  _ContactEditScreenState createState() =>
      _ContactEditScreenState(this.contact);
}

class _ContactEditScreenState extends State<ContactEditScreen> {
  final Contact contact;
  String newName;
  int newAccount;

  _ContactEditScreenState(this.contact) {
    newName = contact.name;
    newAccount = contact.account;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Contact"),
      ),
      body: _getBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          bool edited = false;
          final contact = widget.contact;
          if (newName != null &&
              newName.isNotEmpty &&
              newName != contact.name) {
            contact.name = newName;
            edited = true;
          }
          if (newAccount != null && newAccount != contact.account) {
            contact.account = newAccount;
            edited = true;
          }
          if (edited) {
            widget._contactDao
                .save(contact)
                .then((value) => Navigator.pop(context));
            return;
          }

          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _getBody() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          _EditingCard(
            title: "Id:",
            initialValue: contact.id,
            editable: false,
          ),
          _EditingCard<String>(
            title: "Name:",
            initialValue: newName,
            onEdit: (value) => setState(() => this.newName = value),
          ),
          _EditingCard<int>(
            title: "Account:",
            initialValue: newAccount,
            onEdit: (value) => setState(() => this.newAccount = value),
          ),
        ],
      ),
    );
  }
}

class _EditingCard<T> extends StatelessWidget {
  final String title;
  final T initialValue;
  final bool editable;
  final Function(T) onEdit;

  const _EditingCard({
    Key key,
    this.title,
    this.initialValue,
    this.editable = true,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text("$initialValue"),
        trailing: !editable
            ? null
            : GestureDetector(
                child: Icon(Icons.edit),
                onTap: () async {
                  T value = await showDialog(
                    context: context,
                    builder: (ctx) => _EditingDialog<T>(
                      fieldName: title.replaceAll(":", ""),
                      initialValue: initialValue,
                    ),
                  );

                  if (value != null) onEdit(value);
                },
              ),
      ),
    );
  }
}

class _EditingDialog<T> extends StatefulWidget {
  final String fieldName;
  final T initialValue;

  _EditingDialog({Key key, this.fieldName, this.initialValue})
      : super(key: key);

  @override
  __EditingDialogState<T> createState() =>
      __EditingDialogState<T>(initialValue);
}

class __EditingDialogState<T> extends State<_EditingDialog<T>> {
  TextEditingController _textController;

  __EditingDialogState(T initialValue) {
    _textController = new TextEditingController(text: "$initialValue");
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Editing ${widget.fieldName}"),
      content: TextField(
        controller: _textController,
        decoration: InputDecoration(
          labelText: widget.fieldName,
        ),
        style: TextStyle(
          fontSize: 16,
        ),
        keyboardType: _onlyNumbers() ? TextInputType.number : null,
      ),
      actions: [
        FlatButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: const Text("Confirm"),
          onPressed: () {
            final value = _textController.text;
            if (T == String) Navigator.pop(context, value);
            if (_onlyNumbers()) {
              final asInt = int.tryParse(value);
              if (asInt != null) {
                Navigator.pop(context, asInt);
              }
            }
          },
        ),
      ],
    );
  }

  bool _onlyNumbers() {
    return T == int;
  }
}
