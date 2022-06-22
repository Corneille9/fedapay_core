import 'dart:async';
import 'package:flutter/material.dart';
import 'fedapay_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FedaPay',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'FedaPay Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<void> paymentTest() async {
    //Create a new customer
    Customer customer = Customer(firstname: "Corneille", lastname: "Bkle", email: "bankolecorneille@gmail.com", phoneNumber: PhoneNumber(number: "+22999100542"));

    //Create a new transaction with previous customer
    Transaction transaction = await FedaPayCore.instance.createTransaction(amount: 5000, customer: customer);

    //Trigger the payment to allow the customer to pay
    await FedaPayCore.instance.createPayout(transaction: transaction, method: TransactionMethod.mtn);

    //Create stream subscription to listen transaction states
    late StreamSubscription<PaidStatus> subscription;
    subscription = FedaPayCore.instance.transactionStatus(transaction).listen((event) {
      if(event==PaidStatus.approved){
        subscription.cancel();
        //Do somethings when the customer make payment
      }
      else if(event==PaidStatus.canceled || event==PaidStatus.declined){
        subscription.cancel();
        //Do somethings when the customer rejects payment or .....
      }
      //Do something when transaction status is pending
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: (){
              paymentTest();
            }, child: const Text("Test"))
          ],
        ),
      ),
    );
  }
}
