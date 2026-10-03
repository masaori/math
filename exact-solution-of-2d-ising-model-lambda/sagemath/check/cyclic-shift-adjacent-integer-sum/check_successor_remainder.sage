# 対象ラベル: claim_cyclic_shift_adjacent_integer_sum
load('sagemath/check/cyclic-shift-adjacent-integer-sum/_prelude.sage')
for m, k, j in index_cases:
    assert rem(m, rem(m, j + 1) + k) == rem(m, j + 1 + k)
print('PASS: check_successor_remainder: %d indices and shifts' % len(index_cases))
