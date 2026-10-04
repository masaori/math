# 対象ラベル: claim_sqrt_two_exists
if 'sqrt_two_roots' not in globals():
    load('sagemath/check/sqrt-two-exists/_prelude.sage')

values = sqrt_two_coefficient_chain()
assert values[2] == values[3]
print("PASS check_coefficient_power.sage: 1 polynomial")
