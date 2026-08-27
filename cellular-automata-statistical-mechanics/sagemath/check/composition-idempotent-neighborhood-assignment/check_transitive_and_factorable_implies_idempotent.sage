# 対象ラベル: claim_composition_idempotent_neighborhood_assignment_characterization
# 本文の証明の後半（推移的かつ二段分解可能ならば N star N = N）を段ごとに検査する。
#   (e) w in (N star N)(v) ⟹ w in N(v)（合成近傍の定義と推移性）
#   (f) w in N(v) ⟹ w in (N star N)(v)（二段分解可能性と合成近傍の定義）
#   (g) 集合の外延性から (N star N)(v) = N(v)
#   (h) v の任意性と写像の外延性から N star N = N
# 帰属: 有限集合と有限部分集合だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

candidate_count = 0
inclusion_pairs = 0

for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    for N in neighborhood_assignments(cells):
        if not (is_transitive(cells, N) and is_two_step_factorable(cells, N)):
            continue
        candidate_count += 1
        NN = compose(cells, N, N)
        for v in cells:
            for w in NN[v]:
                # (e) 合成近傍の定義で証人を取り出し、推移性を適用する
                witnesses = [u for u in N[v] if w in N[u]]
                assert len(witnesses) >= 1
                u = witnesses[0]
                assert u in N[v] and w in N[u]
                assert w in N[v]
                inclusion_pairs += 1
            for w in N[v]:
                # (f) 二段分解可能性の証人から合成近傍への所属を出す
                witnesses = [u for u in N[v] if w in N[u]]
                assert len(witnesses) >= 1
                u = witnesses[0]
                assert u in N[v] and w in N[u]
                assert w in NN[v]
                inclusion_pairs += 1
            # (g) 両包含から集合の等号
            assert set(NN[v]) <= set(N[v])
            assert set(N[v]) <= set(NN[v])
            assert NN[v] == N[v]
        # (h) 写像の外延性
        assert NN == N
        assert is_idempotent(cells, N)

print("transitive and factorable assignments:", candidate_count)
print("inclusion memberships checked:", inclusion_pairs)
print("PASS check_transitive_and_factorable_implies_idempotent")
