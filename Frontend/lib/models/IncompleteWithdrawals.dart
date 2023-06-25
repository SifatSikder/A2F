// To parse this JSON data, do
//
//     final incompleteWithdrawals = incompleteWithdrawalsFromJson(jsonString);

import 'dart:convert';

IncompleteWithdrawals incompleteWithdrawalsFromJson(String str) => IncompleteWithdrawals.fromJson(json.decode(str));

String incompleteWithdrawalsToJson(IncompleteWithdrawals data) => json.encode(data.toJson());

class IncompleteWithdrawals {
    bool success;
    List<Transaction> transactions;
    String message;

    IncompleteWithdrawals({
        required this.success,
        required this.transactions,
        required this.message,
    });

    factory IncompleteWithdrawals.fromJson(Map<String, dynamic> json) => IncompleteWithdrawals(
        success: json["success"],
        transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
        "message": message,
    };
}

class Transaction {
    dynamic agentId;
    String withdrawalCompleteStatus;
    String id;
    String withdrawerId;
    int cashOutAmount;
    String withdrawPlatformName;
    String withdrawPlatformNumber;
    DateTime withdrawDate;
    int v;

    Transaction({
        this.agentId,
        required this.withdrawalCompleteStatus,
        required this.id,
        required this.withdrawerId,
        required this.cashOutAmount,
        required this.withdrawPlatformName,
        required this.withdrawPlatformNumber,
        required this.withdrawDate,
        required this.v,
    });

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        agentId: json["agentID"],
        withdrawalCompleteStatus: json["withdrawalCompleteStatus"],
        id: json["_id"],
        withdrawerId: json["withdrawerID"],
        cashOutAmount: json["cashOutAmount"],
        withdrawPlatformName: json["withdrawPlatformName"],
        withdrawPlatformNumber: json["withdrawPlatformNumber"],
        withdrawDate: DateTime.parse(json["withdrawDate"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "agentID": agentId,
        "withdrawalCompleteStatus": withdrawalCompleteStatus,
        "_id": id,
        "withdrawerID": withdrawerId,
        "cashOutAmount": cashOutAmount,
        "withdrawPlatformName": withdrawPlatformName,
        "withdrawPlatformNumber": withdrawPlatformNumber,
        "withdrawDate": withdrawDate.toIso8601String(),
        "__v": v,
    };
}
