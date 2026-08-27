# 対象ラベル: claim_all_self_transpose_assignments_composition_closed_iff_subsingleton
# 「|V| <= 1 ⇒ 閉性」の向き。本文の同値の連鎖
#   w ∈ (N star M)(v)
#     ⟺ ∃u ∈ V, u ∈ N(v) ∧ w ∈ M(u)      (合成近傍の定義)
#     ⟺ v ∈ N(v) ∧ w ∈ M(v)               (|V| <= 1 より u = v)
#     ⟺ v ∈ N(v) ∧ v ∈ M(v)               (|V| <= 1 より w = v)
#     ⟺ v ∈ M(v) ∧ v ∈ N(v)               (連言の交換)
#     ⟺ ∃u ∈ V, u ∈ M(v) ∧ w ∈ N(u)
#     ⟺ w ∈ (M star N)(v)                 (合成近傍の定義)
# を各段に分けて検査し、外延性から N star M = M star N、同値の逆向きから合成の自己転置性を出す。
# 帰属: 有限集合と有限写像表だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

step_count = 0
pair_count = 0

for n in (0, 1):
    cells = tuple(range(n))
    witnesses = self_transpose_assignments(cells)
    # |V| <= 1 では全ての割り当てが自己転置である（1 個または 2 個）
    assert len(witnesses) == len(neighborhood_assignments(cells))
    for N in witnesses:
        for M in witnesses:
            pair_count += 1
            NM = compose(cells, N, M)
            MN = compose(cells, M, N)
            for v in cells:
                for w in cells:
                    step_count += 1
                    first = w in NM[v]
                    second = any((u in N[v]) and (w in M[u]) for u in cells)
                    third = (v in N[v]) and (w in M[v])
                    fourth = (v in N[v]) and (v in M[v])
                    fifth = (v in M[v]) and (v in N[v])
                    sixth = any((u in M[v]) and (w in N[u]) for u in cells)
                    seventh = w in MN[v]
                    assert first == second     # 合成近傍の定義
                    assert second == third     # |V| <= 1 より u = v
                    assert third == fourth     # |V| <= 1 より w = v
                    assert fourth == fifth     # 連言の交換
                    assert fifth == sixth      # |V| <= 1 より u = v かつ w = v
                    assert sixth == seventh    # 合成近傍の定義
            # 二回の外延性
            assert NM == MN
            # claim_self_transpose_composition_iff_commute の逆向き
            assert transpose(cells, NM) == NM
    # 定義そのもの
    assert closed_st(cells)

print("PASS subsingleton_closure pairs={} equivalence_steps={}".format(
    pair_count, step_count
))
