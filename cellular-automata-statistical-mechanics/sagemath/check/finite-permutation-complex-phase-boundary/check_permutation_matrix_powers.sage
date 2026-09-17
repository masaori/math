# 対象ラベル: claim_binary_ca_permutation_matrix_powers_encode_iterates
# 式ペア・判定: P_F^n(y,x) は y=F^n(x) の整数値指示行列に一致する。
# 帰属: 有限集合、ZZ、NN、有限行列。複素数体、実数体、対数、除算、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

permutation_count = ZZ(0)
power_count = ZZ(0)
entry_count = ZZ(0)
for size in range(1, 8):
    for table in permutations(range(size)):
        permutation = tuple(table)
        permutation_matrix = permutation_matrix_from_table(permutation)
        for exponent in range(0, 2 * size + 1):
            iterate = table_power(permutation, exponent)
            expected = permutation_matrix_from_table(iterate)
            actual = permutation_matrix ** exponent
            assert actual == expected
            for target in range(size):
                for source in range(size):
                    assert actual[target, source] == (ZZ.one() if target == iterate[source] else ZZ.zero())
                    entry_count += 1
            power_count += 1
        permutation_count += 1

assert permutation_count == ZZ(5913)
assert power_count > 0
assert entry_count > 0
print('permutations checked:', permutation_count)
print('matrix powers checked:', power_count)
print('matrix entries checked:', entry_count)
print('RESULT: PASS')

