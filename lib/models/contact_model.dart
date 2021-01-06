class Contact {
  int id;
  final String name;
  final int account;

  Contact(this.name, this.account, {this.id});

  @override
  String toString() {
    return "Contact{id: $id, name: $name, account: $account}";
  }

  Map<String, dynamic> toJson() {
    final map = Map<String, dynamic>();
    map['name'] = name;
    map['account_number'] = account;

    return map;
  }

  static Contact fromJson(Map<String, dynamic> map) {
    return Contact(
      map['name'],
      map['account_number'],
      id: map['id'],
    );
  }
}