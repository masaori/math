# 対象ラベル: claim_finite_self_map_injective_iff_all_periodic
# 単射性が「全ての配位の最小前周期が 0 である」ことと同値であることを検査する。
# 併せて (⇒) の中間段（単射なら μ(y) ≥ 1 のとき (μ(y)-1, π(y)) が周期組になり最小性に反する）と
# (⇐) の中間段（μ(y) = 0 なら y = F(F^k y) となる k が存在する）を別々に検査する。
# 帰属: 有限集合と非負整数の等号・大小比較・加減法だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_maps = 0
tested_configurations = 0
for name, mapping in exhaustive_maps_with_larger_stage():
    state_count = len(mapping)
    injective = is_injective_by_definition(mapping)
    all_zero = True
    for y in range(state_count):
        prefix = iterate_map(mapping, y, 4 * state_count)
        mu, pi = direct_min_preperiod_period(prefix)
        assert pi >= 1, (name, y)
        # 周期組の衝突形: F^{μ+π} y = F^{μ} y
        assert prefix[mu + pi] == prefix[mu], (name, y)
        if injective and mu >= 1:
            m = mu - 1
            # F(F^{m+π} y) = F(F^{m} y) は成り立つ（上の衝突の書き換え）
            assert mapping[prefix[m + pi]] == mapping[prefix[m]], (name, y)
            # 単射性により F^{m+π} y = F^{m} y、すなわち m ∈ I(y) となり μ ≤ m に反するはず
            assert prefix[m + pi] == prefix[m], (name, y)
            raise AssertionError("injective map with mu >= 1: {} {}".format(name, y))
        if mu == 0:
            # y は周期点: n = π(y) ≥ 1, F^n y = y。k = n - 1 で y = F(F^k y)
            k = pi - 1
            assert mapping[prefix[k]] == y, (name, y)
        else:
            all_zero = False
        tested_configurations += 1
    assert injective == all_zero, name
    tested_maps += 1

print("maps checked: {}; configurations checked: {}".format(tested_maps, tested_configurations))
print("RESULT: PASS")
