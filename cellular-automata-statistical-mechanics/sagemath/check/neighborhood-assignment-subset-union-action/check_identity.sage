# 対象ラベル: claim_identity_neighborhood_subset_union_map
# 併せて検査するラベル: def_identity_neighborhood_assignment
# 本文の証明の各行を分けて検査する。U_{I_V} = id_{Sub(V)}。
#   (k) w in U_{I_V}(S) ⟺ ∃v in S, w in {v}   （合併写像の定義）
#   (l) ⟺ ∃v in S, w = v                      （一元集合への所属）
#   (m) ⟺ w in S                              （等号による置換）
#   (n) 各 S での部分集合の等号と、写像としての恒等写像との等号
# 帰属: 有限集合と有限部分集合だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

scanned = 0
for n in (0, 1, 2, 3, 4):
    cells = tuple(range(n))
    identity = identity_assignment(cells)
    for S in subsets(cells):
        scanned += 1
        value = union_map_value(cells, identity, S)
        for w in cells:
            step_k = any(w in identity[v] for v in S)
            step_l = any(w == v for v in S)
            step_m = w in S
            assert (w in value) == step_k
            assert step_k == step_l
            assert step_l == step_m
        # (n) 部分集合の外延性
        assert value == S
    # (n) 写像の外延性（全表が恒等写像の表に一致する）
    assert union_map_table(cells, identity) == {S: S for S in subsets(cells)}

print("subsets scanned:", scanned)
print("PASS check_identity")
