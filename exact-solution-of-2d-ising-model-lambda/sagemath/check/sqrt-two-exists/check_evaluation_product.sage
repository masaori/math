# 対象ラベル: claim_sqrt_two_exists
if 'sqrt_two_roots' not in globals():
    load('sagemath/check/sqrt-two-exists/_prelude.sage')

for s in sqrt_two_roots:
    values = sqrt_two_evaluation_chain(s)
    assert values[1] == values[2]
print("PASS check_evaluation_product.sage: 2 roots")
