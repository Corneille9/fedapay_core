# Fedapay Flutter

The Fedapay Node library provides convenient access to the Fedapay API from
applications written in server-side JavaScript.

## Documentation

See the [Fedapi docs](https://docs.fedapay.com/paiements/transactions).

## Installation

Install requirement packages with:

```bash
flutter pub add json_annotation 
flutter pub add equatable 
flutter pub add dio 
```

## Usage

```dart
    import 'dart:async';
    import 'fedapay_service.dart';
    
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
```
