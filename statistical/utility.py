def scale_down_to_1_to_100(x, a, b):
    c, d = 1, 100          # The desired range
    
    scaled_x = (x - a) * (d - c) / (b - a) + c
    return scaled_x

'''
# Example usage:
original_number = 50
scaled_number = scale_down_to_1_to_100(original_number)
print("Scaled number:", scaled_number)
'''

'''
score1 = consider_loan_amount(previous_loan_amounts=[5000, 6000, 4000, 23000, 6000, 7000], requested_loan=22000)
score2 = consider_loan_amount_collected_so_far(requested_amount=3000, collected_amount=500)
score3 = consider_number_of_loans_repaid(previous_loan_amounts=[5000, 6000, 4000, 23000, 6000, 7000])

print(f"Loan Amount Score : {score1}, Collected Amount: {score2}, Reapid Loan Count: {score3}")
'''