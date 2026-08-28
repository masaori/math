# 対象ラベル: claim_neighborhood_assignment_subset_union_map_finite_decidable
# 併せて検査するラベル: def_finite_stage_subset_space
# 本文の有限決定の論証を段ごとに分けて検査する。
#   (z1) 入力集合 Sub(V) の元数は 2^{|V|} であり、全表を列挙できる
#   (z2) 各 U_N(S) は有限個の N(v) の有限合併として、セルごとの所属判定だけで決まる
#   (z3) 冪等性 U_N ∘ U_N = U_N の真偽は、全 S と全セルの所属判定の連言として決まる
#        （表の等号による判定と一致する）
# 計算コストモデルそのものは検査していない。判定の一致だけを検査する。
# 帰属: 有限集合と有限部分集合だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

scanned = 0
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    all_subsets = tuple(subsets(cells))
    # (z1) 入力集合の個数
    assert len(all_subsets) == 2 ** n
    for N in neighborhood_assignments(cells):
        scanned += 1
        # (z2) 所属判定だけで組んだ表が、合併で組んだ表に一致する
        by_membership = {
            S: frozenset(w for w in cells if any(w in N[v] for v in S))
            for S in all_subsets
        }
        table = union_map_table(cells, N)
        assert by_membership == table
        # (z3) 冪等性を所属判定の連言として決める
        decided = all(
            (w in union_map_value(cells, N, table[S])) == (w in table[S])
            for S in all_subsets
            for w in cells
        )
        by_tables = {S: union_map_value(cells, N, table[S]) for S in all_subsets} == table
        assert decided == by_tables

print("assignments scanned:", scanned)
print("PASS check_finite_decidability")
