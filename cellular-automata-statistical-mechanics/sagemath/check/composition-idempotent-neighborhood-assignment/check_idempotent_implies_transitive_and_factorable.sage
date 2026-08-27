# 対象ラベル: claim_composition_idempotent_neighborhood_assignment_characterization
# 本文の証明の前半（N star N = N ならば推移的かつ二段分解可能）を段ごとに検査する。
#   (a) u in N(v) かつ w in N(u) から w in (N star N)(v)（合成近傍の定義）
#   (b) (N star N)(v) = N(v) から w in N(v)（冪等性）→ 推移性
#   (c) w in N(v) から w in (N star N)(v)（冪等性）
#   (d) w in (N star N)(v) と ∃u in N(v), w in N(u) の同値（合成近傍の定義）→ 二段分解可能性
# 帰属: 有限集合と有限部分集合だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

idempotent_count = 0
transitive_triples = 0
factorable_pairs = 0

for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    for N in neighborhood_assignments(cells):
        if not is_idempotent(cells, N):
            continue
        idempotent_count += 1
        NN = compose(cells, N, N)
        for v in cells:
            for u in N[v]:
                for w in N[u]:
                    # (a) 合成近傍の定義による所属
                    assert w in NN[v]
                    # (b) 冪等性による書き換え
                    assert NN[v] == N[v]
                    assert w in N[v]
                    transitive_triples += 1
        assert is_transitive(cells, N)
        for v in cells:
            for w in N[v]:
                # (c) 冪等性による書き換え
                assert N[v] == NN[v]
                assert w in NN[v]
                # (d) 合成近傍の定義による存在文への同値
                witnesses = [u for u in N[v] if w in N[u]]
                assert (w in NN[v]) == (len(witnesses) >= 1)
                assert len(witnesses) >= 1
                factorable_pairs += 1
        assert is_two_step_factorable(cells, N)

print("idempotent assignments:", idempotent_count)
print("transitivity triples checked:", transitive_triples)
print("factorability pairs checked:", factorable_pairs)
print("PASS check_idempotent_implies_transitive_and_factorable")
