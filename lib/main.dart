import 'dart:io';

import 'package:expanses/widgets/chart.dart';
import 'package:expanses/widgets/new_transaction.dart';
import 'package:expanses/widgets/transactions_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/transactions.dart';

void main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expanses App',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white)
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )
        ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(id: '1', title: 'papers', amount: 19, date: DateTime.now().subtract(Duration(days:0))),
    Transaction(id: '2', title: 'taxi fare', amount: 6, date: DateTime.now().subtract(Duration(days:6))),
    Transaction(id: '3', title: 'groceries', amount: 25, date: DateTime.now().subtract(Duration(days:5))),
    Transaction(id: '4', title: 'groceries', amount: 23, date: DateTime.now().subtract(Duration(days:4))),
    Transaction(id: '5', title: 'groceries', amount: 67, date: DateTime.now().subtract(Duration(days:3))),
    Transaction(id: '6', title: 'groceries', amount: 22, date: DateTime.now().subtract(Duration(days:2))),
    Transaction(id: '6', title: 'groceries', amount: 20, date: DateTime.now().subtract(Duration(days:1))),
    Transaction(id: '7', title: 'groceries', amount: 29, date: DateTime.now().subtract(Duration(days:0))),
    Transaction(id: '8', title: 'groceries', amount: 26, date: DateTime.now().subtract(Duration(days:6))),
    Transaction(id: '9', title: 'groceries', amount: 44, date: DateTime.now().subtract(Duration(days:5))),
    Transaction(id: '10', title: 'groceries', amount: 56, date: DateTime.now().subtract(Duration(days:4))),
    Transaction(id: '11', title: 'groceries', amount: 77, date: DateTime.now().subtract(Duration(days:3))),
    Transaction(id: '12', title: 'groceries', amount: 57, date: DateTime.now().subtract(Duration(days:2))),
  ];

  bool _showCart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction){
        return transaction.date.isAfter(
          DateTime.now().subtract(
            Duration(days:7),
          ),
        );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date){
    final Transaction newTransaction = Transaction(
      id: DateTime.now().toString(), 
      title: title, 
      amount: amount, 
      date: date,
    );

    setState((){
      this._userTransactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _deleteTransaction(String id){
    setState((){
      this._userTransactions.removeWhere((transaction) => transaction.id==id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(
      context: ctx, 
      builder: (_) => NewTransaction(_addNewTransaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryObj = MediaQuery.of(context);  
    final bool isLandscape = mediaQueryObj.orientation == Orientation.landscape;
    final appBar = Platform.isIOS ? 
        CupertinoNavigationBar(
          middle: Text('Flutter App'),
          trailing: GestureDetector(
            onTap: () => _startAddNewTransaction(context),
            child: Icon(Icons.add),
          ),
        ) : 
        AppBar(
          title: Text('Flutter App'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
          ],
        );
    final body = SafeArea(
          child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  isLandscape ? 
                  _landScapeView(appBar, mediaQueryObj) :
                  _potraitView(appBar, mediaQueryObj) 
                ],
              ),
        )
    );
    return Platform.isIOS ? 
      CupertinoPageScaffold(
        navigationBar: appBar,
        child: body,
      ) : 
      Scaffold(
        appBar: appBar, 
        body: body,
        floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }

  Widget _potraitView(AppBar appBar, var mediaQueryObj){
    return Column(
      children: [
        Container(
          height: (mediaQueryObj.size.height -
                  appBar.preferredSize.height - 
                  mediaQueryObj.padding.top) * 0.25,
          child: Chart(recentTransactions: _recentTransactions)
        ),
        Container(
          height: (mediaQueryObj.size.height - 
                  appBar.preferredSize.height - 
                  mediaQueryObj.padding.top) * 0.6,
          child: TransactionList(transactions: _userTransactions, deleteFun: _deleteTransaction,)
        ),
      ],
    );
  }


  Widget _landScapeView(AppBar appBar, var mediaQueryObj){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Show Bar", style: Theme.of(context).textTheme.title,),
            Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
              value: _showCart,
              onChanged: (val){
                setState((){
                  _showCart = val;
                });
              },
            ),
          ],
        ),
        _showCart ? Container(
          height: (mediaQueryObj.size.height -
                    appBar.preferredSize.height - 
                  mediaQueryObj.padding.top) * 0.6,
          child: Chart(recentTransactions: _recentTransactions)
        )
        : Container(
          height: (mediaQueryObj.size.height -
                    appBar.preferredSize.height - 
                  mediaQueryObj.padding.top) * 0.6,
          child: TransactionList(transactions: _userTransactions, deleteFun: _deleteTransaction,)
        )
      ],
    );
  }
}
