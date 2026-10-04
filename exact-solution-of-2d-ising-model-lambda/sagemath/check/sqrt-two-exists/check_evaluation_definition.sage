# 対象ラベル: claim_sqrt_two_exists
if 'sqrt_two_roots' not in globals():
    load('sagemath/check/sqrt-two-exists/_prelude.sage')

for s in sqrt_two_roots:
    values = sqrt_two_evaluation_chain(s)
    assert values[9] == values[10]
print("PASS check_evaluation_definition.sage: 2 roots")
