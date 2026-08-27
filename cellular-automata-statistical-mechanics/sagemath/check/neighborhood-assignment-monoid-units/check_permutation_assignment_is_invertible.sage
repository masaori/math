# 対象ラベル: claim_invertible_neighborhood_assignments_are_permutations
# 本文の証明の逆向き（全単射 sigma から P_sigma が可逆であること）の式変形を一行ずつ検査する。
#   (P_sigma star P_{sigma^{-1}})(v)
#     = ∪_{u in {sigma(v)}} {sigma^{-1}(u)}   (合成近傍の定義と P_sigma の定義)
#     = {sigma^{-1}(sigma(v))}                (一元集合を添字とする合併)
#     = {v}                                   (sigma^{-1} ∘ sigma = id_V)
#     = I_V(v)                                (自己近傍割り当ての定義)
# 逆向きの合成 P_{sigma^{-1}} star P_sigma = I_V も同じ形で分けて検査し、
# 写像の外延性（全ての v で一致すること）から二つの合成の等号を出す。
# 帰属: 有限集合と有限写像表だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

permutation_count = 0

for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    I = identity_assignment(cells)
    for sigma in permutations(cells):
        permutation_count += 1
        inverse = inverse_permutation(cells, sigma)
        P = permutation_assignment(cells, sigma)
        Q = permutation_assignment(cells, inverse)
        for v in cells:
            # 一行目: 合成近傍の定義と P_sigma の定義による展開
            line1 = frozenset().union(*[set(Q[u]) for u in P[v]])
            assert P[v] == frozenset((sigma[v],))
            assert line1 == compose(cells, P, Q)[v]
            # 二行目: 一元集合を添字とする合併
            line2 = frozenset((inverse[sigma[v]],))
            assert line1 == line2
            # 三行目: sigma^{-1} ∘ sigma = id_V
            assert inverse[sigma[v]] == v
            line3 = frozenset((v,))
            assert line2 == line3
            # 四行目: 自己近傍割り当ての定義
            assert line3 == I[v]

            # 逆向きの合成も同じ形で分けて検査する
            rline1 = frozenset().union(*[set(P[u]) for u in Q[v]])
            assert Q[v] == frozenset((inverse[v],))
            assert rline1 == compose(cells, Q, P)[v]
            rline2 = frozenset((sigma[inverse[v]],))
            assert rline1 == rline2
            assert sigma[inverse[v]] == v
            assert rline2 == I[v]
        # 写像の外延性
        assert compose(cells, P, Q) == I
        assert compose(cells, Q, P) == I
        # def_invertible_neighborhood_assignment の所属条件
        assert is_invertible(cells, P)
        assert Q in inverses(cells, P)

print("PASS check_permutation_assignment_is_invertible")
print("  permutations checked:", permutation_count)
