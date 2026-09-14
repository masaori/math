# 対象ラベル: theorem_deterministic_transfer_trace_equals_fixed_point_count
# 跡の有限和を対角成分の指示値和、反復不動点集合の元数へ段別に照合し、零では対数入力を作らない境界も検査する。
# 帰属: 二元有限集合、QQ、ZZ、NN_{>0}、正値時だけ素数上の有限台整数ベクトル。浮動小数点、未定義の対数、極限、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

family_count = ZZ(0)
trace_count = ZZ(0)
positive_count = ZZ(0)
zero_count = ZZ(0)

for cell_count in range(3):
    states = configurations(cell_count)
    for family in deterministic_families(cell_count):
        matrix = transfer_matrix_from_kernel(
            transition_matrix(deterministic_weight_family(family), cell_count)
        )
        for exponent in range(1, 9):
            power = transfer_power(matrix, exponent)
            diagonal_indicator_sum = sum((power[state][state] for state in states), QQ(0))
            fixed_states = tuple(
                state for state in states
                if iterate_configuration(family, state, exponent) == state
            )
            fixed_count = fixed_point_count(family, exponent)
            trace = transfer_trace(matrix, exponent)
            assert trace == diagonal_indicator_sum
            assert diagonal_indicator_sum == QQ(len(fixed_states))
            assert QQ(len(fixed_states)) == QQ(fixed_count)
            assert trace == QQ(fixed_count)
            if fixed_count > 0:
                rational_input = QQ(fixed_count) / QQ(1)
                prime_vector = tuple((ZZ(prime), ZZ(power)) for prime, power in factor(ZZ(fixed_count)))
                assert rational_input > QQ(0)
                assert prod(ZZ(prime) ** ZZ(power) for prime, power in prime_vector) == fixed_count
                positive_count += 1
            else:
                assert trace == QQ(0)
                zero_count += 1
            trace_count += 1
        family_count += 1

# 一セル反転は奇数回で跡が零、偶数回で二となり、正値域の境界を両側から与える。
flip = {0: {(ZZ(0),): ZZ(1), (ZZ(1),): ZZ(0)}}
flip_matrix = transfer_matrix_from_kernel(transition_matrix(deterministic_weight_family(flip), 1))
assert transfer_trace(flip_matrix, 1) == QQ(0)
assert transfer_trace(flip_matrix, 2) == QQ(2)

assert family_count == ZZ(261)
assert trace_count == ZZ(2088)
assert positive_count + zero_count == trace_count
print('deterministic rule families checked:', family_count)
print('positive-exponent traces checked:', trace_count)
print('positive trace inputs factored:', positive_count)
print('zero trace inputs excluded:', zero_count)
print('single-cell flip boundary checked: 1')
print('RESULT: PASS')
