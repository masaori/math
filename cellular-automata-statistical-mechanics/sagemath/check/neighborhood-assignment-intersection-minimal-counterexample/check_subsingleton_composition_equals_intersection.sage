# 対象ラベル: claim_subsingleton_neighborhood_composition_equals_intersection
# |V| <= 1 の全ての近傍割り当ての組で N*M = N⊓M を検査する。
# 本文の証明の各段を分けて検査する。
#   w ∈ (N*M)(v) ⟺ ∃u ∈ N(v), w ∈ M(u)   （合成近傍の定義）
#   存在文が成り立つなら証人 u に対し u = v = w （|V| <= 1 より任意の二元が等しい）
#   逆向きは u := w と取る
#   よって w ∈ (N*M)(v) ⟺ w ∈ N(v) ∧ w ∈ M(v) ⟺ w ∈ (N⊓M)(v)
# 帰属: 有限集合と有限写像だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

pair_count = 0
witness_step_count = 0

for size in (0, 1):
    cells = tuple(range(size))
    assignments = neighborhood_assignments(cells)
    for N in assignments:
        for M in assignments:
            pair_count += 1
            composed = compose(cells, N, M)
            meet = pointwise_intersection(cells, N, M)
            for v in cells:
                for w in cells:
                    # 第一段: 合成近傍の所属は存在文と同値
                    exists_witness = any(w in M[u] for u in N[v])
                    assert (w in composed[v]) == exists_witness

                    # 第二段: |V| <= 1 なので任意の二元が等しい
                    assert v == w
                    for u in N[v]:
                        assert u == v and u == w
                        witness_step_count += 1

                    # 第三段: 存在文と論理積の同値（両方向）
                    conjunction = (w in N[v]) and (w in M[v])
                    if exists_witness:
                        assert conjunction
                    if conjunction:
                        # u := w が証人になる
                        assert w in N[v] and w in M[w]
                        assert any(w in M[u] for u in N[v])

                    # 第四段: 論理積は点ごとの積への所属
                    assert conjunction == (w in meet[v])

            # 第五段: 外延性による写像の等号
            assert composed == meet

print("PASS subsingleton_composition_equals_intersection pairs={} witness_steps={}".format(
    pair_count, witness_step_count
))
