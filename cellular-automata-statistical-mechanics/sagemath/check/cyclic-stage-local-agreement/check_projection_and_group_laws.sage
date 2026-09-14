# 対象ラベル: claim_cyclic_stage_is_finite_cyclic_group
# 併せて検証: claim_cyclic_stage_projection_preserves_addition
# 式ペア・判定: 剰余加法の保存、結合律、零元、逆元、生成元、全射性を別々に検査する。
# 帰属: 有限集合と ZZ。浮動小数点と R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

tested = 0
for length in range(1, 25):
    stage = cells(length)
    projection = lambda integer: ZZ(integer) % ZZ(length)
    addition = lambda left, right: projection(left + right)
    inverse = lambda value: projection(-value)
    zero = projection(0)

    for integer in range(-3 * length, 3 * length + 1):
        assert projection(integer) in stage
        assert projection(projection(integer)) == projection(integer)
        assert any(projection(candidate) == projection(integer) for candidate in stage)
        for other in range(-3 * length, 3 * length + 1):
            assert projection(integer + other) == addition(projection(integer), projection(other))
            tested += 1

    generated = {projection(multiplier) for multiplier in range(length)}
    assert generated == set(stage)
    for left in stage:
        assert addition(zero, left) == left
        assert addition(left, zero) == left
        assert addition(left, inverse(left)) == zero
        assert addition(inverse(left), left) == zero
        for middle in stage:
            for right in stage:
                assert addition(addition(left, middle), right) == addition(left, addition(middle, right))

assert tested > 0
print('integer pairs checked:', tested)
print('RESULT: PASS')
