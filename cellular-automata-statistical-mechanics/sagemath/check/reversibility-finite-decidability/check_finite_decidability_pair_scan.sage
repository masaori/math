# 対象ラベル: claim_finite_self_map_injectivity_finite_decidability
# 全ての対 (y, y') を走査して F y = F y' かつ y ≠ y' の対が無いことと、単射性の一致を検査する。
# 走査する対の個数が |A^V|^2 であることも数える。
# 帰属: 有限集合と非負整数の等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_maps = 0
tested_pairs = 0
for name, mapping in exhaustive_maps_with_larger_stage():
    state_count = len(mapping)
    scanned_pairs = 0
    counterexample_found = False
    for y in range(state_count):
        for y_prime in range(state_count):
            scanned_pairs += 1
            if mapping[y] == mapping[y_prime] and y != y_prime:
                counterexample_found = True
    assert scanned_pairs == state_count ** 2, name
    assert (not counterexample_found) == is_injective_by_definition(mapping), name
    assert (not counterexample_found) == is_surjective_by_definition(mapping), name
    tested_pairs += scanned_pairs
    tested_maps += 1

print("maps checked: {}; pairs scanned: {}".format(tested_maps, tested_pairs))
print("RESULT: PASS")
