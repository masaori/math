# 対象ラベル: claim_neighborhood_assignment_monoid_center_characterization
# 本文の証明の第三段。N ∈ Z_star(V) が p ∈ N(p) を満たすとき、任意の b ∈ V で b ∈ N(b) が成り立ち、
# したがって I_V(v) ⊆ N(v) が全ての v で成り立つことを、本文の同値の連鎖の段ごとに分けて検査する。
#   b ∈ (N star E_{p,b})(p)                        (p ∈ N(p) かつ b ∈ E_{p,b}(p))
#   b ∈ (N star E_{p,b})(p) ⟺ b ∈ (E_{p,b} star N)(p)   (中心の定義)
#   b ∈ (E_{p,b} star N)(p) ⟺ b ∈ N(b)              (E_{p,b}(p) = {b} と合成近傍の定義)
# 帰属: 有限集合と有限写像表だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

chain_count = 0
central_nonempty_count = 0

for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    I = identity_assignment(cells)
    O = empty_assignment(cells)
    for N in neighborhood_assignments(cells):
        if not is_central(cells, N):
            continue
        if N == O:
            continue
        central_nonempty_count += 1
        # 第二段で得た自己ループを持つ p を取る
        loops = [v for v in cells if v in N[v]]
        assert loops, "N ≠ O_V の中心の元に自己ループが無い"
        p = loops[0]
        for b in cells:
            chain_count += 1
            E = single_edge(cells, p, b)
            assert E[p] == frozenset((b,))
            left = compose(cells, N, E)
            right = compose(cells, E, N)
            # 第一段: p ∈ N(p) かつ b ∈ E_{p,b}(p) から b ∈ (N star E_{p,b})(p)
            assert p in N[p]
            assert b in E[p]
            assert b in left[p]
            # 第二段: 中心の定義による同値
            assert left == right
            assert (b in left[p]) == (b in right[p])
            # 第三段: E_{p,b}(p) = {b} と合成近傍の定義による同値
            assert right[p] == N[b]
            assert (b in right[p]) == (b in N[b])
            # 結論
            assert b in N[b]
        # b が任意なので I_V(v) ⊆ N(v)
        for v in cells:
            assert I[v] <= N[v]

print("PASS check_identity_inclusion_from_edge_witness")
print("  nonempty central assignments scanned:", central_nonempty_count)
print("  equivalence chains checked:", chain_count)
