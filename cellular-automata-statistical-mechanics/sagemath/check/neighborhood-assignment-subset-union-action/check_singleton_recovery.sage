# 対象ラベル: claim_neighborhood_assignment_recovered_from_singletons
# 本文の証明の各行を分けて検査する。U_N({v}) = N(v)。
#   (o) w in U_N({v}) ⟺ ∃u in {v}, w in N(u)  （合併写像の定義）
#   (p) ⟺ w in N(v)                            （一元集合への所属）
#   (q) 部分集合の外延性による等号
# あわせて、一元部分集合への値だけから元の割り当ての全表を復元できることを検査する。
# 帰属: 有限集合と有限部分集合だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

scanned = 0
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    for N in neighborhood_assignments(cells):
        scanned += 1
        for v in cells:
            singleton = frozenset((v,))
            value = union_map_value(cells, N, singleton)
            for w in cells:
                step_o = any(w in N[u] for u in singleton)
                step_p = w in N[v]
                assert (w in value) == step_o
                assert step_o == step_p
            # (q) 部分集合の外延性
            assert value == N[v]
        # 一元部分集合への値だけからの復元
        recovered = tuple(
            union_map_value(cells, N, frozenset((v,))) for v in cells
        )
        assert recovered == N

print("assignments scanned:", scanned)
print("PASS check_singleton_recovery")
