class Contact {
  int id;
  String name;
  int account;

  Contact(this.name, this.account, {this.id});

  @override
  String toString() {
    return "Contact{id: $id, name: $name, account: $account}";
  }

  Contact.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        account = json['accountNumber'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'accountNumber': account,
      };
}
