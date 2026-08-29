# 対象ラベル: claim_finite_self_map_injectivity_finite_decidability
# 全ての配位 y について最小前周期を「最小前周期と最小周期」の章の有限走査で求め、
# 全て 0 であることと単射性の一致を検査する。走査する配位の個数が |A^V| であることも数える。
# 帰属: 有限集合と非負整数の等号・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_maps = 0
tested_configurations = 0
for name, mapping in exhaustive_maps_with_larger_stage():
    state_count = len(mapping)
    scanned = 0
    all_zero = True
    for y in range(state_count):
        prefix = iterate_map(mapping, y, 4 * state_count)
        mu, pi, _ = scanned_min_preperiod_period(prefix, state_count)
        assert (mu, pi) == direct_min_preperiod_period(prefix), (name, y)
        if mu != 0:
            all_zero = False
        scanned += 1
    assert scanned == state_count, name
    assert all_zero == is_injective_by_definition(mapping), name
    tested_configurations += scanned
    tested_maps += 1

print("maps checked: {}; configurations scanned: {}".format(tested_maps, tested_configurations))
print("RESULT: PASS")
