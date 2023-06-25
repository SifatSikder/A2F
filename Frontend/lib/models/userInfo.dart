// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
    bool success;
    User user;
    List<Loan> loan;
    List<ContributedLoan> contributedLoans;
    List<RepaymentDetail> repaymentDetails;

    UserInfo({
        required this.success,
        required this.user,
        required this.loan,
        required this.contributedLoans,
        required this.repaymentDetails,
    });

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        success: json["success"],
        user: User.fromJson(json["user"]),
        loan: List<Loan>.from(json["loan"].map((x) => Loan.fromJson(x))),
        contributedLoans: List<ContributedLoan>.from(json["contributedLoans"].map((x) => ContributedLoan.fromJson(x))),
        repaymentDetails: List<RepaymentDetail>.from(json["repaymentDetails"].map((x) => RepaymentDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "user": user.toJson(),
        "loan": List<dynamic>.from(loan.map((x) => x.toJson())),
        "contributedLoans": List<dynamic>.from(contributedLoans.map((x) => x.toJson())),
        "repaymentDetails": List<dynamic>.from(repaymentDetails.map((x) => x.toJson())),
    };
}

class ContributedLoan {
    int amountReceivedTillNow;
    String id;
    String userId;
    int amountContributed;
    int contributionPercentage;
    int amountToBeReceived;
    String loanId;
    int v;

    ContributedLoan({
        required this.amountReceivedTillNow,
        required this.id,
        required this.userId,
        required this.amountContributed,
        required this.contributionPercentage,
        required this.amountToBeReceived,
        required this.loanId,
        required this.v,
    });

    factory ContributedLoan.fromJson(Map<String, dynamic> json) => ContributedLoan(
        amountReceivedTillNow: json["AmountReceivedTillNow"],
        id: json["_id"],
        userId: json["UserID"],
        amountContributed: json["AmountContributed"],
        contributionPercentage: json["contributionPercentage"],
        amountToBeReceived: json["AmountToBeReceived"],
        loanId: json["LoanID"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "AmountReceivedTillNow": amountReceivedTillNow,
        "_id": id,
        "UserID": userId,
        "AmountContributed": amountContributed,
        "contributionPercentage": contributionPercentage,
        "AmountToBeReceived": amountToBeReceived,
        "LoanID": loanId,
        "__v": v,
    };
}

class Loan {
    String loanStatus;
    double loanEmi;
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
        loanEmi: json["LoanEMI"]?.toDouble(),
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

class RepaymentDetail {
    List<String> transactions;
    int paidTillNow;
    String id;
    int repaymentDaysRemaining;
    int remainingInstallments;
    int amountToBePaid;
    int v;

    RepaymentDetail({
        required this.transactions,
        required this.paidTillNow,
        required this.id,
        required this.repaymentDaysRemaining,
        required this.remainingInstallments,
        required this.amountToBePaid,
        required this.v,
    });

    factory RepaymentDetail.fromJson(Map<String, dynamic> json) => RepaymentDetail(
        transactions: List<String>.from(json["Transactions"].map((x) => x)),
        paidTillNow: json["PaidTillNow"],
        id: json["_id"],
        repaymentDaysRemaining: json["RepaymentDaysRemaining"],
        remainingInstallments: json["RemainingInstallments"],
        amountToBePaid: json["AmountToBePaid"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "Transactions": List<dynamic>.from(transactions.map((x) => x)),
        "PaidTillNow": paidTillNow,
        "_id": id,
        "RepaymentDaysRemaining": repaymentDaysRemaining,
        "RemainingInstallments": remainingInstallments,
        "AmountToBePaid": amountToBePaid,
        "__v": v,
    };
}

class User {
    String usertype;
    String universityRegistrationId;
    int loanFee;
    int loanwallet;
    int wallet;
    int withdrawAmount;
    int cashOutTillNow;
    String currentBsseYear;
    String id;
    String password;
    String email;
    String username;
    String phoneNumber;
    String bKashNumber;
    int v;

    User({
        required this.usertype,
        required this.universityRegistrationId,
        required this.loanFee,
        required this.loanwallet,
        required this.wallet,
        required this.withdrawAmount,
        required this.cashOutTillNow,
        required this.currentBsseYear,
        required this.id,
        required this.password,
        required this.email,
        required this.username,
        required this.phoneNumber,
        required this.bKashNumber,
        required this.v,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        usertype: json["usertype"],
        universityRegistrationId: json["UniversityRegistrationID"],
        loanFee: json["LoanFee"],
        loanwallet: json["Loanwallet"],
        wallet: json["Wallet"],
        withdrawAmount: json["withdrawAmount"],
        cashOutTillNow: json["cashOutTillNow"],
        currentBsseYear: json["currentBsseYear"],
        id: json["_id"],
        password: json["password"],
        email: json["email"],
        username: json["username"],
        phoneNumber: json["PhoneNumber"],
        bKashNumber: json["bKashNumber"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "usertype": usertype,
        "UniversityRegistrationID": universityRegistrationId,
        "LoanFee": loanFee,
        "Loanwallet": loanwallet,
        "Wallet": wallet,
        "withdrawAmount": withdrawAmount,
        "cashOutTillNow": cashOutTillNow,
        "currentBsseYear": currentBsseYear,
        "_id": id,
        "password": password,
        "email": email,
        "username": username,
        "PhoneNumber": phoneNumber,
        "bKashNumber": bKashNumber,
        "__v": v,
    };
}
