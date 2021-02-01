import 'package:bytebank/models/contact_model.dart';

import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _nameController = TextEditingController();
  final _accountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New contact"),
      ),
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _newTextInput("Full name", controller: _nameController),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: _newTextInput(
              "Account number",
              controller: _accountController,
              isNumber: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: SizedBox(
              width: double.maxFinite,
              child: RaisedButton(
                child: Text("Create"),
                onPressed: () {
                  final name = _nameController.text;
                  final account = int.tryParse(_accountController.text);

                  if (name != null && account != null) {
                    final contact = Contact(name, account);
                    Navigator.pop(context, contact);
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _newTextInput(String label, {controller, isNumber = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      style: TextStyle(
        fontSize: 24,
      ),
      keyboardType: isNumber ? TextInputType.number : null,
    );
  }
}
