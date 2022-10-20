import "dart:io";

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:learn_flutter/widgets/transaction_list.dart';

import '../models/transaction.dart';
import 'chart.dart';
import 'new_transaction.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      DateTime oneWeekBefore = DateTime.now().subtract(const Duration(days: 7));
      return tx.date.isAfter(oneWeekBefore);
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTransaction = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(addTx: _addNewTransaction),
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isPlatformIos = Platform.isIOS;
    final Orientation deviceOrientation = MediaQuery.of(context).orientation;
    final bool isLandscape = deviceOrientation == Orientation.landscape;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final PreferredSizeWidget appBar = isPlatformIos
        ? CupertinoNavigationBar(
            middle: const Text("Expense App"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          ) as PreferredSizeWidget
        : AppBar(
            title: const Text(
              'Personal Expenses',
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );

    final double appBarHeight = appBar.preferredSize.height;

    final Widget txListContainer = Container(
      height: (MediaQuery.of(context).size.height -
              appBarHeight -
              statusBarHeight) *
          0.7,
      child: TransactionList(
          transactions: _userTransactions, deleteTx: _deleteTransaction),
    );
    final Widget chartContainer = Container(
        height: (MediaQuery.of(context).size.height -
                appBarHeight -
                statusBarHeight) *
            (isLandscape ? 0.7 : 0.3),
        child: Chart(_recentTransactions));

    final Widget body = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Show chart"),
                Switch(
                    value: _showChart,
                    onChanged: ((value) {
                      setState(() {
                        _showChart = value;
                      });
                    }))
              ]),
            if (isLandscape) (_showChart) ? chartContainer : txListContainer,
            if (!isLandscape) chartContainer,
            if (!isLandscape) txListContainer,
          ],
        ),
      ),
    );

    return isPlatformIos
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: body,
          )
        : Scaffold(
            appBar: appBar,
            body: body,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: isPlatformIos
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
