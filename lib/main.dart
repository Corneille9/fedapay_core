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

    bool success = await FedaPayCore.instance.makeTransaction(customer: customer);

    if(success){
      debugPrint("Transaction complete with approved status");//Replace this by your custom code
    }else{
      debugPrint("Transaction complete with declined or canceled status");//Replace this by your custom code
    }
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
