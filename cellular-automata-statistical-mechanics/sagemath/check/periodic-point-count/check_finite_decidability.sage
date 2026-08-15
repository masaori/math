# 対象ラベル: claim_fixed_point_count_finite_decidability
# 全状態を一度ずつ検査して得る個数が Fix_n の直接構成の個数と一致することを検査する。
# 帰属: 有限集合と非負整数の等号・加法だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_maps = 0
tested_exponents = 0
tested_equalities = 0
for name, mapping in exhaustive_maps():
    state_count = len(mapping)
    for exponent in range(1, 2 * state_count + 1):
        fixed_states = {
            initial
            for initial in range(state_count)
            if iterate_map(mapping, initial, exponent)[exponent] == initial
        }
        scanned_count = fixed_point_count(mapping, exponent)
        assert scanned_count == len(fixed_states), (name, exponent)
        tested_equalities += state_count
        tested_exponents += 1
    tested_maps += 1

print("maps checked: {}; exponents checked: {}; equality checks: {}".format(
    tested_maps, tested_exponents, tested_equalities
))
print("RESULT: PASS")
