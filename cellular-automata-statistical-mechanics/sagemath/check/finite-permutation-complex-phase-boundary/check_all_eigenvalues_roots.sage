# 対象ラベル: claim_binary_ca_permutation_complex_eigenvalue_root_of_unity
# 式ペア・判定: 特性多項式は周期軌道ごとの (t^d-1) の積で、各 d は L_F を割る。
# 帰属: 有限集合、ZZ、NN、ZZ 上の一変数多項式。複素根の数値近似、複素対数、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

polynomial_ring = PolynomialRing(ZZ, 't')
t = polynomial_ring.gen()
permutation_count = ZZ(0)
factor_count = ZZ(0)
for size in range(1, 9):
    for table in permutations(range(size)):
        permutation = tuple(table)
        cycles = cycle_partition(permutation)
        order = permutation_order(permutation)
        permutation_matrix = permutation_matrix_from_table(permutation)
        expected_characteristic_polynomial = polynomial_ring.one()
        for cycle in cycles:
            cycle_length = ZZ(len(cycle))
            assert order % cycle_length == 0
            assert (t ** order - 1) % (t ** cycle_length - 1) == 0
            expected_characteristic_polynomial *= t ** cycle_length - 1
            factor_count += 1
        assert permutation_matrix.charpoly(t) == expected_characteristic_polynomial
        assert permutation_matrix ** order == identity_matrix(ZZ, size)
        permutation_count += 1

assert permutation_count == ZZ(46233)
assert factor_count > 0
print('permutations checked:', permutation_count)
print('cycle polynomial factors checked:', factor_count)
print('RESULT: PASS')

