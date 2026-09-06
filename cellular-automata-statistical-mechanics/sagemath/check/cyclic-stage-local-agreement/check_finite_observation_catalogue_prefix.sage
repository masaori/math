# 対象ラベル: claim_integer_stage_finite_observation_catalogue_countable
# 式ペア・判定: 半径ごとの有限状態表を、先行する半径の表数を始点とする互いに素な
#               自然数区間へ写し、可算非交和の符号化機構を有限接頭辞で検算する。
# 帰属: 有限集合と NN。浮動小数点、除算、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))


def binary_value(observation):
    value = ZZ(0)
    for state in observation:
        value = ZZ(2) * value + ZZ(state)
    return value


def stage_start(radius):
    return sum(ZZ(2) ** ZZ(2 * earlier_radius + 1)
               for earlier_radius in range(radius))


maximum_radius = 8
encoded = {}
for radius in range(maximum_radius + 1):
    window_size = 2 * radius + 1
    stage_observations = configurations(window_size)
    start = stage_start(radius)
    stage_codes = set()

    for observation in stage_observations:
        code = start + binary_value(observation)
        assert start <= code < start + ZZ(2) ** ZZ(window_size)
        assert code not in encoded
        encoded[code] = (radius, observation)
        stage_codes.add(code)

    assert stage_codes == set(range(start, start + ZZ(2) ** ZZ(window_size)))

expected_total = stage_start(maximum_radius + 1)
assert set(encoded) == set(range(expected_total))
assert len(encoded) == expected_total
assert all(encoded[stage_start(radius) + binary_value(observation)] == (radius, observation)
           for radius in range(maximum_radius + 1)
           for observation in configurations(2 * radius + 1))

print('catalogue radii checked:', maximum_radius + 1)
print('catalogue prefix codes checked:', len(encoded))
print('RESULT: PASS')
