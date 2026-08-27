# 対象ラベル: claim_invertible_neighborhood_assignments_are_permutations
# 本文の証明の前半（可逆 ⇒ 各 N(v) が一元集合）の各段を分けて検査する。
#   (a) (N star M)(v) = {v}                                   (N star M = I_V)
#   (b) ある u in N(v) が存在して v in M(u)。特に N(v) != ∅   (合成近傍の定義)
#   (c) 任意の u in N(v) について M(u) ⊆ (N star M)(v) = {v}
#   (d) (M star N)(u) = {u} は空でないので M(u) != ∅           (合成近傍の定義)
#   (e) M(u) = {v}                                             ((c) と (d))
#   (f) {u} = (M star N)(u) = ∪_{x in M(u)} N(x) = N(v)        (合成近傍の定義と (e))
# 最終式だけの一致で済ませず、各段を独立に検査する。
# 帰属: 有限集合と有限写像表だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

pair_count = 0
singleton_count = 0

for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    I = identity_assignment(cells)
    for N in neighborhood_assignments(cells):
        for M in inverses(cells, N):
            pair_count += 1
            for v in cells:
                # (a)
                assert compose(cells, N, M)[v] == frozenset((v,))
                # (b)
                witnesses = [u for u in N[v] if v in M[u]]
                assert len(witnesses) >= 1
                assert N[v] != frozenset()
                for u in N[v]:
                    # (c)
                    assert set(M[u]) <= set(compose(cells, N, M)[v])
                    assert set(M[u]) <= {v}
                    # (d)
                    assert compose(cells, M, N)[u] == frozenset((u,))
                    assert M[u] != frozenset()
                    # (e)
                    assert M[u] == frozenset((v,))
                    # (f) 三つの等号を分けて検査する
                    left = frozenset((u,))
                    middle = compose(cells, M, N)[u]
                    expanded = frozenset().union(*[set(N[x]) for x in M[u]])
                    assert left == middle
                    assert middle == expanded
                    assert expanded == N[v]
                # N(v) は一元集合である
                assert len(N[v]) == 1
                singleton_count += 1

print("PASS check_invertible_forces_singleton")
print("  (N, M) pairs with N star M = I_V = M star N:", pair_count)
print("  singleton values checked:", singleton_count)
