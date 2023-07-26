from typing import Union
import random
from logic import get_weighted_score
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class LoanInfo(BaseModel):
    previous_loan_amounts : list[float]
    requested_loan: float
    collected_amount: float
    total_due_count:int
    current_balance: float
    number_of_lenders : int


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.post("/api/v1/loan/reliability")
def recommend_loan_amount(loanInfo :LoanInfo):
    score = get_weighted_score( loanInfo.previous_loan_amounts, loanInfo.requested_loan, loanInfo.collected_amount, loanInfo.total_due_count, loanInfo.current_balance, loanInfo.number_of_lenders)
    return {"ReliabilityScore": score, "ChatGPT": "default message", "MLScore": 0.76}
