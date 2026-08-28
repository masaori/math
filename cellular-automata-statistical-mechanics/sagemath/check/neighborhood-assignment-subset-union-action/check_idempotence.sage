# 対象ラベル: claim_neighborhood_assignment_idempotent_iff_subset_union_map_idempotent
# 本文の証明の各行を分けて検査する。N star N = N ⟺ U_N ∘ U_N = U_N。
#   (v) 順方向: U_N ∘ U_N = U_{N star N}（合成の claim）で書き換え、仮定 N star N = N で U_N を得る
#   (w) 逆方向: U_{N star N} = U_N ∘ U_N（合成の claim）で書き換え、仮定で U_N を得る
#   (x) そこへ単射性の claim を N star N と N に適用して N star N = N を得る
#   (y) 二つの述語（合成冪等性・写像の冪等性）が全走査で一致する
# 帰属: 有限集合と有限部分集合だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

scanned = 0
idempotent_count = 0
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    all_subsets = tuple(subsets(cells))
    for N in neighborhood_assignments(cells):
        scanned += 1
        squared = compose(cells, N, N)
        table_N = union_map_table(cells, N)
        table_squared = union_map_table(cells, squared)
        table_twice = {S: union_map_value(cells, N, table_N[S]) for S in all_subsets}
        # 合成の claim（この章の前段）: U_{N star N} = U_N ∘ U_N
        assert table_squared == table_twice
        composition_idempotent = squared == N
        map_idempotent = table_twice == table_N
        if composition_idempotent:
            idempotent_count += 1
            # (v) 順方向
            assert table_twice == table_squared
            assert table_squared == table_N
            assert map_idempotent
        if map_idempotent:
            # (w) 逆方向の書き換え
            assert table_squared == table_twice
            assert table_twice == table_N
            # (x) 単射性の適用（等しい表を持つ二つの割り当ては等しい）
            assert squared == N
            assert composition_idempotent
        # (y) 二つの述語の一致
        assert composition_idempotent == map_idempotent

print("assignments scanned:", scanned)
print("composition-idempotent assignments:", idempotent_count)
print("PASS check_idempotence")
