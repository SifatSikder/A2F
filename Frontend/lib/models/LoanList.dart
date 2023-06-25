// To parse this JSON data, do
//
//     final loanList = loanListFromJson(jsonString);

import 'dart:convert';

LoanList loanListFromJson(String str) => LoanList.fromJson(json.decode(str));

String loanListToJson(LoanList data) => json.encode(data.toJson());

class LoanList {
  bool success;
  List<Loan> loans;

  LoanList({
    required this.success,
    required this.loans,
  });

  factory LoanList.fromJson(Map<String, dynamic> json) => LoanList(
        success: json["success"],
        loans: List<Loan>.from(json["loans"].map((x) => Loan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "loans": List<dynamic>.from(loans.map((x) => x.toJson())),
      };
}

class Loan {
  String loanStatus;
  int loanEmi;
  int satisfiedAmount;
  String loanProvidedBy;
  String id;
  String recepientId;
  int repaymentMonths;
  int loanAmount;
  int v;

  Loan({
    required this.loanStatus,
    required this.loanEmi,
    required this.satisfiedAmount,
    required this.loanProvidedBy,
    required this.id,
    required this.recepientId,
    required this.repaymentMonths,
    required this.loanAmount,
    required this.v,
  });

  factory Loan.fromJson(Map<String, dynamic> json) => Loan(
        loanStatus: json["LoanStatus"],
        loanEmi: json["LoanEMI"],
        satisfiedAmount: json["SatisfiedAmount"],
        loanProvidedBy: json["LoanProvidedBy"],
        id: json["_id"],
        recepientId: json["RecepientID"],
        repaymentMonths: json["RepaymentMonths"],
        loanAmount: json["LoanAmount"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "LoanStatus": loanStatus,
        "LoanEMI": loanEmi,
        "SatisfiedAmount": satisfiedAmount,
        "LoanProvidedBy": loanProvidedBy,
        "_id": id,
        "RecepientID": recepientId,
        "RepaymentMonths": repaymentMonths,
        "LoanAmount": loanAmount,
        "__v": v,
      };
}
