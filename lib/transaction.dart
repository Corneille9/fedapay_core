import 'package:equatable/equatable.dart';
import 'package:fedapay_core/customer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'fedapay_request.dart';
part 'transaction.g.dart';

enum PaidStatus{pending, approved, declined, canceled, refunded, transferred}
enum TransactionMethod {mtn, moov}

@JsonSerializable()
class Transaction extends Equatable with FedaPayRequest{
  int? id;
  String? token;
  String? url;
  int? transactionId;
  final String? description;
  final String? callbackUrl;
  final int amount;
  late PaidStatus status;
  late String createdAt;
  late String updatedAt;

  final Customer? customer;
  late Currency currency;

  Transaction({this.description, this.callbackUrl, required this.amount, this.customer, required this.currency});

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  Future<Transaction> create({required String url, Map<String, String>? headers}) async {
    var data = await staticPostRequest(url: url, params: toJson(), headers: headers);
    data = data["v1/transaction"];
    id = data["id"];
    status = $enumDecode(_$PaidStatusEnumMap, data['status']);
    return this;
  }

  void generateToken({required String url, Map<String, String>? headers}) async {
    if(id==null)throw Exception("Could not generate token for null transaction");
    var data = await staticPostRequest(url: url, params: {}, headers: headers);
    token = data['token'];
    url = data["url"];
  }

  void payout({required String url, Map<String, String>? headers}) async {
    if(token==null)throw Exception("Transaction token not found");
    await staticPostRequest(url: url, params: {"token":token}, headers: headers);
  }

  Future<PaidStatus> getStatus({required String url, Map<String, String>? headers})async{
    if(id==null)throw Exception("Could not generate token for null transaction");
    var data = await staticGetRequest(url: url, headers: headers);
    return PaidStatus.values.firstWhere((element) => element.name==data["v1/transaction"]["status"], orElse: () => PaidStatus.pending,);
  }

  void retrieve(){

  }

  void delete(){

  }

  void getFees(){
  }

  @override
  List<Object?> get props => [
    description,
    callbackUrl,
    createdAt,
    updatedAt,
    transactionId,
    amount,
    status,
    customer
  ];

}

class Currency{
  final String iso;
  final int code;
  final String devise;
  final String country;

  Currency({required this.iso, required this.code, required this.devise, required this.country});

  Map<String, dynamic> toJson(){
    return {
      "iso":iso,
    };
  }

  factory Currency.fromJson(Map<String, dynamic> json)=>defaultCurrency();

  static Currency defaultCurrency()=>Currency(iso: "XOF",code: 952, devise: "Franc CFA (UEMOA", country: "");
}