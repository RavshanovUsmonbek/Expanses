import 'package:expanses/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteFun;

  TransactionList({
    @required this.transactions,
    @required this.deleteFun,
  });
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrains){
      return  transactions.isEmpty? 
            Column(
              children: <Widget>[
                SizedBox(
                  height: constrains.maxHeight * 0.05,
                ),
                Container(
                  height: constrains.maxHeight * 0.05,
                  child: FittedBox(
                      child: Text(
                      'No transactions added yet!',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
                SizedBox(
                  height: constrains.maxHeight * 0.15,
                ),
                Container(
                    height: constrains.maxHeight * 0.55,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )
                ),
              ],
            )
            : ListView.builder(
                itemBuilder: (ctx, index){
                  return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(child: Text('\$${transactions[index].amount}')),
                        ),
                      ),
                      title: Text('${transactions[index].title}', style: Theme.of(ctx).textTheme.title,),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                      ),
                      trailing: MediaQuery.of(context).size.width > 350 ?
                        FlatButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                          onPressed: () => deleteFun(transactions[index].id)
                        ): 
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteFun(transactions[index].id),
                        ),
                    ),
                  );
                },
            itemCount: transactions.length,
      );
    }); 
  }
}