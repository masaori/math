# 対象ラベル: claim_binary_ca_reversible_global_finite_order_identity
# 式ペア・判定: 周期軌道長の最小公倍数 L_F で F^L_F=id かつ P_F^L_F=I。
# 帰属: 有限集合、ZZ、NN、有限行列。複素数体、実数体、対数、除算、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

permutation_count = ZZ(0)
cycle_count = ZZ(0)
for size in range(1, 9):
    for table in permutations(range(size)):
        permutation = tuple(table)
        cycles = cycle_partition(permutation)
        order = permutation_order(permutation)
        assert order > 0
        assert all(order % len(cycle) == 0 for cycle in cycles)
        assert table_power(permutation, order) == identity_table(size)
        permutation_matrix = permutation_matrix_from_table(permutation)
        assert permutation_matrix ** order == identity_matrix(ZZ, size)
        cycle_count += len(cycles)
        permutation_count += 1

assert permutation_count == ZZ(46233)
assert cycle_count > 0
print('permutations checked:', permutation_count)
print('cycles checked:', cycle_count)
print('RESULT: PASS')

