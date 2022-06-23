# Fedapay Flutter

The Fedapay Node library provides convenient access to the Fedapay API from applications written in server-side
JavaScript.

## Documentation

See the [Fedapi docs](https://docs.fedapay.com/paiements/transactions).

## Installation

Install requirement packages with:

```bash
flutter pub add json_annotation 
flutter pub add equatable 
flutter pub add dio 
flutter pub add url_launcher 
```

## Usage

```dart
   import 'fedapay_service.dart';
    
   //Create a new customer
   Customer customer = Customer(firstname: "firstname", lastname: "lastname", email: "example@gmail.com", phoneNumber: PhoneNumber(number: "+229 .. .. .."));

   bool success = await FedaPayCore.instance.makeTransaction(customer: customer);

   if(success){
     debugPrint("Transaction complete with approved status");//Replace this by your custom code
   }else{
     debugPrint("Transaction complete with declined or canceled status");//Replace this by your custom code
   }
```
