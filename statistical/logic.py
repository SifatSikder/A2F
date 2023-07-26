import statistics
from utility import *
import math

# All measures return a score between 1 to 100.

def __equation_loan_amount(L,M):
    loan_differance = (L-M)*10/L 
    return math.exp(loan_differance) # e^x

def consider_loan_amount(previous_loan_amounts : list[float], requested_loan): # Typical Output Range: 50~100, most are between 92~100
    MAXIMUM_LINE = 0.05 # above median line
    loan_median = statistics.median(map(float, previous_loan_amounts))

    if requested_loan <=loan_median: return 100
    elif requested_loan >= 2*max(previous_loan_amounts): return 0
    elif requested_loan >= max(previous_loan_amounts) - loan_median*(MAXIMUM_LINE): return 10
    
    equation_score = __equation_loan_amount(requested_loan, loan_median)
    return 100-scale_down_to_1_to_100(equation_score, math.exp(1), math.exp(10)) 
    

def consider_number_of_loans_repaid(previous_loan_amounts : list[float]): 
    if len(previous_loan_amounts) > 10 : return 100
    return scale_down_to_1_to_100(math.exp(len(previous_loan_amounts)), math.exp(1), math.exp(10)) 


def consider_loan_amount_collected_so_far(requested_amount: float, collected_amount: float): # Increases fast with each donation
    funding_differene = math.fabs(requested_amount - collected_amount)

    if funding_differene == requested_amount : return 0 

    x = funding_differene * 10 / requested_amount
    equation_score = math.exp(x)

    return 100-scale_down_to_1_to_100(equation_score, math.exp(1), math.exp(10)) 

def consider_dues_previously(total_loan_number: int, total_due_count : int):
    if total_due_count == 0 : return 100
    elif total_loan_number*0.1 >= total_due_count: return 90
    elif total_loan_number*0.2 >= total_due_count: return 70
    elif total_loan_number*0.3 >= total_due_count: return 50
    elif total_loan_number*0.5 >= total_due_count  : return 0
def consider_current_balance(current_balance: float, requested_loan: float):
    if current_balance > 2*requested_loan: return 100
    elif current_balance >= requested_loan: return 90
    return 50

def consider_num_of_lenders(number_of_lenders : int):
    MAX_AMOUNT = 10
    if number_of_lenders > MAX_AMOUNT: return 100
    elif number_of_lenders>3: return 90
    elif number_of_lenders==0: return 0
    return 50


def get_weighted_score(previous_loan_amounts : list[float], requested_loan: float, collected_amount: float, total_due_count:int, current_balance: float, number_of_lenders : int):
    score =  0.3*consider_loan_amount(previous_loan_amounts, requested_loan) + 0.3*consider_number_of_loans_repaid(previous_loan_amounts) + 0.2*consider_loan_amount_collected_so_far(requested_loan, collected_amount) + 0.15*consider_dues_previously(len(previous_loan_amounts), total_due_count) + 0.2*consider_current_balance(current_balance, requested_loan) + 0.05*consider_num_of_lenders(number_of_lenders)
    return score 


# Testing
#print(get_weighted_score([3000,5000,7000,2000,4000,6000,10000,6700, 4000], 1000, 300, 2, 13000, 3))



