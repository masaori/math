# 対象ラベル: claim_cyclic_shift_adjacent_integer_sum
load('sagemath/check/cyclic-shift-adjacent-integer-sum/_prelude.sage')
for m, k, j in index_cases:
    assert rho(m, k, rho(m, 1, j)) == rem(m, rem(m, j + 1) + k)
print('PASS: check_successor_definition: %d indices and shifts' % len(index_cases))
