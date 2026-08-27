# 対象ラベル: claim_invertible_neighborhood_assignments_are_permutations
# 本文の証明の後半（一元集合の唯一の元として sigma を定め、それが全単射で N = P_sigma になる）の
# 各段を分けて検査する。
#   (g) N(v) = {u} を満たす u が唯一に定まるので sigma(v) := u と置ける
#   (h) sigma(v) = sigma(v') ならば {v} = M(sigma(v)) = M(sigma(v')) = {v'} より v = v'
#   (i) 有限集合の単射な自己写像は全単射である
#   (j) def_permutation_neighborhood_assignment より N = P_sigma
#   (k) sigma は一元集合 N(v) の唯一の元なので一意である
# 帰属: 有限集合と有限写像表だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

invertible_count = 0

for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    for N in neighborhood_assignments(cells):
        if not is_invertible(cells, N):
            continue
        invertible_count += 1
        M = inverses(cells, N)[0]
        # (g) 各 v で N(v) の唯一の元を sigma(v) とする
        sigma = []
        for v in cells:
            assert len(N[v]) == 1
            (u,) = tuple(N[v])
            sigma.append(u)
        sigma = tuple(sigma)
        # (h) 単射性を本文と同じ経路（M(sigma(v)) = {v}）で確認する
        for v in cells:
            assert M[sigma[v]] == frozenset((v,))
        for v in cells:
            for w in cells:
                if sigma[v] == sigma[w]:
                    assert M[sigma[v]] == M[sigma[w]]
                    assert frozenset((v,)) == frozenset((w,))
                    assert v == w
        # (i) 単射かつ有限なので全単射である
        assert len(set(sigma)) == len(cells)
        assert set(sigma) == set(cells)
        # (j) N = P_sigma
        assert N == permutation_assignment(cells, sigma)
        # (k) sigma の一意性: N = P_tau なら tau = sigma
        for tau in permutations(cells):
            if permutation_assignment(cells, tau) == N:
                assert tau == sigma

print("PASS check_permutation_from_invertible")
print("  invertible assignments checked:", invertible_count)
