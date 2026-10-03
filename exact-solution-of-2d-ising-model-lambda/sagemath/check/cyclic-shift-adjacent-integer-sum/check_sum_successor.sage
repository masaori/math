# 対象ラベル: claim_cyclic_shift_adjacent_integer_sum
load('sagemath/check/cyclic-shift-adjacent-integer-sum/_prelude.sage')
count = 0
for m, k, a in table_cases():
    lhs = sum((a[rho(m, k, j), rho(m, k, rho(m, 1, j))] for j in range(m)), ZZ(0))
    rhs = sum((a[rho(m, k, j), rho(m, 1, rho(m, k, j))] for j in range(m)), ZZ(0))
    assert lhs == rhs
    count += 1
print('PASS: sum_successor: %d tables and shifts' % count)
