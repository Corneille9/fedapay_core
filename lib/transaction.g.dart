// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      description: json['description'] as String?,
      callbackUrl: json['callback_url'] as String?,
      amount: json['amount'] as int,
      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>),
    )
      ..id = json['id'] as int?
      ..status = $enumDecode(_$PaidStatusEnumMap, json['status'])
      ..transactionId = json['transaction_id'] as int
      ..createdAt = json['created_at'] as String
      ..updatedAt = json['updated_at'] as String;

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'callback_url': instance.callbackUrl,
      'amount': instance.amount,
      'customer': instance.customer?.toJson(),
      'currency': instance.currency.toJson(),
    };

const _$PaidStatusEnumMap = {
  PaidStatus.pending: 'pending',
  PaidStatus.approved: 'approved',
  PaidStatus.declined: 'declined',
  PaidStatus.canceled: 'canceled',
  PaidStatus.refunded: 'refunded',
  PaidStatus.transferred: 'transferred',
};
