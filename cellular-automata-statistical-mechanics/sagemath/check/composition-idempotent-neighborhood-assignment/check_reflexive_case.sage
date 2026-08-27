# 対象ラベル: claim_reflexive_neighborhood_assignment_idempotent_iff_transitive
# 自己近傍を含む割り当てについて、本文の証明の各段を検査する。
#   (i) 冪等 ⟹ 推移的（特徴づけの前半）
#   (j) 推移的な N と w in N(v) について、u := w が二段分解の存在証人になる
#       （w in N(v) と自己近傍の包含 w in N(w)）
#   (k) 二段分解可能性と推移性から特徴づけにより冪等
# 帰属: 有限集合と有限部分集合だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

reflexive_count = 0
witness_count = 0

for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    for N in neighborhood_assignments(cells):
        if not is_reflexive(cells, N):
            continue
        reflexive_count += 1
        # (i) 冪等ならば推移的
        if is_idempotent(cells, N):
            assert is_transitive(cells, N)
        # (j) 推移的ならば u := w が二段分解の証人である
        if is_transitive(cells, N):
            for v in cells:
                for w in N[v]:
                    u = w
                    assert u in N[v]
                    assert w in N[u]
                    witness_count += 1
            assert is_two_step_factorable(cells, N)
            # (k) 特徴づけにより冪等
            assert is_idempotent(cells, N)
        # 同値そのもの
        assert is_idempotent(cells, N) == is_transitive(cells, N)

print("reflexive assignments:", reflexive_count)
print("self witnesses checked:", witness_count)
print("PASS check_reflexive_case")
