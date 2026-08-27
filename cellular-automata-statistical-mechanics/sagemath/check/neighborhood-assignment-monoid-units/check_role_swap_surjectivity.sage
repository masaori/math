# 対象ラベル: claim_invertible_neighborhood_assignments_are_permutations
# 本文の証明のうち、sigma の全射性を舞台の有限性を使わずに出す段を分けて検査する。
# 前 tick までの本文は「有限集合の単射な自己写像は全単射である」を使っていたが、
# 現在の本文は一元性の論証を N と M の役割を入れ替えて適用し、右逆写像 tau を作る。
#   (i-1) 役割交換: 各 u について M(u) が一元集合 {tau(u)} であり、かつ N(tau(u)) = {u} である
#         （check_invertible_forces_singleton の (a)-(f) を N と M を入れ替えて辿る）
#   (i-2) {sigma(tau(u))} = N(tau(u)) = {u} なので sigma(tau(u)) = u である
#   (i-3) 任意の u が sigma の値なので sigma は全射である（個数を数えない）
# (i-3) では単射性・元数・置換の全列挙を一切使わず、witness tau(u) の提示だけで全射性を出す。
# 帰属: 有限集合と有限写像表だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

pair_count = 0
tau_value_count = 0

for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    for N in neighborhood_assignments(cells):
        for M in inverses(cells, N):
            pair_count += 1
            # sigma は N(v) の唯一の元として定まる（本文の (g)）
            sigma = []
            for v in cells:
                assert len(N[v]) == 1
                (u,) = tuple(N[v])
                sigma.append(u)
            sigma = tuple(sigma)
            for u in cells:
                # (i-1) 役割交換した一元性の論証を、各段を分けて辿る
                assert compose(cells, M, N)[u] == frozenset((u,))
                witnesses = [w for w in M[u] if u in N[w]]
                assert len(witnesses) >= 1
                assert M[u] != frozenset()
                for w in M[u]:
                    assert set(N[w]) <= set(compose(cells, M, N)[u])
                    assert set(N[w]) <= {u}
                    assert compose(cells, N, M)[w] == frozenset((w,))
                    assert N[w] != frozenset()
                    assert N[w] == frozenset((u,))
                    left = frozenset((w,))
                    middle = compose(cells, N, M)[w]
                    expanded = frozenset().union(*[set(M[x]) for x in N[w]])
                    assert left == middle
                    assert middle == expanded
                    assert expanded == M[u]
                assert len(M[u]) == 1
                (tau_u,) = tuple(M[u])
                assert N[tau_u] == frozenset((u,))
                tau_value_count += 1
                # (i-2) 二つの等号を分けて検査する
                assert frozenset((sigma[tau_u],)) == N[tau_u]
                assert N[tau_u] == frozenset((u,))
                assert sigma[tau_u] == u
                # (i-3) u は sigma の値である（witness は tau(u)）
                assert any(sigma[v] == u for v in cells)

print("PASS check_role_swap_surjectivity")
print("  (N, M) pairs with N star M = I_V = M star N:", pair_count)
print("  tau values constructed by role swap:", tau_value_count)
