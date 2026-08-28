# 対象ラベル: claim_neighborhood_assignment_subset_union_map_injective
# 本文の証明の各行を分けて検査する。U_N = U_M ⟹ N = M。
#   (r) N(v) = U_N({v})   （一元部分集合からの復元）
#   (s) U_N({v}) = U_M({v}) （仮定 U_N = U_M）
#   (t) U_M({v}) = M(v)   （一元部分集合からの復元）
#   (u) 写像の外延性による N = M
# 対偶として、相異なる二つの割り当ての全表が必ず異なることを全数走査で確認し、
# 割り当ての個数と合併写像の像の個数が一致することも記録する。
# 帰属: 有限集合と有限部分集合だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

pairs = 0
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    assignments = neighborhood_assignments(cells)
    tables = {}
    for N in assignments:
        key = tuple(sorted(union_map_table(cells, N).items(), key=lambda kv: sorted(kv[0])))
        assert key not in tables  # 相異なる割り当ては相異なる表を与える
        tables[key] = N
    # 割り当ての個数と表の個数が一致する（単射性の像側での言い換え）
    assert len(tables) == len(assignments)
    for N in assignments:
        for M in assignments:
            if union_map_table(cells, N) != union_map_table(cells, M):
                continue
            pairs += 1
            for v in cells:
                step_r = union_map_value(cells, N, frozenset((v,)))
                step_s = union_map_value(cells, M, frozenset((v,)))
                assert N[v] == step_r
                assert step_r == step_s
                assert step_s == M[v]
            # (u) 写像の外延性
            assert N == M

print("equal-table pairs scanned:", pairs)
print("PASS check_injectivity")
