from typing import Union
import random

from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class LoanInfo(BaseModel):
    requestedLoanAmount: float = 0.0
    loan_status: bool = False # Whether loan has been repaid or not
    loan_payment_score: float = 0.0  # If loan is repaid faster, this score will be high. If loan is repaid latter, this score will be negative.

class LoanApplicantInfo(BaseModel):
    education : str = 'Default'
    gender : str = 'Default'
    monthlyIncome: float = 0.0
    incomeSource: Union[str, None] = None
    creditScore: Union[float, None] = 0.0
    previousLoans : list[LoanInfo] = [{
        "requestedLoanAmount":0.0,
        "loan_status":False,
        "loan_payment_score":0.0,
    }]

    

@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.post("/api/v1/ml/loan/recommend/amount")
def recommend_loan_amount(loanApplicantInfo :LoanApplicantInfo):
    return {"RecommendedLoanAmount": random.randint(1000,10000)}

@app.post("/api/v1/ml/loan/calculate/repaymentProbablity")
def calculate_repayment_probablity(loanApplicantInfo : LoanApplicantInfo):
    return {"RepaymentProbablity": random.randint(0,1)}

@app.post("/api/v1/ml/loan/calculate/creditScore")
def calculate_credit_score(loanApplicantInfo : LoanApplicantInfo):
    # The creditScore field in LoanApplicantInfo object can remain None.
    return {"CreditScore": random.randint(0,100)}
