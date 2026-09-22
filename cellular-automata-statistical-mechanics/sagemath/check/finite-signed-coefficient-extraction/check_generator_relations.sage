# 対象ラベル: claim_finite_exterior_generators_square_zero_anticommute
# 式ペア: e_{\{i\}} wedge e_{\{i\}} = 0_I、e_{\{i\}} wedge e_{\{j\}} = -e_{\{j\}} wedge e_{\{i\}}。
# 帰属: 有限集合、有限冪集合、ZZ。対数、除算、実数体、複素数体、浮動小数点は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

index_set = tuple(ZZ(value) for value in range(5))
zero = zero_table(index_set)
square_checks = ZZ(0)
anticommutation_checks = ZZ(0)

for left in index_set:
    generator_left = basis_table(index_set, (left,))
    assert anticommuting_product(index_set, generator_left, generator_left) == zero
    square_checks += 1
    for right in index_set:
        if left == right:
            continue
        generator_right = basis_table(index_set, (right,))
        left_then_right = anticommuting_product(index_set, generator_left, generator_right)
        right_then_left = anticommuting_product(index_set, generator_right, generator_left)
        assert left_then_right == scale_table(-1, right_then_left)
        anticommutation_checks += 1

assert square_checks == len(index_set)
assert anticommutation_checks == len(index_set) * (len(index_set) - 1)
print('square-zero generators checked:', square_checks)
print('ordered distinct generator pairs checked:', anticommutation_checks)
print('RESULT: PASS')
