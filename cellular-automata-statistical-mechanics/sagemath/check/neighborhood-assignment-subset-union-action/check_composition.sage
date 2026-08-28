# 対象ラベル: claim_neighborhood_assignment_subset_union_map_composition
# 併せて検査するラベル: def_composed_neighborhood
# 本文の証明の各行を分けて検査する。U_{N star M} = U_M ∘ U_N。
#   (e) w in U_{N star M}(S) ⟺ ∃v in S, w in (N star M)(v)      （合併写像の定義）
#   (f) ⟺ ∃v in S, ∃u in N(v), w in M(u)                        （合成近傍の定義）
#   (g) ⟺ ∃u in V, (∃v in S, u in N(v)) ∧ w in M(u)             （有限存在量化の並べ替え）
#   (h) ⟺ ∃u in U_N(S), w in M(u)                               （合併写像の定義）
#   (i) ⟺ w in U_M(U_N(S))                                      （合併写像の定義）
#   (j) 各 S での部分集合の等号と、写像としての等号
# 合成の向き（U_M ∘ U_N であって U_N ∘ U_M ではない）が本質であることも、
# 一致しない反例が存在することで確認する。
# 帰属: 有限集合と有限部分集合だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

scanned = 0
order_matters_witness = None
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    all_subsets = tuple(subsets(cells))
    for N in neighborhood_assignments(cells):
        for M in neighborhood_assignments(cells):
            scanned += 1
            composed = compose(cells, N, M)
            for S in all_subsets:
                left = union_map_value(cells, composed, S)
                image = union_map_value(cells, N, S)
                right = union_map_value(cells, M, image)
                for w in cells:
                    step_e = any(w in composed[v] for v in S)
                    step_f = any(any(w in M[u] for u in N[v]) for v in S)
                    step_g = any(
                        any(u in N[v] for v in S) and (w in M[u]) for u in cells
                    )
                    step_h = any(w in M[u] for u in image)
                    step_i = w in right
                    assert (w in left) == step_e
                    assert step_e == step_f
                    assert step_f == step_g
                    assert step_g == step_h
                    assert step_h == step_i
                # (j) 部分集合の外延性による各 S での等号
                assert left == right
            # (j) 写像の外延性による全表の等号
            assert union_map_table(cells, composed) == {
                S: union_map_value(cells, M, union_map_value(cells, N, S))
                for S in all_subsets
            }
            if order_matters_witness is None:
                other = {
                    S: union_map_value(cells, N, union_map_value(cells, M, S))
                    for S in all_subsets
                }
                if union_map_table(cells, composed) != other:
                    order_matters_witness = (n, N, M)

# 合成の向きが効いている（U_N ∘ U_M では一致しない例がある）
assert order_matters_witness is not None
print("order-sensitivity witness (|V|, N, M):", order_matters_witness)
print("pairs scanned:", scanned)
print("PASS check_composition")
