import 'package:fedapay_core/customer.dart';
import 'package:fedapay_core/fedapay.dart';
import 'package:fedapay_core/transaction.dart';

class FedaPayCore{
  FedaPay fedaPay = FedaPay();

  FedaPayCore._privateConstructor(){
    // fedaPay.apiBase = "https://api.fedapay.com/v1"; // use this for Live account
    fedaPay.apiBase = "https://sandbox-api.fedapay.com/v1";
    fedaPay.apiKey = "YOUR_SECRET_API_KEY";

  }

  /// Singleton instance
  static final FedaPayCore instance = FedaPayCore._privateConstructor();

  createTransaction({String? description, String? callbackUrl, required int amount, required Customer customer, Currency? currency}){
    currency ??= Currency.defaultCurrency();
    description ??= "Transaction for ${customer.email}";

    Transaction transaction = Transaction(currency: currency, customer: customer, amount: amount, description: description, callbackUrl: callbackUrl);

    return transaction.create(url: _Utils.getResourceUrl(fedaPay: fedaPay, resource: "transactions"), headers: _Utils.getHeader(fedaPay: fedaPay)).then((value) async {
      await generateTransactionToken(value);
      return value;
    });

  }

  generateTransactionToken(Transaction transaction){
    return transaction.generateToken(url: _Utils.getResourceUrl(fedaPay: fedaPay, resource: "transactions/${transaction.id}/token"), headers: _Utils.getHeader(fedaPay: fedaPay));
  }

  createPayout({required Transaction transaction, required TransactionMethod method}){
    transaction.payout(url: _Utils.getResourceUrl(fedaPay: fedaPay, resource: method.name),  headers: _Utils.getHeader(fedaPay: fedaPay));
  }

  Stream<PaidStatus> transactionStatus(Transaction transaction) async*{

    yield* Stream.periodic(const Duration(seconds: 1),(_){
      return transaction.getStatus(url: _Utils.getResourceUrl(fedaPay: fedaPay, resource: "transactions/${transaction.id}"), headers: _Utils.getHeader(fedaPay: fedaPay));
    }).asyncMap((event) async => await event);

  }

}

class _Utils{

  static Map<String, String> getHeader({required FedaPay fedaPay}){
    return {
      "Authorization":"Bearer ${fedaPay.getApikey}",
    };

  }

  static String getResourceUrl({required FedaPay fedaPay, String resource = ""}){
    return "${fedaPay.getApiBase}/$resource";
  }
}