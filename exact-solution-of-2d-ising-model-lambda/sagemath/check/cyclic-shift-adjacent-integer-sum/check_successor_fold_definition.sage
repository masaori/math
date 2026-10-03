# 対象ラベル: claim_cyclic_shift_adjacent_integer_sum
load('sagemath/check/cyclic-shift-adjacent-integer-sum/_prelude.sage')
for m, k, j in index_cases:
    assert rem(m, rem(m, j + k) + 1) == rho(m, 1, rho(m, k, j))
print('PASS: check_successor_fold_definition: %d indices and shifts' % len(index_cases))
