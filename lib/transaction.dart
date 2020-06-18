class Transaction{
  String id;
  String title;
  double amount;
  DateTime date;

  Transaction(String id,String title,double amount,DateTime date){
    this.id = id;
    this.title=title;
    this.amount=amount;
    this.date = date;
  }

  Map toJson()=>{
    'id' : id,
    'title' : title,
    'amount' : amount,
    'date' : date.toString()
  };

  factory Transaction.fromJson(dynamic json) {
    return Transaction(json['id'] as String, json['title'] as String,json['amount'] as double ,DateTime.parse(json['date']) as DateTime);
  }

}