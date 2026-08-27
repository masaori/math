# 対象ラベル: claim_composition_idempotent_neighborhood_assignment_finite_decidable
# 本文の有限決定の論証を、判定手続きごとに分けて検査する。
#   (n) 推移性は V^3 の全組の列挙で決定できる（定義そのものの走査と一致する）
#   (o) 二段分解可能性は V^2 の全組について N(v) を走査すれば決定できる
#   (p) (n) と (o) の二つの有限検査から、特徴づけにより合成冪等性を決定できる
#       （合成近傍を作って比較する判定と一致する）
# 計算コストモデルそのものは検査していない。判定の一致だけを検査する。
# 帰属: 有限集合と有限部分集合だけを使う。浮動小数点と R/C 脱出はない。

import os
from itertools import product as _product
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

scanned = 0
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    for N in neighborhood_assignments(cells):
        scanned += 1
        # (n) V^3 の全列挙による推移性の判定
        by_triples = all(
            (w in N[v]) or not (u in N[v] and w in N[u])
            for (v, u, w) in _product(cells, repeat=3)
        )
        assert by_triples == is_transitive(cells, N)
        # (o) V^2 の全列挙と N(v) の走査による二段分解可能性の判定
        by_pairs = all(
            (w not in N[v]) or any(w in N[u] for u in N[v])
            for (v, w) in _product(cells, repeat=2)
        )
        assert by_pairs == is_two_step_factorable(cells, N)
        # (p) 二つの有限検査の連言が、合成近傍の比較による判定と一致する
        assert (by_triples and by_pairs) == is_idempotent(cells, N)

print("assignments scanned:", scanned)
print("PASS check_finite_decidability")
