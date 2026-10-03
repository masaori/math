# 対象ラベル: claim_cyclic_shift_adjacent_integer_sum
load('sagemath/check/cyclic-shift-adjacent-integer-sum/_prelude.sage')
for m, k, j in index_cases:
    assert rem(m, j + (k + 1)) == rem(m, (j + k) + 1)
print('PASS: check_successor_unassociate: %d indices and shifts' % len(index_cases))
