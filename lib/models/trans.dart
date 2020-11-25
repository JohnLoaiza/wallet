class Trans {
  final int id;
  final String transDate;
  final String transName;
  final String transType;
  final String nombreCli;
  final String telefonoCli;
  final int amount;

  Trans({ this.id, this.transDate, this.transName, this.transType,this.nombreCli,this.telefonoCli, this.amount });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': transDate,
      'name': transName,
      'type': transType,
      'nombre':nombreCli,
      'telefono':telefonoCli,
      'amount': amount
    };
  }

  @override
  String toString() {
    return 'Trans{id: $id, transName: $transName, amount: $amount}';
  }

}