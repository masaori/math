# 対象ラベル: claim_binary_ca_phase_code_realizes_complex_eigenpair
# 式ペア・判定: 各周期軌道と剰余位置の位相符号が、厳密な円分体上で固有対を与える。
# 帰属: 有限集合、ZZ、NN、円分体の代数的数、有限ベクトル。浮動小数点、複素対数、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

permutation_count = ZZ(0)
phase_code_count = ZZ(0)
coordinate_count = ZZ(0)
for size in range(1, 8):
    for table in permutations(range(size)):
        permutation = tuple(table)
        cycles = cycle_partition(permutation)
        for cycle in cycles:
            cycle_length = len(cycle)
            for code in range(cycle_length):
                field, phase = exact_phase(cycle_length, code)
                permutation_matrix = permutation_matrix_from_table(permutation, field)
                values = [field.zero() for _ in range(size)]
                for position, point in enumerate(cycle):
                    values[point] = phase ** (-position)
                phase_vector = vector(field, values)
                assert phase_vector != vector(field, [field.zero() for _ in range(size)])
                assert phase ** cycle_length == field.one()
                assert permutation_matrix * phase_vector == phase * phase_vector
                phase_code_count += 1
                coordinate_count += size
        permutation_count += 1

assert permutation_count == ZZ(5913)
assert phase_code_count > 0
assert coordinate_count > 0
print('permutations checked:', permutation_count)
print('phase-code eigenpairs checked:', phase_code_count)
print('vector coordinates checked:', coordinate_count)
print('RESULT: PASS')
