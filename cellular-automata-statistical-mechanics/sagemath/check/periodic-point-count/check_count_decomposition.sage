# 対象ラベル: claim_fixed_point_count_decomposition
# Fix_n の個数が、n を割り切る最小周期ごとの個数の和に等しいことを検査する。
# 帰属: 有限集合と非負整数の等号・加法・剰余だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_maps = 0
tested_exponents = 0
for name, mapping in exhaustive_maps():
    counts = minimal_period_counts(mapping)
    state_count = len(mapping)
    for exponent in range(1, 2 * state_count + 1):
        decomposed = sum(count for period, count in counts.items() if exponent % period == 0)
        assert fixed_point_count(mapping, exponent) == decomposed, (name, exponent, counts)
        tested_exponents += 1
    tested_maps += 1

print("maps checked: {}; exponents checked: {}".format(tested_maps, tested_exponents))
print("RESULT: PASS")
